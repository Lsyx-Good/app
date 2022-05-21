<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户页面</title>
    <link rel="stylesheet" type="text/css" href="/jeasyui/themes/bootstrap/easyui.css" />
    <link rel="stylesheet" type="text/css" href="/jeasyui/themes/icon.css" />
    <script type="text/javascript" src="/jeasyui/jquery.min.js"></script>
    <script type="text/javascript" src="/jeasyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/jeasyui/easyui-lang-zh_CN.js"></script>
    <script>
        $(function(){
            $("#btn-edit").click(function(){
                let array = $("#dg").datagrid('getSelections');
                if (array.length == 0) {
                    $.messager.alert('我的消息','请选择要修改的用户','error');
                } else if (array.length > 1){
                    $.messager.alert('我的消息','只能选择一个用户进行修改','error');
                    $("#dg").datagrid('unselectAll')
                }else {
                    //填充修改表单
                    
                    $("#edit-form").form('load',{
                        uid:array[0].uid,
                        uname:array[0].uname,
                        sex:array[0].sex,
                        nickname:array[0].nickname,
                        password:array[0].password,
                        avatar:array[0].avatar,
                        remark:array[0].remark,
                        
                    })
                    //弹出修改对话框
                    $("#edit-dialog").dialog({
                        closed:false,
                        buttons:[{
                            text:'保存',
                            iconCls:'icon-save',
                            handler:function(){
                                $("#edit-form").form('submit',{
                                    url:'/users/updateUsers',
                                    
                                    onSubmit: function(param){
                                        param.stat = array[0].stat;
                                        return $("#edit-form").form('validate');
                                    },
                                    success:function(flag){
                                        if(flag) {
                                            $("#dg").datagrid('reload');
                                            $("#edit-dialog").dialog({closed:true});
                                            $("#edit-form").form('clear');
                                        }
                                    }
                                })
                            }
                        },{
                            text:'重置',
                            iconCls:'icon-redo',
                            handler:function()  {
                                // 重置表单
                                $("edit-form").form('clear');
                            }
                        }]
                    })
                }
            })

            $("#btn-remove").click(function(){
                let array= $("#dg").datagrid('getSelections');
                if (array.length == 0) {
                   $.messager.alert('请选择要删除的数据');
                }else {
                    let uids = [];
                    for(let i in array){
                        uids.push(array[i].uid);
                    }
                    $.post('/users/removeUsers',{"uids[]":uids},function(flag){
                        if(flag){
                            $("#dg").datagrid('reload');
                            $.messager.show({
                                title:'我的消息',
                                msg:'删除用户成功',
                                timeout:500,
                                showType:'slide'
                            })
                        }
                    })
                }
            })

            $("#btn-add").click(function(){
                $("#add-dialog").dialog({
                    closed:false,
                    buttons:[{
                        text:'保存',
                        iconCls:'icon-save',
                        handler: function(){
                            $("#add-form").form('submit',{
                                url:'/users/saveUsers',
                                onSubmit:function(){
                                    return $("#add-form").form('validate');
                                },
                                success: function(flag){
                                    if(flag) {
                                        $("#add-form").form('clear');
                                        $("#add-dialog").dialog({closed:true});
                                        $("#dg").datagrid('reload');
                                        $.messager.show({
                                            title:'我的消息',
                                            msg:'添加成功',
                                            timeout:500,
                                            showType:'slide'
                                        })
                                    }
                                }
                            })
                        }
                    }]
                })
            })
            $("#btn-stat").click(function(){
                let array = $("#dg").datagrid('getSelections');
                if (array.length == 0) {
                    $.messager.alert('我的消息','请选择要更改的用户信息','error');
                }else if (array.length > 1) {
                    $.messager.alert('我的消息','只能选择一条信息进行更改','error');
                }else {
                    $.post('/users/changeUserStat',{uid:array[0].uid},function(flag){
                        if(flag){
                            $("#dg").datagrid('reload');
                            $.messager.show({
                                title:'我的消息',
                                msg:'成功更改用户状态',
                                timeout:500,
                                showType:'slide'
                            });
                        }else {
                            $.messager.alert('我的消息','该用户是管理员,不能进行状态更改,或者该角色未分配角色,或者该角色是未启用状态!','error')
                        }
                    })
                }
            })

            $("#btn-role").click(function(){
                let array = $("#dg").datagrid('getSelections');
                if(array.length == 0) {
                    $.messager.alert('我的消息','请选择要分配的用户角色信息','error');
                }else if (array.length > 1){
                    $.messager.alert('我的消息','只能选择一条记录分配角色信息','error');
                    $("#dg").datagrid('unselectAll');
                }else {
                    $("#add-role-dialog").dialog({
                        closed:false,
                        buttons:[{
                            text:'保存',
                            iconCls:'icon-save',
                            handler:function(){
                                $("#add-role-form").form('submit',{
                                    url:'/roles/saveRoles?uid=' + array[0].uid,
                                    onSubmit: function(){
                                        return $("#add-role-form").form('validate');
                                    },
                                    success: function(flag){
                                        if(flag == -1) {
                                            $.messager.alert('我的消息','该用户已经分配角色不能再次分配!','error');
                                        } else if (flag == 1){
                                            $.messager.alert('我的消息','分配角色成功','info');                           
                                            $("#add-role-dialog").dialog({closed:true})
                                        }
                                    }
                                })
                            }
                        }]
                    })
                }
            })

            $("#dg").datagrid({
                url: '/users/listUsers', //请求服务端url地址
                fitColumns: true, //单元格自适应表格数据，防止出现滚动条
                fit: true, //表格自身适应父容器
                nowrap: false, //单元格数据显示换行
                pagination:true, //在底部显示分页工具栏
                pagePosition:"both",
                toolbar:'#tb',
                columns: [[ //表头二维数组
                { field: 'uid', checkbox:true },
                { field: 'uname', title: '用户名称', width:80},
                { field: 'password', title: '密码', width:80 },
                { field: 'nickname', title: '昵称', width:80 },
                { field: 'sex', title: '性别', width:80 },
                { field: 'avatar', title: '头像', width:80, formatter:function(val,rows,index){
                    return '<img src=" ' + val + ' " style="width: 50px; height: 50px;">';
                }},
                { field: 'ctime', title: '创建时间', width:80 },
                { field: 'mtime', title: '修改时间', width:80 },
                { field: 'remark', title: '备注', width:80 },
                { field: 'stat', title: '用户状态', width:80,formatter:function(val,rows,index){
                    if(val==0){
                        return '<div style="color:green"><h4>启用</h4></div>';
                    } else if(val ==1) {
                        return '<div style="color:red"><h4>禁用</h4></div>';

                    }else {
                        return '<div style="color:yellowgreen"><h4>未知</h4></div>';
                    }
                } },
                ]]
            })
        })
    </script>
