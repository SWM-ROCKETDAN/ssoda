package com.rocketdan.serviceserver.domain.join.user;


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
@SQLDelete(sql = "UPDATE join_user SET deleted = true WHERE id = ?")
@Where(clause = "deleted = false")
public class JoinUser {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Size(max = 80)
    @Column(nullable = false, length = 80)
    private String snsId;

    private String url;

    private Integer type;

    private Integer status;

    private Integer followCount;

    private Integer postCount;

    private LocalDateTime createDate;

    private LocalDateTime updateDate;

    @ColumnDefault("false")
    @Column(nullable = false, columnDefinition = "TINYINT")
    private Boolean deleted = false;

    @Builder
    public JoinUser(String snsId, String url, Integer type, Integer status, Integer followCount, Integer postCount, LocalDateTime createDate, LocalDateTime updateDate) {
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
