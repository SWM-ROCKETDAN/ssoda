package com.rocketdan.serviceserver.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.rocketdan.serviceserver.Exception.analysis.AnalysisServerErrorException;
import com.rocketdan.serviceserver.Exception.join.JoinEventFailedException;
import com.rocketdan.serviceserver.Exception.resource.NoAuthorityToResourceException;
import com.rocketdan.serviceserver.app.dto.reward.RewardUpdateRequestDto;
import com.rocketdan.serviceserver.config.AnalysisServerConfig;
import com.rocketdan.serviceserver.config.auth.UserIdValidCheck;
import com.rocketdan.serviceserver.core.CommonResponse;
import com.rocketdan.serviceserver.domain.event.RewardPolicy;
import com.rocketdan.serviceserver.s3.service.UpdateImageService;
import com.rocketdan.serviceserver.web.dto.reward.RewardLevelResponseDto;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import com.rocketdan.serviceserver.app.dto.reward.RewardResponseDto;
import com.rocketdan.serviceserver.app.dto.reward.RewardSaveRequestDto;
import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.EventRepository;
import com.rocketdan.serviceserver.domain.reward.Reward;
import com.rocketdan.serviceserver.domain.reward.RewardRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@RequiredArgsConstructor
@Service
public class RewardService {
    private final RewardRepository rewardRepository;
    private final EventRepository eventRepository;

    private final AnalysisServerConfig analysisServerConfig;

    private final UpdateImageService updateImageService;

    private final UserIdValidCheck userIdValidCheck;

    @Transactional
    public Long save(Long event_id, RewardSaveRequestDto requestDto, org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        Event linkedEvent = eventRepository.findById(event_id).orElseThrow(() -> new IllegalArgumentException("해당 이벤트가 없습니다. id=" + event_id));

        // valid 하지 않으면 exception 발생
        userIdValidCheck.userIdValidCheck(linkedEvent.getStore().getUser().getUserId(), principal);

        // 이미지
        String imgPath = updateImageService.uploadNewImage(requestDto.getImage(), "image/reward");

        Reward savedReward = requestDto.toEntity(imgPath);

        // link event
        savedReward.setEvent(linkedEvent);

        return rewardRepository.save(savedReward).getId();
    }

    @Transactional
    public Long update(RewardUpdateRequestDto requestDto, org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        Reward reward = rewardRepository.findById(requestDto.getId()).orElseThrow(() -> new IllegalArgumentException("해당 리워드가 없습니다. id=" + requestDto.getId()));

        // valid 하지 않으면 exception 발생
        userIdValidCheck.userIdValidCheck(reward.getEvent().getStore().getUser().getUserId(), principal);

        // 이미지
        String imgPath = updateImageService.uploadNewImage(requestDto.getImage(), "image/reward");

        if (Optional.ofNullable(imgPath).isPresent()) { // image가 포함된 request가 온 경우
            updateImageService.deleteImagePath(reward.getImagePath()); // 기존에 저장돼있었던 이미지 삭제
        } else { // image가 null로 온 경우
            imgPath = reward.getImagePath(); // 기존 이미지로 지정
        }

        Reward updatedReward = requestDto.toEntity(imgPath);

        // link event
        updatedReward.setEvent(reward.getEvent());

        // delete & save
        rewardRepository.delete(reward);
        return rewardRepository.save(updatedReward).getId();
    }

    @Transactional(readOnly = true)
    public RewardResponseDto findById(Long id) {
        Reward entity = rewardRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 리워드가 없습니다. id=" + id));
        return new RewardResponseDto(entity);
    }

    @Transactional
    public void softDelete(Long id, org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        Reward reward = rewardRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 리워드가 없습니다. id=" + id));

        // valid 하지 않으면 exception 발생
        userIdValidCheck.userIdValidCheck(reward.getEvent().getStore().getUser().getUserId(), principal);

        // 이미지 S3에서 삭제
        updateImageService.deleteImagePath(reward.getImagePath());

        rewardRepository.delete(reward);
    }

    // Event 종류에 따라서 analysis-server에 따로 요청
    public RewardLevelResponseDto getRewardId(Long joinPostId, RewardPolicy rewardPolicy) {
        ObjectMapper objectMapper = new ObjectMapper();
        switch (rewardPolicy) {
            case RANDOM:
                return objectMapper.convertValue(getRandomRewardId(joinPostId).getData(), RewardLevelResponseDto.class);
            case FOLLOWER:
                return objectMapper.convertValue(getFollowerRewardId(joinPostId).getData(), RewardLevelResponseDto.class);
            default:
                throw new JoinEventFailedException();
        }
    }

    // analysis-server에 random 이벤트 보상 get 요청
    private CommonResponse getRandomRewardId(Long joinPostId) {
        return analysisServerConfig.webClient().get() // GET method
                .uri("/api/v1/join/rewards/random/" + joinPostId + "/") // baseUrl 이후 uri
                .retrieve() // client message 전송
                .onStatus(HttpStatus::is4xxClientError, clientResponse -> clientResponse.bodyToMono(CommonResponse.class).map(JoinEventFailedException::new))
                .onStatus(HttpStatus::is5xxServerError, clientResponse -> clientResponse.bodyToMono(CommonResponse.class).map(AnalysisServerErrorException::new))
                .bodyToMono(CommonResponse.class) // body type
                .block(); // await
    }

    // analysis-server에 follower 기반 이벤트 보상 get 요청
    private CommonResponse getFollowerRewardId(Long joinPostId) {
        return analysisServerConfig.webClient().get() // GET method
                .uri("/api/v1/join/rewards/follow/" + joinPostId + "/") // baseUrl 이후 uri
                .retrieve() // client message 전송
                .onStatus(HttpStatus::is4xxClientError, clientResponse -> clientResponse.bodyToMono(CommonResponse.class).map(JoinEventFailedException::new))
                .onStatus(HttpStatus::is5xxServerError, clientResponse -> clientResponse.bodyToMono(CommonResponse.class).map(AnalysisServerErrorException::new))
                .bodyToMono(CommonResponse.class) // body type
                .block(); // await
    }
}
