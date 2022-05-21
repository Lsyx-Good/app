package com.qams.app.service.impl;



import java.util.List;

import com.qams.app.bean.Tags;
import com.qams.app.dao.TagsDao;
import com.qams.app.service.TagsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TagsServiceImpl implements  TagsService {

    @Autowired
    private TagsDao tagsDao;

    @Override
    public List<Tags> listTags(Integer  page, Integer rows,String tname) {
        
        return tagsDao.listPage((page-1)*rows,rows,tname);
    } 
    @Override
    public int countTags(String tname) {
        return tagsDao.count(tname);
    }

    @Override
    public boolean saveTags(Tags tags) {
        return tagsDao.save(tags) > 0;
    }

    @Override
    public boolean removeTags(List<Integer> ids) {
        return tagsDao.remove(ids) > 0 ;
    }

    @Override
    public boolean updateTags(Tags tags){
        return tagsDao.update(tags) > 0;
    }
    
    @Override
    public List<Tags> list() {
        return tagsDao.list();
    }

    @Override
    public List<Tags> countTimesTags(){
        return tagsDao.countTimesTags();
    }

}
    

