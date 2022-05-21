package com.qams.app;


import org.apache.shiro.crypto.hash.Md5Hash;

public class Test {
    public static void Test(String[] args) {
        // public Md5Hash(java.lang.Object source, java.lang.Object salt, int hashIterations)
        // Source => 源
        // salt => 规则
        // hashIterations => 次数
        Md5Hash md5Hash = new Md5Hash("1234", "lsyx"+"1234", 1000);
        System.out.println(md5Hash.toString());
    }
}
