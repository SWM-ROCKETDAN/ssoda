package com.rocketdan.serviceserver.domain.join.post;

import com.rocketdan.serviceserver.domain.event.Event;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.util.Date;

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

    private String snsId;

    @Column(nullable = false)
    private String url;

    private Integer type;

    private Integer status;

    private Integer likeCount;

    private Integer commentCount;

    private String hashtags;

    @Column(nullable = false)
    private Date createDate;

    private Date uploadDate;

    // 크롤링했을 때, 비공개 전환인 경우 update
    private Date privateDate;

    private Date deleteDate;

    private Date updateDate;

    private Integer rewardsLevel;

    @ColumnDefault("false")
    @Column(nullable = false)
    private Boolean deleted = false;

    @Builder
    public JoinPost(Event event, String snsId, String url, Integer type, Integer status, Integer likeCount, Integer commentCount, String hashtags, Date createDate, Date uploadDate, Date privateDate, Date deleteDate, Date updateDate, Integer rewardsLevel) {
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
        this.rewardsLevel = rewardsLevel;
    }

    public void setEvent(Event event) {
        this.event = event;
    }
}
