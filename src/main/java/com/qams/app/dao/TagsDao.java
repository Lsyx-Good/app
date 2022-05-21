package com.qams.app.dao;

import java.util.List;

import com.qams.app.bean.Tags;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface TagsDao {
   List<Tags>  listPage(@Param("page")Integer  page, @Param("size")Integer size, @Param("tname")String tname);

   int count(@Param("tname")String tname);

   int save(Tags tags);

   int remove(List<Integer>ids);

   int update(Tags tags);

   List<Tags> list();

   List<Tags> countTimesTags();

}
 