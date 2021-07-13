package com.rocketdan.serviceserver.domain.event;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import com.rocketdan.serviceserver.domain.event.detail.DetailByType;
import com.rocketdan.serviceserver.domain.event.detail.Hashtag;
import com.rocketdan.serviceserver.domain.event.element.Period;
import com.rocketdan.serviceserver.domain.event.element.Reward;
import lombok.*;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@NoArgsConstructor
@Getter
@Document("Event")
public class Event {
    // 이벤트 id
    @Id
    private String id;

    // 이벤트 제목
    private String title;

    // 이벤트 상태 (대기중/진행중/종료)
    private int status = 0;

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
        this.period = new Period(period.getIsPermanent(), period.getStartDate(), period.getFinishDate());
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

    public void updateStatus() {
        Date time = new Date();

        // 강제로 종료된 이벤트이거나, 이미 종료된 이벤트의 경우.
        if (this.status == 2) {
            return;
        }

        // 영구적인 이벤트가 아닐 경우
        if (!this.period.getIsPermanent()) {
            // 시작 시간이 지났을 경우
            if ( !time.after(this.period.getStartDate()) ) {
                // 종료 시간을 지나지 않았을 경우
                if ( !time.before(this.period.getFinishDate()) ) {
                    this.status = 1; // 진행중
                }
                else {
                    this.status = 2; // 종료
                }
            }
            else {
                this.status = 0; // 대기중
            }
        }
        // 영구 이벤트의 경우
        else {
            // 시작 시간이 지났을 경우
            if ( !time.after(this.period.getStartDate()) ) {
                this.status = 1;
            }
            else {
                this.status = 0;
            }
        }
    }

    public void update(String title, int status, List<String> images, Period period, List<Reward> rewards, DetailByType detail) {
        Optional.ofNullable(title).ifPresent(none -> this.title = title);
        if (status != this.status) {
            this.status = status;
        }
        Optional.ofNullable(images).ifPresent(none -> {
            if (!images.containsAll(this.images)) { this.images = images; }
        });
        Optional.ofNullable(period).ifPresent(none -> {
            if (period != this.period) {
                this.period = period;
            }
        });
        Optional.ofNullable(rewards).ifPresent(none -> {
            if (!rewards.containsAll(this.rewards)){
                this.rewards = new ArrayList<Reward>();
                rewards.forEach(reward ->
                        this.rewards.add(new Reward(reward.getCategory(), reward.getName(), reward.getImage(), reward.getPrice(), reward.getCount())));
            }
        });
        // hashtag
        if (type == 1) {
            Optional.ofNullable(detail).ifPresent(none -> {
                Hashtag hashtag = (Hashtag) detail;
                this.detail = new Hashtag(hashtag.getHashtags(), hashtag.getRequirements(), hashtag.getTemplate());
            });
        }
    }
}