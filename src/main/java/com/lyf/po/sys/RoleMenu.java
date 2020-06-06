package com.lyf.po.sys;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Data
@Table(name = "role_menu")
public class RoleMenu implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", insertable = false, nullable = false)
    private Integer id;

    @JoinColumn(name = "roleId")
    @ManyToOne
    private Role role;

    @JoinColumn(name = "menuId")
    @ManyToOne
    private Menu menu;


}
