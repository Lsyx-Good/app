package com.qams.app.service;

import java.util.List;

import com.qams.app.bean.Permissions;

public interface PermissionsService {

    List<Permissions> listPermissions();
        
    int savePermissions(List<Integer> pids,int rid);

    int removePermissions(int rid);
}
