package com.qams.app.dao;

import java.util.List;

import com.qams.app.bean.Logs;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface LogsDao {
    
    int save(Logs logs);

    List<Logs> list(@Param("page")Integer page,@Param("rows")Integer rows,@Param("opername")String opername);

    int count(@Param("opername")String opername);

    List<Logs> countTimes();
}
