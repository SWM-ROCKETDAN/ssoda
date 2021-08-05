package com.rocketdan.serviceserver.domain.event;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.rocketdan.serviceserver.domain.event.reward.Reward;
import com.rocketdan.serviceserver.domain.store.Store;
import lombok.*;
import org.joda.time.DateTime;
import org.springframework.format.annotation.DateTimeFormat;

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
    @Column(nullable = false)
    private Date startDate;

    // 이벤트 끝 시간 (null -> 영구데이)
    private Date finishDate;

    // 이벤트 이미지 배열
    @ElementCollection
    @Column(nullable = false)
    private List<String> images;

    // 이벤트 보상 목록
    @OneToMany(cascade = CascadeType.ALL)
    private List<Reward> rewards;

    // link된 store
    @ManyToOne
    @JsonBackReference
    private Store store;

    public Event(String title, Integer status, Date startDate, Date finishDate, List<String> images, Store store) {
        this.title = title;
        this.status = status;
        this.startDate = startDate;
        this.finishDate = finishDate;
        this.images = images;
        this.store = store;
    }

    public void updateStatus() {
        Date time = new Date();

        // 강제로 종료된 이벤트이거나, 이미 종료된 이벤트의 경우.
        if (Optional.ofNullable(this.status).isPresent() && this.status == 2) {
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

    public void update(String title, Integer status, Date startDate, Date finishDate, List<String> images) {
        Optional.ofNullable(title).ifPresent(none -> this.title = title);
        Optional.ofNullable(status).ifPresent(none -> this.status = status);
        Optional.ofNullable(startDate).ifPresent(none -> this.startDate = startDate);
        this.finishDate = finishDate;
        Optional.ofNullable(images).ifPresent(none -> this.images = images);
    }

    public String getType() {
        DiscriminatorValue annotation = this.getClass().getAnnotation(DiscriminatorValue.class);
        return annotation.value();
    }

    public void setStore(Store store) {
        this.store = store;

        if (!store.getEvents().contains(this)) {
            store.getEvents().add(this);
        }
    }
}