package com.qams.app.bean;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Tags implements Serializable {
    private Integer tid;
    private String tname;
    private String ctime;
    private String mtime;
    private String name;
    private String value;

}
