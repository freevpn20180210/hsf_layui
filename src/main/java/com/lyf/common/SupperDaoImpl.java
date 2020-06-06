package com.lyf.common;

import org.hibernate.query.internal.NativeQueryImpl;
import org.hibernate.transform.Transformers;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * JPA-Hibernate简单封装类
 * author:lyf
 * 20200605
 */

@Transactional
@Repository
public class SupperDaoImpl implements SupperDao {

    @PersistenceContext
    EntityManager em;

    //?占位符的填充
    private void addCond(Query query, String hql, Object[] o) {
        int index = hql.indexOf("?");
        if (index == -1) {
            return;
        }
        int count = 0;
        // 如果第一个?的位置存在,则继续判断
        while (index != -1) {
            if (LT.arrNotEmpty(o)) {
                // 并把对应值赋给?的所在位置
                query.setParameter(count + 1, o[count]);
            } else {
                query.setParameter(count + 1, null);
            }
            // 然后使用substring重新整理字符串,第一个参数为第一个?的位置+1,第二个参数为到哪个索引截止(不包括此索引)
            hql = hql.substring(index + 1, hql.length());
            // 再次获取重新整理的字符串中的?的位置
            index = hql.indexOf("?");
            count++;
        }
    }

    // 增加单个----根据对象
    @Override
    public void save(Object o) {
        em.persist(o);
    }

    // 增加单个----根据id
    @Override
    public void save(Class poClass, Serializable id) {
        em.persist(em.find(poClass, id));
    }

    // 增加多个----根据对象
    @Override
    public void saveAll(Object[] o) {
        for (Object o1 : o) {
            save(o1);
        }
    }

    // 增加多个----根据ids
    @Override
    public void saveAll(Class poClass, Serializable[] ids) {
        for (Serializable id : ids) {
            save(poClass, id);
        }
    }

    // 删除单个----根据对象
    @Override
    public void del(Object o) {
        em.remove(o);
    }

    // 删除单个----根据id
    @Override
    public void del(Class poClass, Serializable id) {
        em.remove(load(poClass, id));
    }

    // 删除多个----根据对象
    // @Override
    public void delAll(Object[] o) {
        for (Object o1 : o) {
            del(o1);
        }
    }

    // 删除多个----根据ids
    @Override
    public void delAll(Class poClass, Serializable[] ids) {
        for (Serializable id : ids) {
            del(poClass, id);
        }
    }

    // 修改单个----根据对象
    @Override
    public void update(Object o) {
        em.merge(o);
    }

    // 修改单个----根据id
    @Override
    public void update(Class poClass, Serializable id) {
        em.merge(load(poClass, id));
    }

    // 修改多个----根据对象
    @Override
    public void updateAll(Object[] o) {
        for (Object o1 : o) {
            em.merge(o1);
        }
    }

    // 修改多个----根据ids
    @Override
    public void updateAll(Class poClass, Serializable[] ids) {
        for (Serializable id : ids) {
            update(poClass, id);
        }
    }

    // 原生sql数据库DML操作----可加条件
    @Override
    public int executeSql(String sql, Object[] o) {
        Query query = em.createNativeQuery(sql);
        addCond(query, sql, o);
        return query.executeUpdate();
    }

    /**************************************** 以下查询 *********************************************/

    /**************************************** hql单个查询 *********************************************/

    // load查询单个----根据id
    @Transactional(readOnly = true)
    @Override
    public Object load(Class poClass, Serializable id) {
        return em.getReference(poClass, id);
    }

    // load查询多个----根据ids
    @Transactional(readOnly = true)
    @Override
    public List loadAll(Class poClass, Serializable[] ids) {
        List list = new ArrayList();
        for (Serializable id : ids) {
            list.add(load(poClass, id));
        }
        return list;
    }

    // get查询单个----根据id
    @Transactional(readOnly = true)
    @Override
    public Object get(Class poClass, Serializable id) {
        return em.find(poClass, id);
    }

    // get查询多个----根据ids
    @Transactional(readOnly = true)
    @Override
    public List getAll(Class poClass, Serializable[] ids) {
        List list = new ArrayList();
        for (Serializable id : ids) {
            list.add(get(poClass, id));
        }
        return list;
    }

    // hql查询----唯一查询----可加条件
    @Transactional(readOnly = true)
    @Override
    public Object findOne(String hql, Object[] o) {
        Query query = em.createQuery(hql);
        addCond(query, hql, o);
        if (query.getResultList().size() == 0) {
            return null;
        } else {
            return query.getSingleResult();
        }
    }

    //hql查询----唯一查询----可加条件,max为固定一条
    @Transactional(readOnly = true)
    @Override
    public Object findOneLimit1(String hql, Object[] o) {
        Query query = em.createQuery(hql);
        addCond(query, hql, o);
        query.setMaxResults(1);
        if (query.getResultList().size() == 0) {
            return null;
        } else {
            return query.getSingleResult();
        }
    }

    /**************************************** hql批量查询 *********************************************/

    // hql查询----可加条件
    @Transactional(readOnly = true)
    @Override
    public List find(String hql, Object[] o) {
        Query query = em.createQuery(hql);
        addCond(query, hql, o);
        return query.getResultList();
    }

    // hql查询----可加条件,max为查询几条
    @Transactional(readOnly = true)
    @Override
    public List find(String hql, Object[] o, Integer max) {
        Query query = em.createQuery(hql);
        addCond(query, hql, o);
        query.setMaxResults(max);
        return query.getResultList();
    }

