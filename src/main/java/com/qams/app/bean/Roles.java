package com.qams.app.bean;

import java.io.Serializable;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Roles implements Serializable{
    private Integer rid;
    private String rname;
    private String rdesc;
    private List<Permissions> permissionsList;
    
}
