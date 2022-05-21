package com.qams.app.service;

import java.util.List;

import com.qams.app.bean.Question;

public interface QuestionService {
    
    List<Question> listQuestion(Integer page, Integer rows,String title);

    int countQuestion(String title);
    
    boolean saveQuestion(Question question);

    boolean removeQuestion(List<Integer> ids);

    boolean updateQuestion(Question question);

    List<Question> countHotTitle();
}
