package com.qams.app.dao;

import java.util.List;

import com.qams.app.bean.Users;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UsersDao {
   
   Users login(@Param("username")String username);

   List<Users> list(@Param("page")Integer page,@Param("rows")Integer rows, @Param("uname")String uname);

   int count(@Param("uname")String uname);

   int save(Users users);

   int remove(List<Integer> uids);

   int update(Users users);

   Users get(int uid);

   List<Users>  countSexTimes();
   
}
