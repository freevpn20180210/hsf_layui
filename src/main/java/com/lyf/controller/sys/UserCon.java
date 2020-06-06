package com.lyf.controller.sys;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lyf.common.LT;
import com.lyf.common.Page;
import com.lyf.common.SupperDao;
import com.lyf.controller.BaseController;
import com.lyf.po.sys.*;
import com.lyf.tool.ClearAuth;
import com.lyf.tool.Tree;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

/**
 * 用户管理
 * author:lyf
 * 20200605
 */
@Controller
@RequestMapping("user")
public class UserCon extends BaseController {
    @Autowired
    SupperDao dao;

    @Autowired
    Tree tree;

    @Autowired
    ClearAuth clearAuth;

    @RequestMapping("list")
    @ResponseBody
    JSONObject list(String[] keywords, Page page) {
        List<User> list = null;
        BigInteger count = null;
        if (LT.arrNotEmpty(keywords)) {
            list = dao.findByPage("from User " +
                    "where name like concat('%',?1,'%') " +
                    "and mail like concat('%',?2,'%') " +
                    "and sex like concat('%',?3,'%') " +
                    "order by createTime", page, keywords);
            count = (BigInteger) dao.findOneBySql("select count(*) from user " +
                            "where name like concat('%',?1,'%') " +
                            "and mail like concat('%',?2,'%') " +
                            "and sex like concat('%',?3,'%') "
                    , keywords);
        } else {
            list = dao.findByPage("from User order by createTime", page, null);
            count = (BigInteger) dao.findOneBySql("select count(*) from user", null);
        }
        JSONObject rs = new JSONObject();
        JSONArray data = new JSONArray();
        list.forEach(po -> {
            JSONObject jo = (JSONObject) JSON.toJSON(po);
            //JSON.toJSON(po)导致@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")无效
            jo.put("createTime", LT.formatDate(po.getCreateTime()));
            jo.put("updateTime", LT.formatDate(po.getUpdateTime()));
            jo.put("mailVerified", po.getMailVerified() == null ? "" : po.getMailVerified() ? "已验证" : "未验证");
            data.add(jo);
        });
        rs.put("data", data);
        rs.put("code", 0);
        rs.put("msg", "");
        rs.put("count", count);
        return rs;
    }

    @RequestMapping("del")
    @ResponseBody
    JSONObject del(Integer[] ids) {
        for (Integer id : ids) {
            //用户-角色表中,先删除对此用户的引用
            dao.executeSql("delete from user_role where userId=?1", new Object[]{id});
        }
        dao.delAll(User.class, ids);
        JSONObject rs = new JSONObject();
        rs.put("ok", true);
        return rs;
    }

    @RequestMapping("toSaveUpdate")
    String toSaveUpdate(Integer id, ModelMap m) {
        if (LT.isNotEmpty(id)) {
            User user = (User) dao.findOne("from User where id =?1", new Object[]{id});
            List<UserRole> userRoleList = dao.find("from UserRole where user.id=?1", new Object[]{id});
            String roleName = null;
            if (LT.listNotEmpty(userRoleList)) {
                if (userRoleList.size() > 1) {
                    StringBuilder sb = new StringBuilder();
                    for (int i = 0; i < userRoleList.size(); i++) {
                        sb.append(userRoleList.get(i).getRole().getName() + ",");
                    }
                    sb.deleteCharAt(sb.length() - 1);
                    roleName = sb.toString();
                } else {
                    roleName = userRoleList.get(0).getRole().getName();
                }
            }
            m.put("po", user);
            m.put("roleName", LT.isEmpty(roleName) ? "暂无角色" : roleName);
        }
        return "sys/user/saveUpdate.jsp";
    }

