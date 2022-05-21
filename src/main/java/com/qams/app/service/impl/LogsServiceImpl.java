package com.qams.app.service.impl;

import java.util.List;

import com.qams.app.bean.Logs;
import com.qams.app.dao.LogsDao;
import com.qams.app.service.LogsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class LogsServiceImpl implements LogsService{
    @Autowired
    private LogsDao logsDao;

    @Override 
    public boolean saveLogs(Logs logs){
        return logsDao.save(logs) > 0;
    }
    
    @Override 
    public List<Logs> listLogs(Integer page,Integer rows,String opername){
        return logsDao.list((page-1)*rows,rows, opername);
    }

    @Override 
    public  int countLogs(String opername){
        return logsDao.count(opername);
    }

    @Override 
    public List<Logs> countTimes(){
        return logsDao.countTimes();
    }

}
