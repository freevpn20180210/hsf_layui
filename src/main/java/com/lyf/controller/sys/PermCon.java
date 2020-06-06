package com.lyf.controller.sys;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lyf.common.LT;
import com.lyf.common.SupperDao;
import com.lyf.controller.BaseController;
import com.lyf.po.sys.Permission;
import com.lyf.tool.ClearAuth;
import com.lyf.tool.Tree;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.Timestamp;
import java.text.ParseException;
import java.util.Date;

/**
 * 功能管理
 * author:lyf
 * 20200605
 */
@Controller
@RequestMapping("perm")
public class PermCon extends BaseController {
    @Autowired
    Tree tree;

    @Autowired
    SupperDao dao;

    @Autowired
    ClearAuth clearAuth;

    @ResponseBody
    @RequestMapping("list")
    JSONObject list() {
        JSONObject rs = new JSONObject();
        JSONArray ja = tree.getPerm(null);
        rs.put("status", JSON.parse("{\"code\":200,\"message\":\"操作成功\"}"));
        rs.put("data", ja);
        return rs;
    }

    @RequestMapping("getInfoById")
    @ResponseBody
    JSONObject getInfoById(Integer id) throws ParseException {
        JSONObject jo = new JSONObject();
        Permission po = (Permission) dao.findOne("from Permission where id=?1", new Object[]{id});
        jo.put("po", po);
        jo.put("ok", true);
        return jo;
    }

    //添加根节点
    @RequestMapping("create")
    @ResponseBody
    JSONObject create(Permission po) {
        JSONObject rs = new JSONObject();
        Integer orderIndex = (Integer) dao.findOneBySql("SELECT MAX( orderIndex ) FROM `permission` WHERE parentId is null", null);
        if (LT.isNotEmpty(orderIndex)) {
            orderIndex++;
            po.setOrderIndex(orderIndex);
        } else {
            po.setOrderIndex(1);
        }
        po.setCreateTime(new Timestamp(new Date().getTime()));
        dao.save(po);
        clearAuth.updatePermission();
        rs.put("ok", true);
        return rs;
    }

    @RequestMapping("save")
    @ResponseBody
    JSONObject save(@RequestBody JSONObject treeNode) {
        JSONObject rs = new JSONObject();
        Permission po = new Permission();
        Integer orderIndex = (Integer) dao.findOneBySql("SELECT MAX( orderIndex ) FROM `permission` WHERE parentId =?1", new Object[]{treeNode.getString("parentId")});
        if (LT.isNotEmpty(orderIndex)) {
            orderIndex++;
            po.setOrderIndex(orderIndex);
        } else {
            po.setOrderIndex(1);
        }
        po.setText(treeNode.getString("addNodeName"));
        po.setParentId(treeNode.getInteger("parentId"));
        po.setCreateTime(new Timestamp(new Date().getTime()));
        dao.save(po);
        clearAuth.updatePermission();
        rs.put("id", po.getId());
        rs.put("ok", true);
        return rs;
    }

    @RequestMapping("update")
    @ResponseBody
    JSONObject update(Permission po) {
        JSONObject rs = new JSONObject();
        if (LT.isEmpty(po.getId())) {
            po.setCreateTime(new Timestamp(new Date().getTime()));
            dao.save(po);
        } else {
            po.setUpdateTime(new Timestamp(new Date().getTime()));
            dao.update(po);
        }
        clearAuth.updatePermission();
        rs.put("ok", true);
        return rs;
    }

    @RequestMapping("del")
    @ResponseBody
    JSONObject del(Integer[] ids) {
        JSONObject rs = new JSONObject();
        for (Integer id : ids) {
            //角色功能表中,先删除对此功能的引用
            dao.executeSql("delete from role_permission where permissionId=?1", new Object[]{id});
        }
        dao.delAll(Permission.class, ids);
        clearAuth.updatePermission();
        rs.put("ok", true);
        return rs;
    }

}
