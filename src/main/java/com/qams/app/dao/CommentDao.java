package com.qams.app.dao;

import java.util.List;

import com.qams.app.bean.Comment;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentDao {
   int save(Comment comment);

   int count(@Param("ctime")String ctime);

   List<Comment> list(@Param("page")Integer page, @Param("rows")Integer rows, @Param("ctime")String ctime);

   int remove(@Param("cid")int cid);
}
