package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.app.dto.event.EventListResponseDto;
import com.rocketdan.serviceserver.app.dto.event.EventResponseDto;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventResponseDto;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventSaveRequest;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventUpdateRequest;
import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.EventRepository;
import com.rocketdan.serviceserver.domain.event.reward.RewardRepository;
import com.rocketdan.serviceserver.domain.event.type.Hashtag;
import com.rocketdan.serviceserver.domain.store.Store;
import com.rocketdan.serviceserver.domain.store.StoreRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class EventService {
    private final EventRepository eventRepository;
    private final RewardRepository rewardRepository;

    private final StoreRepository storeRepository;

    @Transactional
    public Long saveHashtagEvent(Long store_id, HashtagEventSaveRequest requestDto) {
        Store linkedStore = storeRepository.findById(store_id).orElseThrow(() -> new IllegalArgumentException("해당 가게가 없습니다. id=" + store_id));
        Event savedEvent = requestDto.toEntity();
        savedEvent.setStore(linkedStore);
        savedEvent.updateStatus();

        return eventRepository.save(savedEvent).getId();
    }

    @Transactional
    public Long updateHashtagEvent(Long id, HashtagEventUpdateRequest requestDto) {
        Hashtag event = (Hashtag) eventRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 이벤트가 없습니다. id=" + id));

        Optional.ofNullable(requestDto.getRewards()).ifPresent(none -> {
                event.getRewards().forEach(rewardRepository::delete); // 기존에 저장되었던 reward 삭제
        });

        event.update(requestDto.getTitle(), requestDto.getStatus(), requestDto.getStartDate(), requestDto.getFinishDate(),
                requestDto.getImages(), requestDto.getRewards(),
                requestDto.getHashtags(), requestDto.getRequirements(), requestDto.getTemplate());

        return id;
    }

    public EventResponseDto findById(Long id) {
        Event entity = eventRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 이벤트가 없습니다. id=" + id));
        entity.updateStatus();

        if (entity.getType().equals("hashtag")) {
            return new HashtagEventResponseDto((Hashtag) entity);
        }

        return new EventResponseDto(entity);
    }

    @Transactional(readOnly = true)
    public List<EventListResponseDto> findAll() {
        return eventRepository.findAll().stream()
                // 람다식 사용. 실제 코드 : .map(posts -> new PostsListResponseDto(posts))
                // eventRepository 결과로 넘어온 Event의 Stream을 map울 통해 EventListResponseDto 변환 -> List로 반환하는 메소드
                .map(EventListResponseDto::new)
                .collect(Collectors.toList());
    }

    @Transactional
    public void delete(Long id) {
        Event event = eventRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 이벤트가 없습니다. id=" + id));
        // JpaRepository에서 이미 delete 메소드를 지원하고 있으니 이를 활용.
        // entity를 파라미터로 삭제할 수도 있고, deleteById 메소드를 이용하면 id로 삭제할 수도 있다.
        // 존재하는 Event인지 확인을 위해 entity 조회 후 그대로 삭제.
        eventRepository.delete(event);
    }
}
