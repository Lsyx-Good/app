<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>角色页面</title>
    <link rel="stylesheet" type="text/css" href="/jeasyui/themes/bootstrap/easyui.css" />
    <link rel="stylesheet" type="text/css" href="/jeasyui/themes/icon.css" />
    <script type="text/javascript" src="/jeasyui/jquery.min.js"></script>
    <script type="text/javascript" src="/jeasyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/jeasyui/easyui-lang-zh_CN.js"></script>
    <script>
        $(function(){

            $("#btn-add-permissions").click(function(){
                let array = $("#dg").datagrid('getSelections');
                if (array.length == 0) {
                    $.messager.alert('我的消息','请选择要分配权限的角色信息','error');
                }else if (array.length > 1){
                    $.messager.alert('我的消息','只能选择一条记录进行权限信息修改','error');
                    $("#dg").datagrid('unselectAll');
                }else {
                    $("#add-permissions-dialog").dialog({
                        closed:false,
                        buttons:[{
                            text:'保存',
                            iconCls:'icon-save',
                            handler:function(){
                                $("#add-permissions-form").form('submit',{
                                    url:'/permissions/savePermissions?rid=' + array[0].rid,
                                    onSubmit: function(){
                                        return $("#add-permissions-form").form('validate');
                                    },
                                    success: function(flag){
                                        if(flag == -1) {
                                            $.messager.alert('我的消息','该用户已经分配权限,不能再次分配','error');                                                                       
                                        } else if (flag == 1){
                                            $.messager.alert('我的消息','分配权限成功','info');                           
                                            $("#add-permissions-dialog").dialog({closed:true})
                                        }
                                    }
                                })
                            }
                        }]
                    })
                }
            })

            $("#btn-remove-permissions").click(function(){
                let array =  $("#dg").datagrid('getSelections');
                if (array.length == 0) {
                    $.messager.alert('我的消息','请选择要删除权限的角色','error');
                }else{
                    $.post('/permissions/removePermission',{'rid':array[0].rid},function(flag){
                        if(flag == -1){
                            $.messager.alert('我的消息','该角色没有分配权限','error');
                            
                        }else if(flag == 1){
                            
                            $.messager.alert('我的消息','删除权限成功','info');
                        }
                    })
                }
            })

            $("#dg").datagrid({
                url: '/roles/listPageRoles', //请求服务端url地址
                fitColumns: true, //单元格自适应表格数据，防止出现滚动条
                fit: true, //表格自身适应父容器
                nowrap: false, //单元格数据显示换行
                singleSelect:true,
                pagination:true, //在底部显示分页工具栏
                pagePosition:"both",
                toolbar:'#tb',
                columns: [[ //表头二维数组
                    { field: 'rid', checkbox:true, width:80 },                
                    { field: 'rdesc', title: '角色名称', width:80 },
                    { field: 'rname', title: '角色标记', width:80,formatter:function(val,rows,index){
                        if(val == 0){
                            return '0表示的是管理员';
                        } else if (val == 1) {
                            return '1表示的是普通用户';
                        }
                    }},
                    { field: 'ctime', title: '评论时间', width:80 },
                    { field: 'reply', title: '回复标题', width:80 },
                ]]
            })
        })
    </script>
</head>
<body>
   <table id="dg"></table>
   <div id="tb" >
       <a href="#" id="btn-add-permissions" class="easyui-linkbutton"  plain="true" iconCls="icon-lock">分配权限</a>
       <a href="#" id="btn-remove-permissions" class="easyui-linkbutton"  plain="true" iconCls="icon-remove">删除权限</a>
   </div>

   <div id="add-permissions-dialog" class="easyui-dialog" title="添加角色" mode="true" closed="true" style="width: auto;height: auto;">
    <form method="post" id="add-permissions-form">
        <table>
            <tr>
                <td>分配权限</td>
                <td>
                    <input  name="pid" class="easyui-combobox" required="true" multiple="true" data-options="valueField:'pid',textField:'pdesc',url:'/permissions/listPermissions'">
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>