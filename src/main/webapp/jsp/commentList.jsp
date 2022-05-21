<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>评论页面</title>
    <link rel="stylesheet" type="text/css" href="/jeasyui/themes/bootstrap/easyui.css" />
    <link rel="stylesheet" type="text/css" href="/jeasyui/themes/icon.css" />
    <script type="text/javascript" src="/jeasyui/jquery.min.js"></script>
    <script type="text/javascript" src="/jeasyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/jeasyui/easyui-lang-zh_CN.js"></script>
    <script>
        $(function () {
            //删除
            $("#btn-remove").click(function(){
                let comment = $("#dg").datagrid('getSelected');
                if(comment==null){
                    $.messager.alert('我的消息','请选择要删除的评论','error');
                }else {
                    $.post('/comment/removeComment',{"cid":comment.cid},function(flag){
                        if(flag){
                            $("#dg").datagrid('reload');
                            $.messager.show({
                                title:'我的消息',
                                msg:'删除评论成功',
                                timeout:500,
                                showType:'slide'
                            });
                        }
                    })
                }
            })

            $("#btn-search").click(function(){
                $("#dg").datagrid('reload',{
                    ctime:$("#ctime").val()
                })
            })

            $("#dg").datagrid({
                url: '/comment/listComment', //请求服务端url地址
                fitColumns: true, //单元格自适应表格数据，防止出现滚动条
                fit: true, //表格自身适应父容器
                nowrap: false, //单元格数据显示换行
                singleSelect:true,
                pagination:true, //在底部显示分页工具栏
                pagePosition:"both",
                toolbar:'#tb',
                columns: [[ //表头二维数组
                    { field: 'content', title: '评论内容', width:80 },
                    { field: 'uname', title: '评论人', width:80},
                    { field: 'ctime', title: '评论时间', width:80 },
                    { field: 'reply', title: '回复标题', width:80 },
                ]]
            })
        })
    </script>
</head>
<body>
    <table id="dg"></table>
    <div id="tb">
        <table>
            <tr>
                <td>
                    <input id="ctime" placeholder="请输入评论时间查询" editable="false" class="easyui-datebox">
                    <a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a>
                </td>
            </tr>
        </table>
        <a href="#" id="btn-remove" class="easyui-linkbutton" plain="true" iconCls="icon-remove">
            删除评论
        </a>
    </div>
</body>
</html>