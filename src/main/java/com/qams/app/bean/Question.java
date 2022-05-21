package com.qams.app.bean;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Question implements Serializable {
    
    private Integer qid;
    private Integer uid;
    private Integer tid;
    private String tname; //查询显示标签名称
    private String uname; //显示用户名称
    private Integer aid;
    private String content;
    private String title;
    private String name;
    private String value;
    private String ctime;
    private String mtime;
    private Integer del;
}
