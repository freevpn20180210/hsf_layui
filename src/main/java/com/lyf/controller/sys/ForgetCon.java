package com.lyf.controller.sys;

import com.alibaba.fastjson.JSONObject;
import com.lyf.common.LT;
import com.lyf.common.SupperDao;
import com.lyf.controller.BaseController;
import com.lyf.po.sys.User;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.Date;

/**
 * 忘记密码
 * author:lyf
 * 20200605
 */
@Controller
@RequestMapping("forget")
public class ForgetCon extends BaseController {

    //能否重置密码的标识
    private static boolean canResetPwd = false;
    @Autowired
    SupperDao dao;

    //根据用户名,查询是否有该用户
    @RequestMapping("isUserExist")
    @ResponseBody
    JSONObject isUserExist(String name) {
        JSONObject rs = new JSONObject();
        User user = (User) dao.findOne("from User where name=?1", new Object[]{name});
        if (LT.isNotEmpty(user)) {
            rs.put("ok", true);
            canResetPwd = true;
        } else {
            rs.put("ok", false);
            rs.put("msg", "没有该用户");
            canResetPwd = false;
        }
        return rs;
    }

    //根据用户名和邮箱,查询该用户绑定的邮箱是否验证
    @RequestMapping("isMailVerify")
    @ResponseBody
    JSONObject isMailVerify(String name, String mail) {
        JSONObject rs = new JSONObject();
        User user = (User) dao.findOne("from User where name=?1 and mail=?2", new Object[]{name, mail});
        if (LT.isNotEmpty(user)) {
            if (user.getMailVerified()) {
                rs.put("ok", true);
                canResetPwd = true;
            } else {
                rs.put("ok", false);
                rs.put("msg", "该用户绑定的邮箱未验证");
                canResetPwd = false;
            }
        } else {
            rs.put("ok", false);
            rs.put("msg", "用户名邮箱不正确");
            canResetPwd = false;
        }
        return rs;
    }

    //验证图形验证码
    @RequestMapping("verifyCode")
    @ResponseBody
    JSONObject verifyCode(String verifyCode, HttpServletRequest request) {
        JSONObject rs = new JSONObject();
        //获取session中的验证码
        String sessionVerifyCode = (String) request.getSession().getAttribute("verifyCode");
        //与前端的对比
        if (sessionVerifyCode.equals(verifyCode)) {
            rs.put("ok", true);
            canResetPwd = true;
        } else {
            rs.put("ok", false);
            rs.put("msg", "图形验证码错误");
            canResetPwd = false;
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
                canResetPwd = true;
            } catch (Exception e) {
                e.printStackTrace();
                jo.put("ok", false);
                jo.put("msg", "电波无法到达o(╥﹏╥)o,请再试一次");
                canResetPwd = false;
            }
        }
        return jo;
    }

    //验证邮箱验证码
    @RequestMapping("verifyMailCode")
    @ResponseBody
    public JSONObject verifyMailCode(HttpServletRequest request, String code) {
        JSONObject rs = new JSONObject();
        String mailCode = (String) request.getSession().getAttribute("mailCode");
        if (LT.isNotEmpty(mailCode)) {
            if (mailCode.equals(code)) {
                rs.put("ok", true);
                canResetPwd = true;
            } else {
                rs.put("ok", false);
                rs.put("msg", "邮箱验证码错误");
                canResetPwd = false;
            }
        }
        return rs;
    }

    //跳转到重置密码页面
    @RequestMapping("toResetPwd")
    public String toResetPwd(String name) {
        if (canResetPwd) {
            return "sys/user/resetPwd.jsp?name" + name;
        } else {
            return "404.jsp";
        }
    }

    //重置密码
    @RequestMapping("resetPwd")
    @ResponseBody
    public JSONObject resetPwd(String name, String newPwd, String rePwd) {
        JSONObject rs = new JSONObject();
        if (canResetPwd) {
            if (newPwd.equals(rePwd)) {
                //md5加密
                Md5Hash md5Hash = new Md5Hash(newPwd);
                dao.executeSql("update user set pwd=?1 where name=?2", new Object[]{md5Hash.toString(), name});
                dao.executeSql("update user set updateTime=?1 where name=?2", new Object[]{new Timestamp(new Date().getTime()), name});
                rs.put("ok", true);
            }
        }
        return rs;
    }
}
