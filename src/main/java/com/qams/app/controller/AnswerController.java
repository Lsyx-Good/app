package com.qams.app.controller;

import java.util.HashMap;
import java.util.Map;

import com.qams.app.aop.SystemControllerLog;
import com.qams.app.bean.Answer;
import com.qams.app.service.AnswerService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/answer")
public class AnswerController {
    @Autowired
    private AnswerService answerService;

    @SystemControllerLog(description="添加问题回复")
    @RequestMapping("/saveAnswer")
    public boolean saveAnswer(Answer answer, Integer qid){
        // answer.setQid(qid);
        return answerService.saveAnswer(answer);
    }
    
    @SystemControllerLog(description="删除问题回复")
    @RequestMapping("/removeAnswer")
    public boolean removeAnswer(Integer aid) {
        return answerService.removeAnswer(aid);
    }
    
    @SystemControllerLog(description="分页查询问题回复")
    @RequestMapping("/listAnswer")
    public Map<String,Object> listAnswer(Integer page,Integer rows,String ctime) {
        Map<String,Object> map = new HashMap<>();
        map.put("total", answerService.countAnswer(ctime));
        map.put("rows", answerService.listAnswer(page, rows, ctime));
        return map;
    }
}