</head>
<body>
    <table id="dg"></table>
    
    <div id="tb">
        <shiro:hasPermission name="S1">
        <a href="#" id="btn-add" class="easyui-linkbutton" plain="true" iconCls="icon-add">添加用户</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="S2">
            <a href="#" id="btn-edit" class="easyui-linkbutton" plain="true" iconCls="icon-edit">修改用户</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="S3">
            <a href="#" id="btn-remove" class="easyui-linkbutton" plain="true" iconCls="icon-remove">删除用户</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="S5">
            <a href="#" id="btn-stat" class="easyui-linkbutton" plain="true" iconCls="icon-lock">更改状态</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="S4">
            <a href="#" id="btn-role" class="easyui-linkbutton" plain="true" iconCls="icon-man">分配角色</a>
        </shiro:hasPermission>
    </div>
    
    <%--添加对话框--%>
    <div id="add-dialog" class="easyui-dialog" title="添加用户信息" closed="true" modal="true"
    style="width:auto;height:auto;">
        <form id="add-form" method="post">
            <table>
                <tr>
                    <td>用户名称</td>
                    <td><input name="uname" class="easyui-validatebox" required="true"></td>
                    <td>用户密码</td>
                    <td><input name="password" class="easyui-validatebox" required="true"></td>
                </tr>
                <tr>
                    <td>用户昵称</td>
                    <td><input name="nickname" class="easyui-validatebox" required="true"></td>
                    <td>性别</td>
                    <td><select name="sex" class="easyui-combobox" required="true" id="" style="width: 150px;">
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select></td>
                </tr>
                <tr>
                    <td>头像</td>
                    <td><input valiType="url" name="avatar" class="easyui-validatebox" required="true"></td>
                    <td>备注</td>
                    <td><input name="remark" class="easyui-validatebox" ></td>
                </tr>
            </table>
        </form>
    </div>
    <%--修改对话框--%>
    <div id="edit-dialog" class="easyui-dialog" title="修改用户信息" closed="true" modal="true"
    style="width:auto;height:auto;">
        <form id="edit-form" method="post">
            <table>
                <tr>
                    <td>用户名称</td>
                    <td><input name="uname" class="easyui-validatebox" required="true">
                    <input type="hidden" name="uid">
                    </td>
                    <td>用户密码</td>
                    <td><input name="password" class="easyui-validatebox" required="true"></td>
                </tr>
                <tr>
                    <td>用户昵称</td>
                    <td><input name="nickname" class="easyui-validatebox" required="true"></td>
                    <td>性别</td>
                    <td><select name="sex" class="easyui-combobox" required="true" id="" style="width: 150px;">
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select></td>
                </tr>
                <tr>
                    <td>头像</td>
                    <td><input valiType="url" name="avatar" class="easyui-validatebox" required="true"></td>
                    <td>备注</td>
                    <td><input name="remark" class="easyui-validatebox" ></td>
                </tr>
            </table>
        </form>
    </div>
    <div id="add-role-dialog" class="easyui-dialog" title="添加角色" mode="true" closed="true" style="width: auto;height: auto;">
        <form method="post" id="add-role-form">
            <table>
                <tr>
                    <td>分配角色</td>
                    <td>
                        <input  name="rid" class="easyui-combobox" required="true" data-options="valueField:'rid',textField:'rdesc',url:'/roles/listRoles'">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
