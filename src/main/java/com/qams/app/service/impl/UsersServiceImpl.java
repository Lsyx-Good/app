package com.qams.app.service.impl;

import java.util.List;

import com.qams.app.bean.Users;
import com.qams.app.dao.UsersDao;
import com.qams.app.service.UsersService;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class UsersServiceImpl implements UsersService {
    @Autowired
    private UsersDao usersDao;

    @Override
    public Users login(String username) {
        // TODO Auto-generated method stub
        return usersDao.login(username);
    }

    @Override
    public List<Users> listUsers(Integer page,Integer rows,String uname){
        Users users = (Users)SecurityUtils.getSubject().getSession().getAttribute("users");
        if(users.getList().get(0).getRname().equals("0")){
            return usersDao.list((page-1)*rows,rows,null);

        }else {
            return usersDao.list((page-1)*rows,rows,users.getUname());
        }
    }

    @Override
    public int countUsers(String uname){
        Users users = (Users)SecurityUtils.getSubject().getSession().getAttribute("users");
        return usersDao.count(users.getUname());
    }

    public boolean saveUsers(Users users){
        users.setPassword(new Md5Hash(users.getPassword(),
            users.getUname()+users.getPassword(),
            1000).toString());
        return usersDao.save(users) > 0;
    }

    public boolean removeUsers(List<Integer> uids){
        return usersDao.remove(uids) > 0;

    }

    public boolean updateUsers(Users users){
        users.setPassword(new Md5Hash(users.getPassword(),
            users.getUname()+users.getPassword(),
            1000).toString());
        return usersDao.update(users) > 0;
    }

    @Override
    public int changeUserStat(int uid) {
        // TODO Auto-generated method stub
        Users users = usersDao.get(uid);
        if (users.getList().size() == 0){
            return -1;
        }else if(users.getList().get(0).getRname().equals("0")){
            return -1;
        }else {
            if (users.getStat() == null) {
                return -1;
            }else if (users.getStat() == 0){
                users.setStat(1);
            }else if(users.getStat() == 1) {
                users.setStat(0);
            }
            return usersDao.update(users);
        }
    }

    @Override
    public List<Users>  countSexTimes(){
        return usersDao.countSexTimes();
    }


}
