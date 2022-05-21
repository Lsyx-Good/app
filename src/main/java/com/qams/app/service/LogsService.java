package com.qams.app.service;

import java.util.List;

import com.qams.app.bean.Logs;

public interface LogsService {

    boolean saveLogs(Logs logs);

    List<Logs> listLogs(Integer page,Integer rows,String opername);

    int countLogs(String opername);
    
    List<Logs> countTimes();
}
