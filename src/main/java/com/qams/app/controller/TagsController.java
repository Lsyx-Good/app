package com.qams.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.qams.app.aop.SystemControllerLog;
import com.qams.app.bean.Tags;
import com.qams.app.service.TagsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/tags")
public class TagsController {
    
    @Autowired
    private TagsService tagsService;

    //分页查询
    @SystemControllerLog(description="分页查询标签")
    @RequestMapping("/listTags")
    public Map<String, Object> listTags(Integer  page, Integer rows,String tname) {
        Map<String,Object> map = new HashMap<>();
        map.put("total",tagsService.countTags(tname));
        map.put("rows",tagsService.listTags(page,rows,tname));
        return map;
    }

    //添加标签
    @SystemControllerLog(description="添加标签")
    @RequestMapping("/saveTags")
    public boolean saveTags(Tags tags) {
        return tagsService.saveTags(tags);
    }

    //删除
    @SystemControllerLog(description="删除标签")
    @RequestMapping("/removeTags")
    public boolean removeTags(@RequestParam("ids[]")List<Integer> ids) {
        return tagsService.removeTags(ids);
    }

    // 修改
    @SystemControllerLog(description="修改标签")
    @RequestMapping("/updateTags")
    public boolean updateTags(Tags tags) {
        return tagsService.updateTags(tags);
    }

    //查询所有标签
    @SystemControllerLog(description="查询所有标签")
    @RequestMapping("/list")
    public List<Tags> list() {
        return tagsService.list();
    }

    
    @RequestMapping("/countTimesTags")
    public List<Tags> countTimesTags(){
        return tagsService.countTimesTags();
    }

}
