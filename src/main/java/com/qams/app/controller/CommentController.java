package com.qams.app.controller;

import java.util.HashMap;
import java.util.Map;

import com.qams.app.aop.SystemControllerLog;
import com.qams.app.bean.Comment;
import com.qams.app.service.CommentService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;

    @SystemControllerLog(description="保存评论")
    @RequestMapping("/saveComment")
    public boolean saveComment(Comment comment) {
        return commentService.saveComment(comment);
    }
    
    @SystemControllerLog(description="分页查询评论")
    @RequestMapping("/listComment")
    public Map<String,Object>  listComment(Integer page,Integer rows,String ctime){
        Map<String,Object> map = new HashMap<>();
        map.put("total", commentService.countComment(ctime));
        map.put("rows", commentService.listComment(page,rows,ctime));
        return map;
    }
    
    @SystemControllerLog(description="删除评论")
    @RequestMapping("/removeComment")
    public boolean removeComment(Integer cid){
        return commentService.removeComment(cid);
    }
}
