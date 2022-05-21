package com.qams.app.aop;


import com.qams.app.bean.Logs;
import com.qams.app.bean.Users;
import com.qams.app.service.LogsService;
import org.apache.shiro.SecurityUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;

import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;

@Aspect
@Component
public class SystemLogAspect {
    @Autowired
    private LogsService logsService;

    private static final Logger logger = LoggerFactory.getLogger(SystemLogAspect.class);

    //Controller层切点
    @Pointcut("@annotation(SystemControllerLog)")
    public void controllerAspect(){

    }

    @After("controllerAspect()")
    public void doBefore(JoinPoint joinPoint){
        HttpServletRequest request = ((ServletRequestAttributes)
                RequestContextHolder.getRequestAttributes()).getRequest();
        //获取登录用户信息
        Users users=(Users) SecurityUtils.getSubject().getSession().getAttribute("users");
        try {
            Logs logs = new Logs();
            //操作方法
            logs.setMethods((joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName()));
            //方法描述
            logs.setDdesc(getControllerMethodDescription(joinPoint));
            //获得IP地址
            logs.setIp(request.getRemoteAddr());
            if(users!=null){
                //设置操作人
                logs.setOpername(users.getUname());
            }
            //保存数据库
            boolean flag = logsService.saveLogs(logs);
            System.out.println(flag==true?"记录日志成功":"记录日志失败");
        }catch (Exception e){
            //记录本地异常日志
            logger.error("==前置通知异常==");
            logger.error("异常信息：{}",e.getMessage());
        }
    }


    /**
     * @Description  获取注解中对方法的描述信息 用于Controller层注解
     * @date 2020年11月9日 上午12:01
     */
    public static String getControllerMethodDescription(JoinPoint joinPoint) throws Exception {
        String targetName = joinPoint.getTarget().getClass().getName();
        String methodName = joinPoint.getSignature().getName();//目标方法名
        Object[] arguments = joinPoint.getArgs();
        Class targetClass = Class.forName(targetName);
        Method[] methods = targetClass.getMethods();
        String description = "";
        for (Method method:methods) {
            if (method.getName().equals(methodName)){
                Class[] clazzs = method.getParameterTypes();
                if (clazzs.length==arguments.length){
                    description = method.getAnnotation(SystemControllerLog.class).description();
                    break;
                }
            }
        }
        return description;
    }



}
