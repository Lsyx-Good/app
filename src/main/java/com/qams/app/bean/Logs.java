package com.qams.app.bean;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Logs implements Serializable { 
    private Integer operid;
    private String opertime;
    private String opername;
    private String ip;
    private String methods;
    private String ddesc;
    private Integer total;
}
