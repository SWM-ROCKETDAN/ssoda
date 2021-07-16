package com.rocketdan.serviceserver.domain.event;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.rocketdan.serviceserver.domain.event.reward.Reward;
import lombok.*;

import javax.persistence.*;
import java.util.*;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name = "ETYPE")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
public abstract class Event {
    // 이벤트 id
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 이벤트 제목
    @Column(nullable = false)
    private String title;

    // 이벤트 상태 (대기중/진행중/종료)
    @Column(nullable = false)
    private Integer status;

    // 이벤트 시작 시간
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd'T'HH:mm:ss")
    @Column(nullable = false)
    private Date startDate;

    // 이벤트 끝 시간 (null -> 영구데이)
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd'T'HH:mm:ss")
    private Date finishDate;

    // 이벤트 이미지 배열
    @ElementCollection
    private List<String> images;

    // 이벤트 보상 목록
    @JsonManagedReference
    @OneToMany(cascade = CascadeType.ALL)
    private List<Reward> rewards;

    public Event(String title, int status, Date startDate, Date finishDate, List<String> images, List<Reward> rewards) {
        this.title = title;
        this.status = status;
        this.startDate = startDate;
        this.finishDate = finishDate;
        this.images = images;
        this.rewards = rewards;
    }

    public void updateStatus() {
        Date time = new Date();

        // 강제로 종료된 이벤트이거나, 이미 종료된 이벤트의 경우.
        if (this.status == 2) {
            return;
        }

        // 영구적인 이벤트가 아닐 경우
        if (Optional.ofNullable(this.finishDate).isPresent() ) {
            // 시작 시간이 지났을 경우
            if ( time.after(this.startDate) ) {
                // 종료 시간을 지나지 않았을 경우
                if ( time.before(this.finishDate) ) {
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
            if ( time.after(this.startDate) ) {
                this.status = 1; // 진행중
            }
            else {
                this.status = 0; // 대기중
            }
        }
    }

    public void update(String title, Integer status, Date startDate, Date finishDate, List<String> images, List<Reward> rewards) {
        Optional.ofNullable(title).ifPresent(none -> this.title = title);
        Optional.ofNullable(status).ifPresent(none -> this.status = status);
        Optional.ofNullable(startDate).ifPresent(none -> this.startDate = startDate);
        Optional.ofNullable(finishDate).ifPresent(none -> this.finishDate = finishDate);
        Optional.ofNullable(images).ifPresent(none -> this.images = images);
        Optional.ofNullable(rewards).ifPresent(none -> this.rewards = rewards);
    }

    public String getType() {
        DiscriminatorValue annotation = this.getClass().getAnnotation(DiscriminatorValue.class);
        return annotation.value();
    }
}