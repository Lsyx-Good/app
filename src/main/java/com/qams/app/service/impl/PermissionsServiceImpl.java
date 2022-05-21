package com.qams.app.service.impl;

import java.util.List;

import com.qams.app.bean.Permissions;
import com.qams.app.bean.Roles;
import com.qams.app.dao.PermissionsDao;
import com.qams.app.dao.RolesDao;
import com.qams.app.service.PermissionsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class PermissionsServiceImpl implements PermissionsService{
    @Autowired
    private PermissionsDao permissionsDao;

    @Autowired
    private RolesDao rolesDao;
    
    @Override
    public List<Permissions> listPermissions(){
        return permissionsDao.list();
    }

    @Override
    public int savePermissions(List<Integer> pids,int rid){
        Roles roles = rolesDao.get(rid);
        int size =  roles.getPermissionsList().size();
        
        if (size > 0) {
            return -1;   
        }
        int count = 0;
        for (Integer pid : pids){
            count  = permissionsDao.save(pid,rid);
        }
        return count;
    }

    @Override
    public int removePermissions(int rid){
        Roles roles = rolesDao.get(rid);
        int size =  roles.getPermissionsList().size();
    
        return size > 0 ? permissionsDao.remove(rid):-1;
      
    }



}
