package com.rocketdan.serviceserver.domain.join.post;

import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.reward.Reward;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@SQLDelete(sql = "UPDATE join_post SET deleted = true WHERE id = ?")
@Where(clause = "deleted = false")
public class JoinPost {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private Event event;

    @OneToOne
    private Reward reward;

    @Size(max = 80)
    @Column(length = 80)
    private String snsId;

    @Column(nullable = false)
    private String url;

    private Integer type;

    private Integer status;

    private Integer likeCount;

    private Integer commentCount;

    private String hashtags;

    @Column(nullable = false)
    private LocalDateTime createDate;

    private LocalDateTime uploadDate;

    // 크롤링했을 때, 비공개 전환인 경우 update
    private LocalDateTime privateDate;

    private LocalDateTime deleteDate;

    private LocalDateTime updateDate;

    private LocalDateTime rewardDate;

    @ColumnDefault("false")
    @Column(nullable = false, columnDefinition = "TINYINT")
    private Boolean deleted = false;

    @Builder
    public JoinPost(Event event, String snsId, String url, Integer type, Integer status, Integer likeCount, Integer commentCount, String hashtags, LocalDateTime createDate, LocalDateTime uploadDate, LocalDateTime privateDate, LocalDateTime deleteDate, LocalDateTime updateDate, Reward reward) {
        this.event = event;
        this.snsId = snsId;
        this.url = url;
        this.type = type;
        this.status = status;
        this.likeCount = likeCount;
        this.commentCount = commentCount;
        this.hashtags = hashtags;
        this.createDate = createDate;
        this.uploadDate = uploadDate;
        this.privateDate = privateDate;
        this.deleteDate = deleteDate;
        this.updateDate = updateDate;
        this.reward = reward;
    }

    public void setEvent(Event event) {
        this.event = event;
    }

    public void updateRewardDate(LocalDateTime rewardDate) {
        this.rewardDate = rewardDate;
    }
}
