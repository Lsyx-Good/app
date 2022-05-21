package com.qams.app.dao;

import java.util.List;

import com.qams.app.bean.Question;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface QuestionDao {
    
    List<Question> list(@Param("page")Integer page, @Param("rows")Integer rows,@Param("title")String title,@Param("uname")String uname);

    int count(@Param("title")String title,@Param("uname")String uname);

    int save(Question question);

    int remove(List<Integer> ids);

    int update(Question question);

    List<Question> countHotTitle();
    
}