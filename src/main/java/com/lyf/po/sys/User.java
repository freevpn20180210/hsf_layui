package com.lyf.po.sys;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

@Table(name = "user")
@Entity
@Data
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", insertable = false, nullable = false)
    private Integer id;

    @Column(name = "name")
    private String name;

    @Column(name = "pwd")
    private String pwd;

    @Column(name = "nickname")
    private String nickname;

    @Column(name = "realname")
    private String realname;

    @Column(name = "pic")
    private String pic;

    @Column(name = "sex")
    private String sex;

    @Column(name = "phone")
    private String phone;

    @Column(name = "mail")
    private String mail;

    /**
     * 邮箱是否被验证
     */
    @Column(name = "mailVerified")
    private Boolean mailVerified = null;

    @Column(name = "address")
    private String address;

    @Column(name = "remark")
    private String remark;

    /**
     * 帐号是否被锁定
     */
    @Column(name = "locked")
    private Boolean locked = false;

    /**
     * 用户总网盘容量
     */
    @Column(name = "panSize")
    private Double panSize = 100D;

    /**
     * 用户可用网盘容量
     */
    @Column(name = "usablePanSize")
    private Double usablePanSize = 100D;

    @Column(name = "createTime")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Timestamp createTime;

    @Column(name = "updateTime")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Timestamp updateTime;


}