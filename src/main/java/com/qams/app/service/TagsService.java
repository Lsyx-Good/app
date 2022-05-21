package com.qams.app.service;

import java.util.List;

import com.qams.app.bean.Tags;

public interface TagsService {
   List<Tags>  listTags(Integer  page, Integer rows, String tname); 

   int countTags(String tname);

   boolean saveTags(Tags tags);

   boolean removeTags(List<Integer>ids);

   boolean updateTags(Tags tags);

   List<Tags> list();
   
   List<Tags> countTimesTags();
}
