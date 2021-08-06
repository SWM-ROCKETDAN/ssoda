package com.rocketdan.serviceserver.domain.join.user;


import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Date;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class JoinUser {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String snsId;

    private String url;

    private Integer type;

    private Integer status;

    private Integer followCount;

    private Integer postCount;

    private Date createDate;

    private Date updateDate;

    @Builder
    public JoinUser(String snsId, String url, Integer type, Integer status, Integer followCount, Integer postCount, Date createDate, Date updateDate) {
        this.snsId = snsId;
        this.url = url;
        this.type = type;
        this.status = status;
        this.followCount = followCount;
        this.postCount = postCount;
        this.createDate = createDate;
        this.updateDate = updateDate;
    }
}