    @RequestMapping("saveUpdate")
    @ResponseBody
    JSONObject saveUpdate(User po) {
        JSONObject rs = new JSONObject();
        if (LT.isEmpty(po.getMail())) {
            po.setMailVerified(null);
        } else {
            po.setMailVerified(false);
        }
        if (LT.isEmpty(po.getId())) {
            //新增时判断用户名是否已被注册
            List<User> list = dao.find("from User where name=?1", new Object[]{po.getName()});
            if (list.size() > 0) {
                rs.put("ok", false);
                rs.put("msg", "用户名已被注册");
                return rs;
            }
            //新增时判断邮箱是否被其他用户绑定
            if (LT.isNotEmpty(po.getMail())) {
                List<User> list1 = dao.find("from User where mail=?1", new Object[]{po.getMail()});
                if (list1.size() > 0) {
                    rs.put("ok", false);
                    rs.put("msg", "该邮箱已被其他用户绑定");
                    return rs;
                }
            }
            Md5Hash md5Hash = new Md5Hash(po.getPwd());
            po.setPwd(md5Hash.toString());
            po.setLocked(false);
            po.setCreateTime(new Timestamp(new Date().getTime()));
            dao.save(po);
        } else {
            //修改时判断用户名是否已被注册
            User oldUser = (User) dao.findOne("from User where id=?1", new Object[]{po.getId()});
            List<User> list = dao.find("from User where name <> ?1 and name=?2", new Object[]{oldUser.getName(), po.getName()});
            if (list.size() > 0) {
                rs.put("ok", false);
                rs.put("msg", "用户名已被注册");
                return rs;
            }
            //修改时判断是否修改了密码
            //判断原密码是否是MD5加密过的密码,如果是,表示没有修改密码,不需要重新加密,如果不是,表示修改过密码,需要重新加密
            //MD5的正则表达式
            String pattern = "[0-9a-fA-F]{32}";
            boolean test = Pattern.compile(pattern).matcher(po.getPwd()).matches();
            if (!test) {
                Md5Hash md5Hash = new Md5Hash(po.getPwd());
                po.setPwd(md5Hash.toString());
            }
            //修改时判断邮箱是否被其他用户绑定
            if (LT.isNotEmpty(po.getMail())) {
                List<User> list1 = dao.find("from User where id <> ?1 and mail=?2", new Object[]{po.getId(), po.getMail()});
                if (list1.size() > 0) {
                    rs.put("ok", false);
                    rs.put("msg", "该邮箱已被其他用户绑定");
                    return rs;
                }
            }
            po.setUpdateTime(new Timestamp(new Date().getTime()));
            dao.update(po);

        }
        //给session里的用户头像重新赋值
        if (LT.isNotEmpty(po.getPic())) {
            //session里的User
            Subject subject = SecurityUtils.getSubject();
            User user = (User) subject.getPrincipal();
            user.setPic(po.getPic());
        }
        rs.put("ok", true);
        return rs;
    }

    //上传头像
    @RequestMapping("picUpload")
    @ResponseBody
    JSONObject picUpload(MultipartFile[] file) {
        JSONObject rs = new JSONObject();
        //输出目录
        String dir = "userPic";
        JSONArray ja = LT.multipartUpload2(file, dir);
        if (ja.size() > 0) {
            JSONObject jo = (JSONObject) ja.get(0);
            String pic = dir + "/" + jo.get("fileName");
            //向前端返回照片的访问地址以供显示和保存
            rs.put("pic", pic);
            rs.put("ok", true);
        }
        return rs;
    }

    //锁定用户
    @RequestMapping("locked")
    @ResponseBody
    JSONObject locked(Integer id, Boolean locked) {
        JSONObject rs = new JSONObject();
        dao.executeSql("update user set locked=?1 where id=?2", new Object[]{locked, id});
        dao.executeSql("update user set updateTime=?1 where id=?2", new Object[]{new Date(), id});
        rs.put("ok", true);
        return rs;
    }

    //修改密码
    @RequestMapping("updatePwd")
    @ResponseBody
    JSONObject updatePwd(Integer id, String newPwd) {
        JSONObject rs = new JSONObject();
        Md5Hash newPwdHash = new Md5Hash(newPwd);
        dao.executeSql("update user set pwd=?1 where id=?2", new Object[]{newPwdHash.toString(), id});
        dao.executeSql("update user set updateTime=?1 where id=?2", new Object[]{new Date(), id});
        rs.put("ok", true);
        return rs;
    }
    //################################################角色管理################################################################

    //生成角色树
    @RequestMapping("listRole")
    @ResponseBody
    JSONArray listRole() {
        List<Role> list = dao.find("from Role order by convertGBK(name)", null);
        JSONArray data = new JSONArray();
        list.forEach(po -> {
            JSONObject jo = new JSONObject();
            jo.put("id", po.getId());
            jo.put("title", po.getName());
            data.add(jo);
        });
        return data;
    }

    //根据用户id获取角色id的集合
    @RequestMapping("getRoleIdByUserId")
    @ResponseBody
    JSONArray getRoleIdByUserId(Integer id) {
        List<UserRole> list = dao.find("from UserRole where user.id=?1", new Object[]{id});
        JSONArray data = new JSONArray();
        list.forEach(po -> {
            data.add(po.getRole().getId());
        });
        return data;
    }

