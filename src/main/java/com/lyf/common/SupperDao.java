package com.lyf.common;

import java.io.Serializable;
import java.util.List;

/**
 * JPA-Hibernate简单封装类
 * author:lyf
 * 20200605
 */
public interface SupperDao {

    // 增加单个----根据对象
    void save(Object o);

    // 增加单个----根据id
    void save(Class poClass, Serializable id);

    // 增加多个----根据对象
    void saveAll(Object[] o);

    // 增加多个----根据ids
    void saveAll(Class poClass, Serializable[] ids);

    // 删除单个----根据对象
    void del(Object o);

    // 删除单个----根据id
    void del(Class poClass, Serializable id);

    // 删除多个----根据对象
    void delAll(Object[] o);

    // 删除多个----根据ids
    void delAll(Class poClass, Serializable[] ids);

    // 修改单个----根据对象
    void update(Object o);

    // 修改单个----根据id
    void update(Class poClass, Serializable id);

    // 修改多个----根据对象
    void updateAll(Object[] o);

    // 修改多个----根据ids
    void updateAll(Class poClass, Serializable[] ids);

    // 原生sql数据库DML操作----可加条件
    int executeSql(String sql, Object[] o);

    /**************************************** 以下查询 *********************************************/

    /**************************************** hql单个查询 *********************************************/

    // load查询单个----根据id
    Object load(Class poClass, Serializable id);

    // load查询多个----根据ids
    List loadAll(Class poClass, Serializable[] ids);

    // get查询单个----根据id
    Object get(Class poClass, Serializable id);

    // get查询多个----根据ids
    List getAll(Class poClass, Serializable[] ids);

    // hql查询----唯一查询----可加条件
    Object findOne(String hql, Object[] o);

    //hql查询----唯一查询----可加条件,max为固定一条
    Object findOneLimit1(String hql, Object[] o);

    /**************************************** hql批量查询 *********************************************/
    // hql查询----可加条件
    List find(String hql, Object[] o);

    // hql查询----可加条件,max为查询几条
    List find(String hql, Object[] o, Integer max);

    // hql分页查询----可加条件
    List findByPage(String hql, Page page, Object[] o);

    // hql投影查询----可加条件----需写select----查询出来的是对象的属性
    List<Object[]> findAttr(String hql, Object[] o);

    /**************************************** 原生sql查询 *********************************************/
    // 原生sql查询----可加条件----类似hql投影查询,泛型不能是po对象
    List findBySql(String sql, Object[] o);//

    // 原生sql查询----可加条件----类似hql投影查询,泛型不能是po对象----max为查询几条
    List findBySql(String sql, Object[] o, Integer max);

    // 原生sql查询----可加条件----Object转换成具体对象
    List findBySql(Class poClass, String sql, Object[] o);

    // 原生sql查询----可加条件----Object转换成具体对象----max为查询几条
    List findBySql(Class poClass, String sql, Object[] o, Integer max);

    //原生sql查询将结果放入实体----可加条件----不需要有表,不需要配置注解或xml,只需要与查询结果对应字段的实体
    List findBySqlNoMapping(Class poClass, String sql, Object[] o);

    //原生sql查询将结果放入实体----可加条件----不需要有表,不需要配置注解或xml,只需要与查询结果对应字段的实体----max为查询几条
    List findBySqlNoMapping(Class poClass, String sql, Object[] o, Integer max);

    /***************** 原生sql分页查询 *****************/

    // 原生sql分页查询----可加条件----Object转换成具体对象
    List findBySqlPage(Class poClass, String sql, Page page, Object[] o);

    // 原生sql分页查询将结果放入实体----可加条件----Object转换成具体对象----不需要有表,不需要配置注解或xml,只需要与查询结果对应字段的实体
    List findBySqlNoMappingPage(Class poClass, String sql, Page page, Object[] o);

    /***************** 原生sql唯一查询 *****************/
    // 原生sql查询----唯一查询----可加条件----Object不能是po对象
    Object findOneBySql(String sql, Object[] o);

    // 原生sql查询----唯一查询----可加条件----Object转换成具体对象
    Object findOneBySql(Class poClass, String sql, Object[] o);

    // 原生sql查询将结果放入实体----唯一查询----可加条件----不需要有表,不需要配置注解或xml,只需要与查询结果对应字段的实体
    Object findOneBySqlNoMapping(Class poClass, String sql, Object[] o);
}
