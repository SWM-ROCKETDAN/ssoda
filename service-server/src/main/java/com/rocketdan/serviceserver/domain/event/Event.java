package com.rocketdan.serviceserver.domain.event;

import com.rocketdan.serviceserver.domain.event.detail.DetailByType;
import com.rocketdan.serviceserver.domain.event.detail.Hashtag;
import com.rocketdan.serviceserver.domain.event.element.Period;
import com.rocketdan.serviceserver.domain.event.element.Reward;
import lombok.*;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@Getter
@Document("Event")
public class Event {
    // 이벤트 id
    @Id
    private ObjectId id;

    // 이벤트 제목
    private String title;

    // 이벤트 상태 (대기중/진행중/종료)
    private int status;

    // 이벤트 이미지 배열
    private List<String> images;

    // 이벤트 기간
    private Period period;

    // 이벤트 보상 목록
    private List<Reward> rewards;

    // 이벤트 타입
    private int type;

    // 이벤트 타입 별 디테일
    private DetailByType detail;

    @Builder
    public Event(String title, int status, List<String> images, Period period, List<Reward> rewards, int type, DetailByType detail) {
        this.title = title;
        this.status = status;
        this.images = images;
        this.period = new Period(period.getPermanent(), period.getStart(), period.getStart());
        this.rewards = new ArrayList<Reward>();
        rewards.forEach(reward ->
                this.rewards.add(new Reward(reward.getCategory(), reward.getName(), reward.getImage(), reward.getPrice(), reward.getCount())));
        this.type = type;

        // hashtag
        if (type == 1){
            Hashtag hashtag = (Hashtag)detail;
            this.detail = new Hashtag(hashtag.getHashtags(), hashtag.getRequirements(), hashtag.getTemplate());
        }
    }

    public void update(String title, int status, List<String> images, Period period, List<Reward> rewards, DetailByType detail) {
        this.title = title;
        this.status = status;
        this.images = images;
        this.period = period;
        this.rewards = rewards;
        this.detail = detail;
    }
}