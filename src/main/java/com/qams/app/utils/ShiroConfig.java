package com.qams.app.utils;

import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.LinkedHashMap;
import java.util.Map;
@Configuration
public class ShiroConfig {
    @Bean
    public  MyRealm getMyRealm(){
        return new MyRealm();
    }

    @Bean
    public DefaultWebSecurityManager getSecurityManager(){
        DefaultWebSecurityManager ds= new DefaultWebSecurityManager();
        ds.setRealm(this.getMyRealm());
        return  ds;
    }

    @Bean
    public ShiroFilterFactoryBean   shiroFilterFactoryBean(){
        ShiroFilterFactoryBean filter=new ShiroFilterFactoryBean();
        filter.setSecurityManager(this.getSecurityManager());//注入上面的getSecurityManager获得SecurityManager对象
        filter.setLoginUrl("/login.jsp");//登录启动页面时login.html
        filter.setUnauthorizedUrl("/login.jsp"); //未登录访问的页面也login.html页面
        Map<String,String>map=new LinkedHashMap<>();
        map.put("/users/login","anon");//不需要认证可以直接(匿名)访问
        map.put("/jeasyui/**","anon"); //不需要认证可以直接(匿名)访问
        map.put("/zhuxiao","logout");
        map.put("/**","authc");//只有认证之后才能访问
        filter.setFilterChainDefinitionMap(map);
        return filter;

    }




}
