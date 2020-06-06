package com.lyf.tool;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lyf.common.LT;
import com.lyf.common.SupperDao;
import com.lyf.po.sys.Menu;
import com.lyf.po.sys.Permission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 树的获取类
 * author:lyf
 * 20200605
 */
@Component
public class Tree {
    @Autowired
    private SupperDao dao;

    //界面菜单--根据用户id获得对应角色,根据对应角色获得对应界面菜单
    public JSONArray getIndexMenu(Integer userId, Integer parentId) {
        StringBuilder sb = new StringBuilder();
//        使用连接查询代替子查询(会新增临时表)提高查询速度
        sb.append("SELECT d.* FROM user a JOIN user_role b ON a.id = b.userId JOIN role_menu c ON b.roleId = c.roleId JOIN menu d ON c.menuId = d.id WHERE a.id = ?1");
        List<Menu> list = null;
        if (parentId == null) {
            // 先把该用户的所有父节点查出来
            sb.append(" and parentId is null order by orderIndex asc");
            list = dao.findBySqlNoMapping(Menu.class, sb.toString(), new Object[]{userId});
        } else {
            sb.append(" and parentId=?2 order by orderIndex asc");
            list = dao.findBySqlNoMapping(Menu.class, sb.toString(), new Object[]{userId, parentId});
        }
        JSONArray ja = new JSONArray();
        if (LT.listNotEmpty(list)) {
            JSONObject jo = null;
            for (Menu menu : list) {
                jo = new JSONObject(true);
                jo.put("id", menu.getId());
                jo.put("title", menu.getText());
                jo.put("url", menu.getHref());
                jo.put("icon", menu.getIcon());
                jo.put("spread", menu.getExpanded());
                jo.put("orderIndex", menu.getOrderIndex());
                jo.put("parentId", menu.getParentId());
                jo.put("createTime", LT.formatDate(menu.getCreateTime()));
                jo.put("updateTime", LT.formatDate(menu.getUpdateTime()));
                // 把父节点的id作参,迭代查询对应的子节点
                jo.put("list", getIndexMenu(userId, menu.getId()));
                ja.add(jo);
            }
        }
        return ja;
    }

    // 系统管理--权限管理-菜单权限--dtree实现
    public JSONArray getMenu(Integer parentId) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT * from menu ");
        List<Menu> list = null;
        if (parentId == null) {
            // 先把所有父节点查出来
            sb.append("where parentId is null order by orderIndex asc ");
            list = dao.findBySqlNoMapping(Menu.class, sb.toString(), null);
        } else {
            sb.append("where parentId=?1 order by orderIndex asc ");
            list = dao.findBySqlNoMapping(Menu.class, sb.toString(), new Object[]{parentId});
        }
        JSONArray ja = new JSONArray();
        if (LT.listNotEmpty(list)) {
            JSONObject jo = null;
            for (Menu menu : list) {
                jo = new JSONObject(true);
                jo.put("id", menu.getId());
                jo.put("title", menu.getText());
//                jo.put("url", menu.getHref());
//                jo.put("icon", menu.getIcon());
                jo.put("spread", menu.getExpanded());
                jo.put("orderIndex", menu.getOrderIndex());
                jo.put("parentId", menu.getParentId());
                jo.put("createTime", LT.formatDate(menu.getCreateTime()));
                jo.put("updateTime", LT.formatDate(menu.getUpdateTime()));
                jo.put("checkArr", "{\"type\": \"0\", \"checked\": \"0\"}");
                // 把父节点的id作参,迭代查询对应的子节点
                jo.put("children", getMenu(menu.getId()));
                ja.add(jo);
            }
        }
        return ja;
    }

    //系统管理--权限管理--功能权限--dtree实现
    public JSONArray getPerm(Integer parentId) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT * from permission ");
        List<Permission> list = null;
        if (parentId == null) {
            // 先把所有父节点查出来
            sb.append("where parentId is null order by orderIndex asc ");
            list = dao.findBySqlNoMapping(Permission.class, sb.toString(), null);
        } else {
            sb.append("where parentId=?1 order by orderIndex asc ");
            list = dao.findBySqlNoMapping(Permission.class, sb.toString(), new Object[]{parentId});
        }
        JSONArray ja = new JSONArray();
        if (LT.listNotEmpty(list)) {
            JSONObject jo = null;
            for (Permission perm : list) {
                jo = new JSONObject(true);
                jo.put("id", perm.getId());
                jo.put("title", perm.getText());
//                jo.put("url", perm.getHref());
//                jo.put("icon", perm.getIcon());
                jo.put("spread", perm.getExpanded());
                jo.put("orderIndex", perm.getOrderIndex());
                jo.put("parentId", perm.getParentId());
                jo.put("createTime", LT.formatDate(perm.getCreateTime()));
                jo.put("updateTime", LT.formatDate(perm.getUpdateTime()));
                jo.put("checkArr", "{\"type\": \"0\", \"checked\": \"0\"}");
                // 把父节点的id作参,迭代查询对应的子节点
                jo.put("children", getPerm(perm.getId()));
                ja.add(jo);
            }
        }
        return ja;
    }
}
