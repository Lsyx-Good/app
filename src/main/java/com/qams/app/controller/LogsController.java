package com.qams.app.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.qams.app.bean.Logs;
import com.qams.app.service.LogsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/logs")
public class LogsController {
    @Autowired
    private LogsService logsService;

    @RequestMapping("/listLogs")
    public Map<String, Object> listLogs(Integer page,Integer rows, String opername){
        Map<String,Object> map = new HashMap<>();
        map.put("total",logsService.countLogs(opername));
        map.put("rows",logsService.listLogs(page,rows,opername));
        return map;
    }

    //统计访问次数
    @RequestMapping("/countTimes")
    public Map<String,Object> countTimes(){
        Map<String,Object> map = new HashMap<>();

        List<String> names = new ArrayList<>();
        List<Integer> times = new  ArrayList<>();

        List<Logs> logs = logsService.countTimes();
        for(Logs log : logs){
            names.add(log.getOpername());
            times.add(log.getTotal());
        }

        map.put("names",names);
        map.put("times",times);

        return map;
    }
}
