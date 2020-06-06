package com.lyf.po.sys;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

@Table(name = "permission")
@Entity
@Data
public class Permission implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", insertable = false, nullable = false)
    private Integer id;

    @Column(name = "text")
    private String text;

    @Column(name = "href")
    private String href;

    @Column(name = "icon")
    private String icon;

    @Column(name = "iconFont")
    private String iconFont;

    @Column(name = "expanded")
    private Boolean expanded;

    @Column(name = "isShow")
    private Boolean isShow;

    @Column(name = "orderIndex")
    private Integer orderIndex;

    @Column(name = "parentId")
    private Integer parentId;

    @Column(name = "createTime")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Timestamp createTime;

    @Column(name = "updateTime")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Timestamp updateTime;


}