    //给用户添加角色
    @RequestMapping("addRole")
    @ResponseBody
    JSONObject addRole(Integer id, Integer[] roleIds) {
        //先删除用户角色表中,该用户对应的记录
        dao.executeSql("delete from user_role where userId=?1", new Object[]{id});
        //然后再给该用户添加角色
        for (Integer roleId : roleIds) {
            dao.executeSql("insert into user_role (userId,roleId) values (?1,?2)", new Object[]{id, roleId});
        }
        JSONObject rs = new JSONObject();
        rs.put("ok", true);
        return rs;
    }
    //################################################菜单管理################################################################

    //生成菜单树
    @RequestMapping("listMenu")
    @ResponseBody
    JSONObject listMenu() {
        JSONObject rs = new JSONObject();
        JSONArray ja = tree.getMenu(null);
        rs.put("status", JSON.parse("{\"code\":200,\"message\":\"操作成功\"}"));
        rs.put("data", ja);
        return rs;
    }

    //根据用户id获取角色id获取菜单id的集合
    @RequestMapping("getMenuIdByRoleId")
    @ResponseBody
    JSONArray getMenuIdByRoleId(Integer id) {
        List<Menu> list = dao.findBySqlNoMapping(Menu.class, "select d.* from user a " +
                "join user_role b on b.userId=a.id " +
                "join role_menu c on c.roleId=b.roleId " +
                "join menu d on d.id=c.menuId where a.id=?1", new Object[]{id});
        JSONArray data = new JSONArray();
        list.forEach(po -> {
            data.add(po.getId());
        });
        return data;
    }

    //给用户的所有角色添加菜单
    @RequestMapping("addMenu")
    @ResponseBody
    JSONObject addMenu(Integer id, Integer[] menuIds) {
        JSONObject rs = new JSONObject();
        //先判断该用户是否有角色
        List<Integer> roleIds = dao.findBySql("select roleId from user_role where userId=?1", new Object[]{id});
        if (LT.listEmpty(roleIds)) {
            rs.put("ok", false);
            rs.put("msg", "该用户还没有角色");
            return rs;
        }
        //先删除角色菜单表中,该用户对应的所有roleId的记录
        dao.executeSql("delete from role_menu where roleId in (select roleId from user_role where userId=?1)", new Object[]{id});
        //然后再给该用户的所有角色添加菜单
        roleIds.forEach(roleId -> {
            for (Integer menuId : menuIds) {
                dao.executeSql("insert into role_menu(roleId,menuId) values (?1,?2)", new Object[]{roleId, menuId});
            }
        });
        rs.put("ok", true);
        return rs;
    }

    //################################################功能管理################################################################

    //生成功能树
    @RequestMapping("listPerm")
    @ResponseBody
    JSONObject listPerm() {
        JSONObject rs = new JSONObject();
        JSONArray ja = tree.getPerm(null);
        rs.put("status", JSON.parse("{\"code\":200,\"message\":\"操作成功\"}"));
        rs.put("data", ja);
        return rs;
    }

    //根据用户id获取角色id获取功能id的集合
    @RequestMapping("getPermIdByRoleId")
    @ResponseBody
    JSONArray getPermIdByRoleId(Integer id) {
        List<Permission> list = dao.findBySqlNoMapping(Permission.class, "select d.* from user a " +
                "join user_role b on b.userId=a.id " +
                "join role_permission c on c.roleId=b.roleId " +
                "join permission d on d.id=c.permissionId where a.id=?1", new Object[]{id});
        JSONArray data = new JSONArray();
        list.forEach(po -> {
            data.add(po.getId());
        });
        return data;
    }

    //给用户的所有角色添加功能
    @RequestMapping("addPerm")
    @ResponseBody
    JSONObject addPerm(Integer id, Integer[] permissionIds) {
        JSONObject rs = new JSONObject();
        //先判断该用户是否有角色
        List<Integer> roleIds = dao.findBySql("select roleId from user_role where userId=?1", new Object[]{id});
        if (LT.listEmpty(roleIds)) {
            rs.put("ok", false);
            rs.put("msg", "该用户还没有角色");
            return rs;
        }
        //先删除角色功能表中,该用户对应的所有roleId的记录
        dao.executeSql("delete from role_permission where roleId in (select roleId from user_role where userId=?1)", new Object[]{id});
        //然后再给该用户的所有角色添加功能
        roleIds.forEach(roleId -> {
            for (Integer permId : permissionIds) {
                dao.executeSql("insert into role_permission(roleId,permissionId) values (?1,?2)", new Object[]{roleId, permId});
            }
        });
        //刷新功能权限
        clearAuth.updatePermission();
        rs.put("ok", true);
        return rs;
    }
}
