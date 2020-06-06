package com.lyf.controller.sys;

import com.alibaba.fastjson.JSONObject;
import com.lyf.common.SupperDao;
import com.lyf.controller.BaseController;
import com.lyf.po.sys.Guest;
import com.lyf.po.sys.User;
import com.lyf.tool.Kaptcha;
import com.lyf.tool.Tree;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 登录
 * author:lyf
 * 20200605
 */
@Controller
public class Login extends BaseController {
    @Autowired
    private SupperDao dao;

    @Autowired
    private Kaptcha kaptcha;
    @Autowired
    private Tree tree;

    //验证码图片地址
    @RequestMapping("getKaptcha")
    public void getKaptcha(HttpServletRequest request, HttpServletResponse response, ModelMap m) throws Exception {
        kaptcha.GenerateKaptcha(request, response);
    }

    //登录
    //路由不能是login,否则shiro不会进此方法
    @RequestMapping("userLogin")
    @ResponseBody
    public JSONObject userLogin(String verifyCode, User user, Guest guest, Boolean rememberMe, HttpServletRequest request) {
        JSONObject rs = new JSONObject();
        //获取session中的验证码
        String sessionVerifyCode = (String) request.getSession().getAttribute("verifyCode");
        //与前端的对比
        if (!sessionVerifyCode.equals(verifyCode)) {
            rs.put("ok", false);
            rs.put("msg", "验证码错误");
            return rs;
        }

        //shiro登录认证
        UsernamePasswordToken token = new UsernamePasswordToken(user.getName(), user.getPwd(), rememberMe);
        Subject subject = SecurityUtils.getSubject();
        try {
            //认证
            subject.login(token);
            User principal = (User) subject.getPrincipal();
            //存入session
            request.getSession().setAttribute("user", principal);
            //保存登录日志
            dao.save(guest);
            //设置session失效时间(单位:秒)--设0永不过期
            request.getSession().setMaxInactiveInterval(24 * 60 * 60 * 30);
            rs.put("ok", true);
        } catch (IncorrectCredentialsException e) {
            e.printStackTrace();
            rs.put("ok", false);
            rs.put("msg", "用户名或密码错误");
        } catch (UnknownAccountException e) {
            e.printStackTrace();
            rs.put("ok", false);
            rs.put("msg", "用户名不存在");
        }
        return rs;
    }

    //进入首页,加载当前用户信息
    @RequestMapping("/")
    public String index(ModelMap m) {
        Subject subject = SecurityUtils.getSubject();
        User user = (User) subject.getPrincipal();
        m.put("po", user);
        return "index.jsp";
    }

    //加载当前用户菜单
    @RequestMapping("getIndexMenu")
    @ResponseBody
    public JSONObject getMenu() {
        Subject subject = SecurityUtils.getSubject();
        User user = (User) subject.getPrincipal();
        JSONObject rs = new JSONObject();
        rs.put("code", 0);
        rs.put("msg", "");
        rs.put("data", tree.getIndexMenu(user.getId(), null));
        return rs;
    }

    //退出
    @RequestMapping("userLogout")
    @ResponseBody
    public JSONObject logout() {
        JSONObject rs = new JSONObject();
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        rs.put("ok", true);
        return rs;
    }
}
