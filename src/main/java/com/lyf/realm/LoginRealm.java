package com.lyf.realm;

import com.lyf.common.LT;
import com.lyf.common.SupperDao;
import com.lyf.po.sys.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * shiro认证和鉴权类
 * author:lyf
 * 20200605
 */
public class LoginRealm extends AuthorizingRealm {

    @Autowired
    private SupperDao dao;

    public static void main(String[] args) {
        Md5Hash md5Hash = new Md5Hash("admin");
        System.out.println(md5Hash.toString());
    }

    // 认证:根据用户名查询出用户的账号密码等信息
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        UsernamePasswordToken usernamePasswordToken = (UsernamePasswordToken) token;
        String userName = usernamePasswordToken.getUsername();
        User user = (User) dao.findOne("from User where name=?1 and locked=false", new Object[]{userName});
        if (LT.isNotEmpty(user)) {
            // SimpleAuthenticationInfo把user.getPwd()与UsernamePasswordToken中的密码(MD5加密)比较
            // 若相等,则认证通过;若不相等,则认证不通过,抛出IncorrectCredentialsException
            SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(user,
                    user.getPwd(), this.getClass().getName());
            return authenticationInfo;
        } else {
            // 返回为null表示不能找到用户名,认证不通过,抛出UnknownAccountException
            return null;
        }
    }

    // 鉴权--在访问被过滤的url时判断是否授权,仅触发一次
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        User user = (User) principalCollection.fromRealm(this.getClass().getName()).iterator().next();
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        //根据用户id获取该用户的所有角色
        String sql = "SELECT c. NAME FROM USER a JOIN user_role b ON a.id = b.userId JOIN role c ON b.roleId = c.id WHERE userId = ?1";
        List<String> roleNameList = dao.findBySql(sql, new Object[]{user.getId()});
        //根据用户id获取用户的所有角色对应的所有功能权限
        String sql1 = "SELECT d.href FROM USER a JOIN user_role b ON a.id = b.userId JOIN role_permission c ON b.roleId = c.roleId JOIN permission d ON c.permissionId = d.id WHERE a.id = ?1 AND d.href <> ''";
        List<String> permissionHrefList = dao.findBySql(sql1, new Object[]{user.getId()});
        //把该用户的所有角色和功能权限添加到shiro里
        authorizationInfo.addRoles(roleNameList);
        authorizationInfo.addStringPermissions(permissionHrefList);
        return authorizationInfo;
    }

    //刷新功能权限
    public void clearAuthorizationInfo() {
        super.clearCachedAuthorizationInfo(SecurityUtils.getSubject().getPrincipals());
    }
}
