package com.rocketdan.serviceserver.service.event;

import com.rocketdan.serviceserver.app.dto.event.EventListResponseDto;
import com.rocketdan.serviceserver.app.dto.event.EventResponseDto;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventSaveRequest;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventUpdateRequest;
import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.EventRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class EventService {
    private final EventRepository eventRepository;

    @Transactional
    public String saveHashtagEvent(HashtagEventSaveRequest requestDto) {
        return eventRepository.save(requestDto.toEntity()).getId();
    }

    @Transactional
    public String updateHashtagEvent(String id, HashtagEventUpdateRequest requestDto) {
        Event event = eventRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 이벤트가 없습니다. id=" + id));
        event.update(requestDto.getTitle(), requestDto.getStatus(), requestDto.getImages(), requestDto.getPeriod(), requestDto.getRewards(), requestDto.getDetail());
        System.out.println(requestDto.getPeriod().getFinishDate());
        return eventRepository.save(event).getId();
    }

    public EventResponseDto findById (String id) {
        Event entity = eventRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 이벤트가 없습니다. id=" + id));
        return new EventResponseDto(entity);
    }

    @Transactional//(readOnly = true) // 나는 에러나서 일단 주석
    public List<EventListResponseDto> findAll() {
        return eventRepository.findAll().stream()
                // 람다식 사용. 실제 코드 : .map(posts -> new PostsListResponseDto(posts))
                // eventRepository 결과로 넘어온 Event의 Stream을 map울 통해 EventListResponseDto 변환 -> List로 반환하는 메소드
                .map(EventListResponseDto::new)
                .collect(Collectors.toList());
    }

    @Transactional
    public void delete (String id) {
        Event event = eventRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 이벤트가 없습니다. id=" + id));
        // JpaRepository에서 이미 delete 메소드를 지원하고 있으니 이를 활용.
        // entity를 파라미터로 삭제할 수도 있고, deleteById 메소드를 이용하면 id로 삭제할 수도 있다.
        // 존재하는 Event인지 확인을 위해 entity 조회 후 그대로 삭제.
        eventRepository.delete(event);
    }
}
