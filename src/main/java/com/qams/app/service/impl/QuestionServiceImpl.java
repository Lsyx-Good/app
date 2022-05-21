package com.qams.app.service.impl;

import java.util.List;

import com.qams.app.bean.Question;
import com.qams.app.bean.Users;
import com.qams.app.dao.QuestionDao;
import com.qams.app.service.QuestionService;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service    
public class QuestionServiceImpl implements QuestionService {
    @Autowired
    private QuestionDao questionDao;

    @Override
    public List<Question> listQuestion(Integer page, Integer rows,String title) {
        Users users = (Users)SecurityUtils.getSubject().getSession().getAttribute("users");
        return questionDao.list((page-1)*rows,rows,title,users.getUname());
    }
    
    @Override
    public int countQuestion(String title) {
        Users users = (Users)SecurityUtils.getSubject().getSession().getAttribute("users");
        return questionDao.count(title,users.getUname());
    }

    @Override
    public boolean saveQuestion(Question question){
        Users users = (Users)SecurityUtils.getSubject().getSession().getAttribute("users");
        question.setUid(users.getUid());
        return questionDao.save(question) > 0;
    }

    @Override
    public boolean removeQuestion(List<Integer> ids) {
        return questionDao.remove(ids) > 0 ;
    }

    @Override
    public boolean updateQuestion(Question question) {
        // TODO Auto-generated method stub
        return questionDao.update(question) > 0;
    }

    @Override
    public List<Question> countHotTitle(){
        return questionDao.countHotTitle();
    }
}
