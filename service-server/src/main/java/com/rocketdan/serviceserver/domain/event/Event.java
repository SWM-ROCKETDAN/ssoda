package com.rocketdan.serviceserver.domain.event;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.rocketdan.serviceserver.domain.reward.Reward;
import com.rocketdan.serviceserver.domain.store.Store;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.*;

@Entity
@Getter
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name = "ETYPE")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@SQLDelete(sql = "UPDATE event SET deleted = true WHERE id = ?")
@Where(clause = "deleted = false")
public abstract class Event {
    // 이벤트 id
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 이벤트 제목
    @Size(max = 25)
    @Column(nullable = false, length = 25)
    private String title;

    // 이벤트 상태 (대기중/진행중/종료)
    @Column(nullable = false)
    private Integer status;

    // 이벤트 시작 시간
    @Column(nullable = false)
    private LocalDateTime startDate;

    // 이벤트 끝 시간 (null -> 영구데이)
    private LocalDateTime finishDate;

    // 이벤트 이미지 배열
    @ElementCollection
    @Column(nullable = false)
    private List<String> imagePaths;

    // 이벤트 보상 목록
    @OneToMany(mappedBy = "event", cascade = CascadeType.REMOVE)
    private List<Reward> rewards;

    // link된 store
    @ManyToOne
    @JsonBackReference
    private Store store;

    @ColumnDefault("false")
    @Column(nullable = false, columnDefinition = "TINYINT")
    private Boolean deleted = false;

    public Event(String title, Integer status, LocalDateTime startDate, LocalDateTime finishDate, List<String> imagePaths, List<Reward> rewards, Store store) {
        this.title = title;
        this.status = status;
        this.startDate = startDate;
        this.finishDate = finishDate;
        this.imagePaths = imagePaths;
        this.rewards = rewards;
        this.store = store;
    }

    public void updateStatus() {
        LocalDateTime now = ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime();
        // startDate 가 지났거나 같은 경우 -> true
        boolean startDateCompareToNow = now.compareTo(this.startDate) >= 0;

        // 강제로 종료된 이벤트이거나, 이미 종료된 이벤트의 경우.
        if (Optional.ofNullable(this.status).isPresent() && this.status == 2) {
            return;
        }

        // 영구적인 이벤트가 아닐 경우
        if (Optional.ofNullable(this.finishDate).isPresent() ) {
            // finishDate 가 지나지 않았거나 같은 경우 -> true
            boolean finishDateCompareToNow = now.compareTo(this.finishDate) <= 0;

            // 시작 시간이 지났을 경우
            if ( startDateCompareToNow ) {
                // 종료 시간을 지나지 않았을 경우
                if ( finishDateCompareToNow ) {
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
            if ( startDateCompareToNow ) {
                this.status = 1;
            }
            else {
                this.status = 0; // 대기중
            }
        }
    }

    public void updateStatus(Integer status) {
        Optional.ofNullable(status).ifPresent(none -> this.status = status);
    }

    public void update(String title, LocalDateTime startDate, LocalDateTime finishDate, List<String> images) {
        Optional.ofNullable(title).ifPresent(none -> this.title = title);
        Optional.ofNullable(startDate).ifPresent(none -> this.startDate = startDate);
        this.finishDate = finishDate;
        Optional.ofNullable(images).ifPresent(none -> this.imagePaths = images);
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