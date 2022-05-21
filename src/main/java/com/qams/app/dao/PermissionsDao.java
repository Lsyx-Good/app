package com.qams.app.dao;

import java.util.List;

import com.qams.app.bean.Permissions;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface PermissionsDao {

    List<Permissions> list();

    int save(@Param("pid")Integer pid,@Param("rid")int rid);

    int remove(@Param("rid")int rid);

}
