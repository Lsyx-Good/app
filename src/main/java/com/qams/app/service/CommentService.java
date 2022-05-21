package com.qams.app.service;

import java.util.List;

import com.qams.app.bean.Comment;

public interface CommentService {
   boolean saveComment(Comment comment);

   int countComment(String ctime);

   List<Comment> listComment(Integer page,Integer rows,String ctime);

   boolean removeComment(Integer cid);

}
