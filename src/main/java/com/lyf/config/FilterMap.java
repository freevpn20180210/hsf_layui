package com.lyf.config;

import com.lyf.common.SupperDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * shiro自定义过滤器类
 * author:lyf
 * 20200605
 */
@Component
public class FilterMap {
    @Autowired
    SupperDao dao;

    //过滤器
    public Map<String, String> filterMap() {
        Map<String, String> map = new LinkedHashMap<>();

        //静态资源
        map.put("/layuiadmin/**", "anon");
        map.put("/my/**", "anon");

        //403,404
        map.put("/views/403.jsp", "anon");
        map.put("/views/404.jsp", "anon");

        //登录
        map.put("/views/login.jsp", "anon");
        map.put("/getKaptcha", "anon");
        map.put("/userLogin", "anon");
        map.put("/juhe/guest", "anon");

        //忘记密码
        map.put("/views/sys/user/forget.jsp", "anon");
        map.put("/forget/isUserExist", "anon");
        map.put("/forget/isMailVerify", "anon");
        map.put("/forget/verifyCode", "anon");
        map.put("/forget/sendCode", "anon");
        map.put("/forget/verifyMailCode", "anon");
        map.put("/forget/toResetPwd", "anon");
        map.put("/forget/resetPwd", "anon");

        /***************************************以上url不拦截******************************************************/

        //从表中添加要过滤的url,角色必须拥有该url权限才能访问该url--若某url未被添加,则该url默认放行
        List<String> list = (List<String>) dao.find("select href from Permission where href <> ''", null);
        list.forEach(href -> {
            map.put("/" + href, "perms[" + href + "]");
        });

        //其他url都必须认证后才可以访问,该行代码必须放在最后面
        map.put("/**", "user");
        return map;
    }
}
