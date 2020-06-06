package com.lyf.controller.pan;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lyf.common.LT;
import com.lyf.common.Page;
import com.lyf.common.SupperDao;
import com.lyf.controller.BaseController;
import com.lyf.po.pan.Pan;
import com.lyf.po.sys.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileNotFoundException;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * 我的网盘
 * author:lyf
 * 20200605
 */
@Controller
@RequestMapping("pan")
public class PanCon extends BaseController {

    @Autowired
    SupperDao dao;

    //根据userId读取用户上传的文件
    @RequestMapping("list")
    @ResponseBody
    JSONObject list(String[] keywords, Page page) {
        JSONObject rs = new JSONObject();

        //session里的User
        Subject subject = SecurityUtils.getSubject();
        User user = (User) subject.getPrincipal();

        Object[] o = null;
        if (LT.arrNotEmpty(keywords)) {
            //数组->集合
            List keywordsList = new ArrayList(Arrays.asList(keywords));
            keywordsList.add(user.getId());
            //集合->数组
            o = keywordsList.toArray();
        }

        List<Pan> list;
        BigInteger count = null;
        if (LT.arrNotEmpty(keywords)) {
            list = dao.findByPage("from Pan " +
                    "where name like concat('%',?1,'%') " +
                    "and createTime like concat('%',?2,'%') " +
                    "and userId=?3 " +
                    "order by createTime desc,convertGBK(name)", page, o);
            count = (BigInteger) dao.findOneBySql("select count(*) from pan " +
                            "where name like concat('%',?1,'%') " +
                            "and createTime like concat('%',?2,'%') " +
                            "and userId=?3 "
                    , o);
        } else {
            list = dao.findByPage("from Pan where userId=?1 order by createTime desc,convertGBK(name)"
                    , page, new Object[]{user.getId()});
            count = (BigInteger) dao.findOneBySql("select count(*) from pan where userId=?1", new Object[]{user.getId()});
        }
        JSONArray data = new JSONArray();
        list.forEach(po -> {
            data.add(po);
        });
        rs.put("data", data);
        rs.put("code", 0);
        rs.put("msg", "");
        rs.put("count", count);
        return rs;
    }

    //上传文件
    @RequestMapping("fileUpload")
    @ResponseBody
    JSONObject picUpload(MultipartFile[] file) {
        JSONObject rs = new JSONObject();
        Subject subject = SecurityUtils.getSubject();
        User user = (User) subject.getPrincipal();
        user = (User) dao.findOne("from User where id=?1", new Object[]{user.getId()});
        double fileSize = file[0].getSize();
        //如果当前用户的可用容量<=0,不能上传
        if (user.getUsablePanSize() <= 0) {
            rs.put("ok", false);
            rs.put("msg", "容量不足,无法上传");
            return rs;
        }
        //如果当前用户可用容量-文件大小<0,不能上传
        if (user.getUsablePanSize() * 1024 * 1024 - fileSize < 0) {
            rs.put("ok", false);
            rs.put("msg", "上传文件大小超过可用容量,无法上传");
            return rs;
        }
        //当文件大于100MB
        if (fileSize > 100 * 1024 * 1024) {
            //根据登录用户的角色,判断是否是管理员,管理员不限制上传文件大小,非管理员限制上传文件大小
            String sql = "SELECT c.name from user a join user_role b on a.id=b.userId join role c on c.id=b.roleId and a.id=?1";
            List<String> roleNames = dao.findBySql(sql, new Object[]{user.getId()});
            if (!roleNames.contains("管理员")) {
                rs.put("ok", false);
                rs.put("msg", "非管理员一次上传的文件大小不能超过100MB");
                return rs;
            }
        }
        //输出目录
        String dir = "pan/" + user.getId();
        JSONArray ja = LT.multipartUpload2(file, dir);
        if (ja.size() > 0) {
            JSONObject jo = (JSONObject) ja.get(0);
            String fileName = jo.getString("fileName");
            String size = jo.getString("size") + "KB";
            String path = dir + "/" + jo.getString("fileName");

            Pan po = new Pan();
            po.setName(fileName);
            po.setSize(size);
            po.setCreateTime(new Timestamp(new Date().getTime()));
            po.setPath(path);
            po.setUserId(user.getId());
            dao.save(po);

            //上传完毕用户网盘的可用容量=可用容量-已上传的文件大小
            user.setUsablePanSize(user.getUsablePanSize() - LT.div(fileSize, 1024 * 1024, 2));
            dao.update(user);
            rs.put("ok", true);
        }
        return rs;
    }

    //删除文件
    @RequestMapping("del")
    @ResponseBody
    JSONObject del(Integer[] ids) throws FileNotFoundException {
        List<String> list = new ArrayList();
        List<String> list1 = new ArrayList();
        List<Long> list2 = new ArrayList();
        //根据文件id找到文件对应路径,大小
        for (Integer id : ids) {
            String path = (String) dao.findOneBySql("select path from pan where id=?1", new Object[]{id});
            String size = (String) dao.findOneBySql("select size from pan where id=?1", new Object[]{id});
            list.add(path);
            list1.add(size);
        }
        //根据文件路径删除硬盘上的文件,删除文件
        for (String path : list) {
            LT.deleteFile(path);
        }
        //删除表中数据
        dao.delAll(Pan.class, ids);

        //将文件大小(含KB)->long
        for (String size : list1) {
            list2.add(Long.parseLong(size.substring(0, size.length() - 2)));
        }
        //合计删除的文件总大小
        long totalFileSize = 0;
        for (Long aLong : list2) {
            totalFileSize += aLong;
        }
        Subject subject = SecurityUtils.getSubject();
        User user = (User) subject.getPrincipal();
        user = (User) dao.findOne("from User where id=?1", new Object[]{user.getId()});
        //删除完毕用户网盘的可用容量=可用容量+已删除的文件总大小
        user.setUsablePanSize(user.getUsablePanSize() + LT.div(totalFileSize, 1024, 2));
        dao.update(user);

        JSONObject jo = new JSONObject();
        jo.put("ok", true);
        return jo;
    }

    //得到登录的用户的网盘容量信息
    @RequestMapping("getLoginUserPanInfo")
    @ResponseBody
    JSONObject getLoginUserPanInfo() {
        Subject subject = SecurityUtils.getSubject();
        User user = (User) subject.getPrincipal();
        user = (User) dao.findOne("from User where id=?1", new Object[]{user.getId()});
        JSONObject rs = new JSONObject();
        rs.put("total", user.getPanSize());
        rs.put("usable", user.getUsablePanSize());
        rs.put("used", user.getPanSize() - user.getUsablePanSize());
        double usedRate = LT.div((user.getPanSize() - user.getUsablePanSize()), user.getPanSize(), 2) * 100;
        rs.put("usedRate", usedRate);
        rs.put("ok", true);
        return rs;
    }

}
