package com.lyf.config;

import com.lyf.realm.LoginRealm;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.cache.MemoryConstrainedCacheManager;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.CookieRememberMeManager;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.context.annotation.Bean;

import java.util.Map;

/**
 * shiro配置类
 * author:lyf
 * 20200605
 */
@SpringBootConfiguration
public class ShiroConfig {

    /**
     * 配置shiro的url拦截规则
     * shiro生命周期:
     * 1.该方法在容器启动时执行,配置拦截规则(认证前规则,认证后规则)
     * 2.进入realm认证
     * 3.认证后,当访问被拦截的url后,shiro会读取角色对应的功能权限url,若该url不存在,则拦截,否则放行
     */
    /**
     * shiro的url过滤器
     * anno:不拦截,任何人都可以访问
     * authc:登录之后才能进行访问，不包括remember me
     * user:登录之后才能进行访问，包括remember me
     */
    @Bean
    public ShiroFilterFactoryBean shiroFilterFactoryBean(FilterMap filterMap) {
        ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
        shiroFilterFactoryBean.setSecurityManager(securityManager());

        shiroFilterFactoryBean.setLoginUrl("/views/login.jsp");
        shiroFilterFactoryBean.setSuccessUrl("/");
        shiroFilterFactoryBean.setUnauthorizedUrl("/views/403.jsp");

        //过滤器
        Map<String, String> map = filterMap.filterMap();

        shiroFilterFactoryBean.setFilterChainDefinitionMap(map);
        return shiroFilterFactoryBean;
    }

    /********************************************第一部分*******************************************************/
    //    shiro的密码解密器
    @Bean
    public HashedCredentialsMatcher matcher() {
        HashedCredentialsMatcher matcher = new HashedCredentialsMatcher();
        matcher.setHashAlgorithmName("md5");
        matcher.setHashIterations(1);
        return matcher;
    }

    //    认证授权realm
    @Bean
    public LoginRealm loginRealm() {
        LoginRealm loginRealm = new LoginRealm();
        loginRealm.setCredentialsMatcher(matcher());
        return loginRealm;
    }

    /*********************************************第二部分******************************************************/
    //    shiro的缓存管理器
    @Bean
    public MemoryConstrainedCacheManager cacheManager() {
        MemoryConstrainedCacheManager cacheManager = new MemoryConstrainedCacheManager();
        return cacheManager;
    }

    /**********************************************第三部分*****************************************************/
    //shiro创建的cookie对象
    @Bean
    public SimpleCookie rememberMeCookie() {
        SimpleCookie simpleCookie = new SimpleCookie("rememberMe");
        simpleCookie.setMaxAge(1 * 1 * 60 * 60);
        return simpleCookie;
    }

    //shiro的cookie管理器
    @Bean
    public CookieRememberMeManager rememberMeManager() {
        CookieRememberMeManager rememberMeManager = new CookieRememberMeManager();
//        rememberMeManager.setCipherKey(Base64.decode("2AvVhdsgUs0FSA3SDFAdag=="));
        rememberMeManager.setCookie(rememberMeCookie());
        return rememberMeManager;
    }

    /*******************************************第四部分********************************************************/


    //    shiro的安全管理器
    @Bean
    public SecurityManager securityManager() {
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
        securityManager.setRealm(loginRealm());
        securityManager.setCacheManager(cacheManager());
        securityManager.setRememberMeManager(rememberMeManager());
        return securityManager;
    }

    //    开启shiro功能权限注解
    @Bean
    public AuthorizationAttributeSourceAdvisor advisor() {
        AuthorizationAttributeSourceAdvisor advisor = new AuthorizationAttributeSourceAdvisor();
        advisor.setSecurityManager(securityManager());
        return advisor;
    }

}
