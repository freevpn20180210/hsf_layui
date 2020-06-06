package com.lyf.controller.sys;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lyf.common.LT;
import com.lyf.common.SupperDao;
import com.lyf.controller.BaseController;
import com.lyf.po.sys.User;
import com.lyf.po.sys.UserRole;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * 基本资料
 * author:lyf
 * 20200605
 */
@Controller
@RequestMapping("userInfo")
public class UserInfoCon extends BaseController {

    @Autowired
    SupperDao dao;

    //基本资料
    @RequestMapping("getUser")
    public String getUser(Integer userId, ModelMap m) {
        if (LT.isNotEmpty(userId)) {
            User User = (User) dao.findOne("from User where id =?1", new Object[]{userId});
            List<UserRole> userRoleList = dao.find("from UserRole where user.id=?1", new Object[]{userId});
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
            m.put("po", User);
            m.put("roleName", LT.isEmpty(roleName) ? "暂无角色" : roleName);
        }
        return "sys/user/info/info.jsp";
    }

    //上传头像
    @RequestMapping("picUpload")
    @ResponseBody
    public JSONObject picUpload(MultipartFile[] file) {
        JSONObject rs = new JSONObject();
        //输出目录
        String dir = "userPic";
        JSONArray ja = LT.multipartUpload2(file, dir);
        if (ja.size() > 0) {
            JSONObject jo = (JSONObject) ja.get(0);
            String pic = dir + "/" + jo.get("fileName");
            //向前端返回头像的输出地址,以供保存
            rs.put("pic", pic);
            rs.put("ok", true);
        }
        return rs;
    }

    //邮箱是否被其他用户绑定
    @RequestMapping("isBlindByOthers")
    @ResponseBody
    private JSONObject isBlindByOthers(String mail) {
        JSONObject rs = new JSONObject();
        if (LT.isNotEmpty(mail)) {
            Subject subject = SecurityUtils.getSubject();
            User user = (User) subject.getPrincipal();
            List<User> list = dao.find("from User where id <> ?1 and mail=?2", new Object[]{user.getId(), mail});
            if (list.size() > 0) {
                rs.put("ok", false);
                rs.put("msg", "该邮箱已被其他用户绑定");
            } else {
                rs.put("ok", true);
            }
        }
        return rs;
    }

    //发送邮箱验证码
    @RequestMapping("sendCode")
    @ResponseBody
    public JSONObject sendCode(HttpServletRequest request, String mail) {
        JSONObject jo = new JSONObject();
        if (LT.isNotEmpty(mail)) {
            try {
                //Math.random():[0.0,1.0)
                //取值:[1000,10000)
                String mailCode = String.valueOf((int) ((Math.random() * 9 + 1) * 1000));
                LT.sendEmail(mail, "验证码", mailCode);
                request.getSession().setAttribute("mailCode", mailCode);
                jo.put("ok", true);
            } catch (Exception e) {
                e.printStackTrace();
                jo.put("ok", false);
                jo.put("msg", "电波无法到达o(╥﹏╥)o,请再试一次");
            }
        }
        return jo;
    }

    //基本资料保存
    @RequestMapping("saveUpdate")
    @ResponseBody
    public JSONObject saveUpdate(User po, String code, HttpServletRequest request) {
        JSONObject rs = new JSONObject();

        //session里的User
        Subject subject = SecurityUtils.getSubject();
        User user = (User) subject.getPrincipal();

        //给session里的用户头像重新赋值
        user.setPic(po.getPic());

        if (po.getMailVerified() == null) {
            if (LT.isEmpty(po.getMail())) {
                po.setMailVerified(null);
            } else {
                po.setMailVerified(false);
            }
        } else {
            //当邮箱已被验证
            if (po.getMailVerified()) {
                //如果邮箱为空,设为null
                if (LT.isEmpty(po.getMail())) {
                    po.setMailVerified(null);
                } else {
                    //更换新邮箱将不再被验证
                    if (!user.getMail().equals(po.getMail())) {
                        po.setMailVerified(false);
                    }
                }
            } else {//当邮箱未被验证
                //当没有填写邮箱验证码就设为false
                if (LT.isEmpty(code)) {
                    po.setMailVerified(false);
                } else {//当填写了邮箱验证码就做判断
                    String mailCode = (String) request.getSession().getAttribute("mailCode");
                    if (LT.isNotEmpty(mailCode)) {
                        if (mailCode.equals(code)) {
                            po.setMailVerified(true);
                        } else {
                            rs.put("ok", false);
                            rs.put("msg", "邮箱验证码错误");
                            return rs;
                        }
                    }
                }
            }
        }

        //给session里的用户邮箱重新赋值
        user.setMail(po.getMail());

        po.setUpdateTime(new Timestamp(new Date().getTime()));
        dao.update(po);

        rs.put("ok", true);
        return rs;
    }

    //修改密码
    @RequestMapping("updatePwd")
    @ResponseBody
    public JSONObject userInfoUpdatePwd(String oldPwd, String newPwd) {
        JSONObject jo = new JSONObject();
        if (LT.isNotEmpty(newPwd)) {
            Subject subject = SecurityUtils.getSubject();
            User user = (User) subject.getPrincipal();
            //把输入的旧密码用MD5加密
            Md5Hash oldPwdHash = new Md5Hash(oldPwd);
            //与数据库中的密码(MD5加密)比较
            if (oldPwdHash.toString().equals(user.getPwd())) {
                //相同则把新密码用MD5加密
                Md5Hash newPwdHash = new Md5Hash(newPwd);
                user.setPwd(newPwdHash.toString());
                user.setUpdateTime(new Timestamp(new Date().getTime()));
                dao.update(user);
                subject.logout();
                jo.put("ok", true);
            } else {
                jo.put("ok", false);
                jo.put("msg", "原密码错误");
            }
        }
        return jo;
    }
}
