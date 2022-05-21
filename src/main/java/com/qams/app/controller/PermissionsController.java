package com.qams.app.controller;

import java.util.List;

import com.qams.app.aop.SystemControllerLog;
import com.qams.app.bean.Permissions;
import com.qams.app.service.PermissionsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
@RestController
@RequestMapping("/permissions")
public class PermissionsController {
   @Autowired
    private PermissionsService permissionsService; 

    @SystemControllerLog(description="查询所有权限初始化权限菜单")
    @RequestMapping("/listPermissions")
    public List<Permissions> listPermissions(){
        return permissionsService.listPermissions();
    }

    @SystemControllerLog(description="给角色分配权限")
    @RequestMapping("/savePermissions")
    public int savePermissions(@RequestParam("pid")List<Integer> pids,int rid){
        return  permissionsService.savePermissions(pids,rid);
    }

    @SystemControllerLog(description="删除角色权限")
    @RequestMapping("/removePermission")
    public int removePermission(int rid){
        return permissionsService.removePermissions(rid);
    }

}
