package com.qams.app.service;

import java.util.List;

import com.qams.app.bean.Roles;

public interface RolesService {
    
    List<Roles> listRoles();

    int saveRoles(Integer rid,Integer uid);

    List<Roles> listPageRoles(int page,int rows);

    int countRoles();

}
