package com.qams.app.dao;

import java.util.List;

import com.qams.app.bean.Answer;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface AnswerDao {
   
   int save(Answer answer);

   List<Answer> list(@Param("page")Integer page,
   @Param("rows")Integer rows,
   @Param("ctime")String ctime,
   @Param("uid")int uid);
   
   int count(@Param("ctime")String ctime,@Param("uid")int uid);

   int remove(@Param("aid")int aid);
}
