package com.qams.app.bean;

import java.io.Serializable;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Users implements Serializable{
    private Integer uid;
    private String uname;
    private String nickname;
    private String password;
    private String sex;
    private String total;
    private String avatar;
    private String remark;
    private String ctime;
    private String mtime;
    private Integer del;
    private Integer stat;
    private List<Roles> list;
    private List<Permissions> pList;
    
}
