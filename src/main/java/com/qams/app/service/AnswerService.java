package com.qams.app.service;

import java.util.List;

import com.qams.app.bean.Answer;

public interface AnswerService {
   boolean saveAnswer(Answer answer);

   List<Answer> listAnswer(Integer page, Integer rows,String ctime);

   int countAnswer(String ctime);

   boolean removeAnswer(int aid);
}
