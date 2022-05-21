package com.qams.app.service.impl;

import java.util.List;

import com.qams.app.bean.Comment;
import com.qams.app.bean.Users;
import com.qams.app.dao.CommentDao;
import com.qams.app.service.CommentService;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    private CommentDao commentDao;

    @Override
    public boolean saveComment(Comment comment) {
        // TODO Auto-generated method stub
        Users users = (Users) SecurityUtils.getSubject().getSession().getAttribute("users");
        comment.setUid(users.getUid());
        return commentDao.save(comment) > 0;
    }

    @Override
    public int countComment(String ctime) {
        // TODO Auto-generated method stub
        return commentDao.count(ctime);
    }

    @Override
    public List<Comment> listComment(Integer page, Integer rows, String ctime) {
        // TODO Auto-generated method stub
        return commentDao.list((page-1)*rows,rows,ctime);
    }

    @Override
    public boolean removeComment(Integer cid){
        return commentDao.remove(cid) > 0;
    }
}
