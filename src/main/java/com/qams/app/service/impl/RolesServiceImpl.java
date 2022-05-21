package com.qams.app.service.impl;

import java.util.List;

import com.qams.app.bean.Roles;
import com.qams.app.bean.Users;
import com.qams.app.dao.RolesDao;
import com.qams.app.dao.UsersDao;
import com.qams.app.service.RolesService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RolesServiceImpl implements RolesService {
    @Autowired
    private RolesDao rolesDao;
    
    @Autowired
    private UsersDao usersDao;
    
    @Override
    public List<Roles> listRoles(){
        return rolesDao.list();
    }

    @Override
    public  int saveRoles(Integer rid,Integer uid){
        Users users  = usersDao.get(uid);
        if (users != null){
            int size = users.getList().size();
            if (size > 0){
                return -1;
            }
        }
        return rolesDao.save(rid,uid);
    }

    @Override
    public List<Roles> listPageRoles(int page,int rows){
        return rolesDao.listPage((page-1)*rows,rows);
    }

    public int countRoles(){
        return rolesDao.count();
    }
}
