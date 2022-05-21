<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录</title>
    <link rel="stylesheet" type="text/css" href="/jeasyui/themes/bootstrap/easyui.css">
	<link rel="stylesheet" type="text/css" href="/jeasyui/themes/icon.css">

	<script type="text/javascript" src="/jeasyui/jquery.min.js"></script>
	<script type="text/javascript" src="/jeasyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/jeasyui/easyui-lang-zh_CN.js"></script>
    <script>
        $(function(){
            $("#login-dialog").dialog({
                buttons:[{
                    text:'登录',
                    iconCls:'icon-man',
                    handler: function(){
                        $("#login-form").form('submit',{
                            url:'users/login',
                            onSubmit: function(){
                                return $("#login-form").form('validate');
                            },
                            success: function (flag) {
                                if(flag == 1) {                                   
                                    window.location.href="index.jsp";
                                } else if (flag == 0){
                                    $.messager.alert('消息','你输入用户名称或密码不正确,'+
                                    '或帐号被锁定,请联系管理员','error');
                                }
                            }
                        })
                    } 
                }]  
            })
        })
    </script>
</head>
<body>
   <div id="login-dialog" class="easyui-dialog" title="登录" style="width:280px;height:200px;" modal="true">
    <form method="post" id="login-form">
        <table>
        <tr>
            <td>
                <input name="username" id="uname" class="easyui-textbox" iconCls="icon-man" required="true">
            </td>
        </tr>
        <tr>
            <td>
                <input name="password" id="password" class="easyui-passwordbox" iconCls="icon-lock" required="true">
            </td>
        </tr>
    </table>
    </form>
</div> 
</body>
</html>