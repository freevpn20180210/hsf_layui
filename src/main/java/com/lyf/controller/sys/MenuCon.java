package com.lyf.controller.sys;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lyf.common.LT;
import com.lyf.common.SupperDao;
import com.lyf.controller.BaseController;
import com.lyf.po.sys.Menu;
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
 * 菜单管理
 * author:lyf
 * 20200605
 */
@Controller
@RequestMapping("menu")
public class MenuCon extends BaseController {
    @Autowired
    Tree tree;

    @Autowired
    SupperDao dao;

    @ResponseBody
    @RequestMapping("list")
    JSONObject list() {
        JSONObject rs = new JSONObject();
        JSONArray ja = tree.getMenu(null);
        rs.put("status", JSON.parse("{\"code\":200,\"message\":\"操作成功\"}"));
        rs.put("data", ja);
        return rs;
    }

    @RequestMapping("getInfoById")
    @ResponseBody
    JSONObject getInfoById(Integer id) throws ParseException {
        JSONObject jo = new JSONObject();
        Menu po = (Menu) dao.findOne("from Menu where id=?1", new Object[]{id});
        jo.put("po", po);
        jo.put("ok", true);
        return jo;
    }

    //添加根节点
    @RequestMapping("create")
    @ResponseBody
    JSONObject create(Menu po) {
        JSONObject rs = new JSONObject();
        Integer orderIndex = (Integer) dao.findOneBySql("SELECT MAX( orderIndex ) FROM `menu` WHERE parentId is null", null);
        if (LT.isNotEmpty(orderIndex)) {
            orderIndex++;
            po.setOrderIndex(orderIndex);
        } else {
            po.setOrderIndex(1);
        }
        po.setCreateTime(new Timestamp(new Date().getTime()));
        dao.save(po);
        rs.put("ok", true);
        return rs;
    }

    @RequestMapping("save")
    @ResponseBody
    JSONObject save(@RequestBody JSONObject treeNode) {
        JSONObject rs = new JSONObject();
        Menu po = new Menu();
        Integer orderIndex = (Integer) dao.findOneBySql("SELECT MAX( orderIndex ) FROM `menu` WHERE parentId =?1", new Object[]{treeNode.getString("parentId")});
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

        rs.put("id", po.getId());
        rs.put("ok", true);
        return rs;
    }

    @RequestMapping("update")
    @ResponseBody
    JSONObject update(Menu po) {
        JSONObject rs = new JSONObject();
        if (LT.isEmpty(po.getId())) {
            po.setCreateTime(new Timestamp(new Date().getTime()));
            dao.save(po);
        } else {
            po.setUpdateTime(new Timestamp(new Date().getTime()));
            dao.update(po);
        }
        rs.put("ok", true);
        return rs;
    }

    @RequestMapping("del")
    @ResponseBody
    JSONObject del(Integer[] ids) {
        JSONObject rs = new JSONObject();
        for (Integer id : ids) {
            //角色菜单表中,先删除对此菜单的引用
            dao.executeSql("delete from role_menu where menuId=?1", new Object[]{id});
        }
        dao.delAll(Menu.class, ids);
        rs.put("ok", true);
        return rs;
    }

}
