package com.lyf.tool;

import com.lyf.config.FilterMap;
import com.lyf.realm.LoginRealm;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.mgt.RealmSecurityManager;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.filter.mgt.DefaultFilterChainManager;
import org.apache.shiro.web.filter.mgt.PathMatchingFilterChainResolver;
import org.apache.shiro.web.servlet.AbstractShiroFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * shiro刷新功能权限类
 * author:lyf
 * 20200605
 */
@Component
public class ClearAuth {


    @Autowired
    FilterMap filterMap;

    @Autowired
    ShiroFilterFactoryBean shiroFilterFactoryBean;

    public synchronized void updatePermission() {
        try {
            AbstractShiroFilter abstractFilter = (AbstractShiroFilter) shiroFilterFactoryBean.getObject();
            //获取过滤器链管理器
            PathMatchingFilterChainResolver filterChainResolver = (PathMatchingFilterChainResolver) abstractFilter.getFilterChainResolver();
            DefaultFilterChainManager filterChainManager = (DefaultFilterChainManager) filterChainResolver.getFilterChainManager();
            // 清空过滤器链,即清空初始的拦截配置
            filterChainManager.getFilterChains().clear();
            shiroFilterFactoryBean.getFilterChainDefinitionMap().clear();

            //过滤器
            Map<String, String> map = filterMap.filterMap();

            //putAll可以合并两个map，只不过如果有相同的key那么用后面的覆盖前面的
            shiroFilterFactoryBean.getFilterChainDefinitionMap().putAll(map);
            map.forEach((k, v) -> {
                filterChainManager.createChain(k, v);
            });

            RealmSecurityManager rsm = (RealmSecurityManager) SecurityUtils.getSecurityManager();
            LoginRealm loginRealm = (LoginRealm) rsm.getRealms().iterator().next();
            loginRealm.clearAuthorizationInfo();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
