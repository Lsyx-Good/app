package com.qams.app.service.impl;

import java.util.List;

import com.qams.app.bean.Answer;
import com.qams.app.bean.Users;
import com.qams.app.dao.AnswerDao;
import com.qams.app.service.AnswerService;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class AnswerServiceImpl implements AnswerService {
    @Autowired
    private AnswerDao answerDao;

    @Override
    public boolean saveAnswer(Answer answer) {
        // TODO Auto-generated method stub
        Users users =  (Users)SecurityUtils.getSubject().getSession().getAttribute("users");
        answer.setUid(users.getUid());
        return answerDao.save(answer) > 0;
    }

    @Override
    public List<Answer> listAnswer(Integer page, Integer rows, String ctime) {
        // TODO Auto-generated method stub
        Users users = (Users)SecurityUtils.getSubject().getSession().getAttribute("users");
        return answerDao.list((page-1) * rows, rows, ctime, users.getUid());
    }

    @Override
    public int countAnswer(String ctime) {
        // TODO Auto-generated method stub
        Users users = (Users)SecurityUtils.getSubject().getSession().getAttribute("users");
        return answerDao.count(ctime, users.getUid());
    }

    @Override
    public boolean removeAnswer(int aid) {
        // TODO Auto-generated method stub
        return answerDao.remove(aid) > 0;
    }
}
