package com.qams.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.qams.app.aop.SystemControllerLog;
import com.qams.app.bean.Question;
import com.qams.app.service.QuestionService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/question")
public class QuestionController {
    @Autowired
    private QuestionService questionService;

    //查询
    @SystemControllerLog(description="分页查询提问问题")
    @RequestMapping("/listQuestion")
    public Map<String, Object> listQuestion(Integer page, Integer rows,String title) {
        Map<String, Object> map = new HashMap<>();
        map.put("total", questionService.countQuestion(title));
        map.put("rows", questionService.listQuestion(page,rows,title));
        return map;
    }

    //添加
    @SystemControllerLog(description="添加问题")
    @RequestMapping("/saveQuestion")
    public boolean saveQuestion(Question question){
        return questionService.saveQuestion(question);
    }

    //
    @SystemControllerLog(description="删除评论问题")
    @RequestMapping("/removeQuestion")
    public boolean removeQuestion(@RequestParam("ids[]")List<Integer>ids){
        return questionService.removeQuestion(ids);
    }

    //修改
    @RequestMapping("/updateQuestion")
    public boolean updateQuestion(Question question) {
        return questionService.updateQuestion(question);
    }

    @RequestMapping("/countHotTitle")
    public List<Question> countHotTitle(){
        return questionService.countHotTitle();
    }


}
