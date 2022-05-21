package com.qams.app.dao;

import java.util.List;

import com.qams.app.bean.Roles;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface RolesDao {
    
    List<Roles> list();

    List<Roles> listPage(@Param("page")int page, @Param("rows")int rows);

    int save(@Param("rid")Integer rid,@Param("uid")Integer uid);
    
    int count();

    Roles get(int rid);
}
