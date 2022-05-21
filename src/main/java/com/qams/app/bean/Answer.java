package com.qams.app.bean;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Answer implements Serializable {
    private Integer aid;
    private Integer cid;
    private Integer uid;
    private String uname;
    private String content;
    private Integer commentNum;
    private String agreeNum;
    private String ctime;
    private String mtime;
    private Integer del;
    private Integer qid;
    private String title;
}
