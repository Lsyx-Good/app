package com.qams.app.utils;

import java.util.ArrayList;
import java.util.List;

import com.qams.app.bean.Permissions;
import com.qams.app.bean.Roles;
import com.qams.app.bean.Users;
import com.qams.app.service.UsersService;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

public class MyRealm extends AuthorizingRealm{
    @Autowired
    private UsersService usersService;
    
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
    // TODO Auto-generated method stub
    String uname = (String) principals.getPrimaryPrincipal(); //获得已经登录的用户名称
    Users users = login(uname);
    SimpleAuthorizationInfo info = new  SimpleAuthorizationInfo();
    List<Roles> list =  users.getList(); // 登录角色集合
    List<String> rolesNames = new ArrayList<>();
    for (Roles roles :list) {        
        rolesNames.add(roles.getRname());
        info.addRoles(rolesNames);
    }

    List<String> perNames = new ArrayList<>();

    List<Permissions> permissionsList =  users.getPList();

    for(Permissions permissions : permissionsList){
        perNames.add(permissions.getPname());
    }

    info.addStringPermissions(perNames);
    
    return info;
        
    }


    private Users login(String username) {
        
        return usersService.login(username);
        
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        // TODO Auto-generated method stub
        SimpleAuthenticationInfo info = null;
        String username =  (String)token.getPrincipal();
        Users users = login(username);
        if (users != null) {
            SecurityUtils.getSubject().getSession().setAttribute("users", users);
            info = new SimpleAuthenticationInfo(users.getUname(),users.getPassword(),super.getName());
        }
        return info;
        
    }
}