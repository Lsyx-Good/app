package com.qams.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.qams.app.aop.SystemControllerLog;
import com.qams.app.bean.Users;
import com.qams.app.service.UsersService;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
@RestController
@RequestMapping("/users")
public class UsersController {
    @Autowired
    private UsersService usersService;

    @SystemControllerLog(description="用户登录")
    @RequestMapping("/login")
    public int login(String username, String password){
        //0=>fail 1 =>success
        UsernamePasswordToken token = new UsernamePasswordToken(username,
        new Md5Hash(password,username+password, 1000).toString());

        Subject subject = SecurityUtils.getSubject();
        try {
            if (!subject.isAuthenticated()){
                subject.login(token);
            }
        } catch (AuthenticationException authenticationException) {
            //TODO: handle exception
            System.out.println("认证失败");
            return 0;
        }
        return 1;
    }
    
    @SystemControllerLog(description="分页查询用户信息")
    @RequestMapping("/listUsers")
    public Map<String,Object> listUsers(Integer page, Integer rows,String uname){
        Map<String,Object> map = new HashMap<>();
        map.put("total",usersService.countUsers(uname));
        map.put("rows",usersService.listUsers(page,rows,uname));
        return map;
    }

    @SystemControllerLog(description="添加用户信息")
    @RequestMapping("/saveUsers")
    public boolean saveUsers(Users users){
        return usersService.saveUsers(users); 
    }

    @SystemControllerLog(description="删除用户信息")
    @RequestMapping("/removeUsers")
    public boolean removeUsers(@RequestParam("uids[]")List<Integer> uids){
        return usersService.removeUsers(uids); 
    }

    @SystemControllerLog(description="修改用户信息")
    @RequestMapping("/updateUsers")
    public boolean updateUsers(Users users){
        return usersService.updateUsers(users); 
    }

    @SystemControllerLog(description="修改用户状态信息")
    @RequestMapping("/changeUserStat")
    public boolean changeUserStat(int uid) {
        return usersService.changeUserStat(uid) > 0 ? true :false;
    }

    
    @RequestMapping("/countSexTimes")
    public List<Users>  countSexTimes(){
        return usersService.countSexTimes();

    }


}
