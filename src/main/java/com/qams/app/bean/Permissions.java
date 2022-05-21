package com.qams.app.bean;

import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Permissions implements Serializable{
    private Integer pid;
    private String pname;
    private String pdesc;
}