    // hql分页查询
    @Transactional(readOnly = true)
    @Override
    public List findByPage(String hql, Page page, Object[] o) {
        Query query = em.createQuery(hql);
        addCond(query, hql, o);
        query.setFirstResult((page.getPage() - 1) * page.getLimit());
        query.setMaxResults(page.getLimit());
        return query.getResultList();
    }

    // 投影查询----可加条件----需写select----查询出来的是对象的属性
    // 如select detpName->List<String>;select deptName,peopleCount->List<Object[]>
    @Transactional(readOnly = true)
    @Override
    public List<Object[]> findAttr(String hql, Object[] o) {
        Query query = em.createQuery(hql);
        addCond(query, hql, o);
        return query.getResultList();
    }

    /**************************************** 原生sql查询 *********************************************/

    // 原生sql查询----可加条件----类似hql投影查询,泛型不能是po对象
    @Transactional(readOnly = true)
    @Override
    public List findBySql(String sql, Object[] o) {
        Query query = em.createNativeQuery(sql);
        addCond(query, sql, o);
        return query.getResultList();
    }

    // 原生sql查询----可加条件----类似hql投影查询,泛型不能是po对象----max为查询几条
    @Transactional(readOnly = true)
    @Override
    public List findBySql(String sql, Object[] o, Integer max) {
        Query query = em.createNativeQuery(sql);
        addCond(query, sql, o);
        query.setMaxResults(max);
        return query.getResultList();
    }

    // 原生sql查询----可加条件----Object转换成具体对象
    @Transactional(readOnly = true)
    @Override
    public List findBySql(Class poClass, String sql, Object[] o) {
        Query query = em.createNativeQuery(sql, poClass);
        addCond(query, sql, o);
        return query.getResultList();
    }

    // 原生sql查询----可加条件----Object转换成具体对象----max为查询几条
    @Transactional(readOnly = true)
    @Override
    public List findBySql(Class poClass, String sql, Object[] o, Integer max) {
        Query query = em.createNativeQuery(sql, poClass);
        addCond(query, sql, o);
        query.setMaxResults(max);
        return query.getResultList();
    }

    //原生sql查询将结果放入实体----可加条件----不需要有表,不需要配置注解或xml,只需要与查询结果对应字段的实体
    @Transactional(readOnly = true)
    @Override
    public List findBySqlNoMapping(Class poClass, String sql, Object[] o) {
        Query query = em.createNativeQuery(sql);
        addCond(query, sql, o);
        query.unwrap(NativeQueryImpl.class).setResultTransformer(Transformers.aliasToBean(poClass));
        return query.getResultList();
    }

    //原生sql查询将结果放入实体----可加条件----不需要有表,不需要配置注解或xml,只需要与查询结果对应字段的实体----max为查询几条
    @Transactional(readOnly = true)
    @Override
    public List findBySqlNoMapping(Class poClass, String sql, Object[] o, Integer max) {
        Query query = em.createNativeQuery(sql);
        addCond(query, sql, o);
        query.unwrap(NativeQueryImpl.class).setResultTransformer(Transformers.aliasToBean(poClass));
        query.setMaxResults(max);
        return query.getResultList();
    }

    /***************** 原生sql分页查询 *****************/

    // 原生sql分页查询----可加条件----Object转换成具体对象
    @Transactional(readOnly = true)
    @Override
    public List findBySqlPage(Class poClass, String sql, Page page, Object[] o) {
        Query query = em.createNativeQuery(sql, poClass);
        addCond(query, sql, o);
        query.setFirstResult((page.getPage() - 1) * page.getLimit());
        query.setMaxResults(page.getLimit());
        return query.getResultList();
    }

    // 原生sql分页查询将结果放入实体----可加条件----Object转换成具体对象----不需要有表,不需要配置注解或xml,只需要与查询结果对应字段的实体
    @Transactional(readOnly = true)
    @Override
    public List findBySqlNoMappingPage(Class poClass, String sql, Page page, Object[] o) {
        Query query = em.createNativeQuery(sql);
        addCond(query, sql, o);
        query.unwrap(NativeQueryImpl.class).setResultTransformer(Transformers.aliasToBean(poClass));
        query.setFirstResult((page.getPage() - 1) * page.getLimit());
        query.setMaxResults(page.getLimit());
        return query.getResultList();
    }

    /***************** 原生sql唯一查询 *****************/

    // 原生sql查询----唯一查询----可加条件----Object不能是po对象
    @Transactional(readOnly = true)
    @Override
    public Object findOneBySql(String sql, Object[] o) {
        Query query = em.createNativeQuery(sql);
        addCond(query, sql, o);
        if (query.getResultList().size() == 0) {
            return null;
        } else {
            return query.getSingleResult();
        }
    }

    // 原生sql查询----唯一查询----可加条件----Object转换成具体对象
    @Override
    public Object findOneBySql(Class poClass, String sql, Object[] o) {
        Query query = em.createNativeQuery(sql, poClass);
        addCond(query, sql, o);
        if (query.getResultList().size() == 0) {
            return null;
        } else {
            return query.getSingleResult();
        }
    }

    // 原生sql查询将结果放入实体----唯一查询----可加条件----不需要有表,不需要配置注解或xml,只需要与查询结果对应字段的实体
    @Transactional(readOnly = true)
    @Override
    public Object findOneBySqlNoMapping(Class poClass, String sql, Object[] o) {
        Query query = em.createNativeQuery(sql);
        addCond(query, sql, o);
        query.unwrap(NativeQueryImpl.class).setResultTransformer(Transformers.aliasToBean(poClass));
        return query.getSingleResult();
    }
}
