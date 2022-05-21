package com.qams.app.bean;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Comment implements Serializable {
    private static final long serialVersionUID = 225507071339448988L;
    private Integer cid;
    private Integer uid;
    private String uname;
    private String content;
    private String reply; //回复的内容
    private String ctime;
    private String mtime;
    private Integer del;
    private Integer aid;
}
