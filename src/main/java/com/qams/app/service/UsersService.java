package com.qams.app.service;

import java.util.List;

import com.qams.app.bean.Users;

public interface UsersService {

    Users login(String username);

    List<Users> listUsers(Integer page,Integer rows,String uname);

    int countUsers(String uname);

    boolean saveUsers(Users users);

    boolean removeUsers(List<Integer> uids);

    boolean updateUsers(Users users);

    int changeUserStat(int uid);

    List<Users>  countSexTimes();

}
