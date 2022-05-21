<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>回复页面</title>
    <link rel="stylesheet" type="text/css" href="/jeasyui/themes/bootstrap/easyui.css" />
    <link rel="stylesheet" type="text/css" href="/jeasyui/themes/icon.css" />
    <script type="text/javascript" src="/jeasyui/jquery.min.js"></script>
    <script type="text/javascript" src="/jeasyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/jeasyui/easyui-lang-zh_CN.js"></script>
    <script>
        $(function(){
            $("#btn-remove").click(function(){
                let answer =  $("#dg").datagrid('getSelected');
                if (answer == null) {
                    $.messager.alert('我的消息','请选择要删除的评论','error');
                } else {
                    $.post('/answer/removeAnswer',{"aid":answer.aid},function(flag) {
                        if(flag){
                            $("#dg").datagrid('reload');                                                                       
                            $.messager.show({
                                title:'我的消息',
                                msg:'评论删除成功',
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
                    url: '/answer/listAnswer', //请求服务端url地址
                    fitColumns: true, //单元格自适应表格数据，防止出现滚动条
                    fit: true, //表格自身适应父容器
                    nowrap: false, //单元格数据显示换行
                    singleSelect:true,
                    pagination:true, //在底部显示分页工具栏
                    pagePosition:"both",
                    toolbar:'#tb',
                    columns: [[ //表头二维数组
                    { field: 'aid', checkbox:true, width:80 },                
                    { field: 'content', title: '回复内容', width:80 },
                    { field: 'uname', title: '回复人', width:80},
                    { field: 'title', title: '提问问题', width:80 },
                    { field: 'ctime', title: '回复时间', width:80 },
                    { field: 'xxx', title: '评论', width:80, formatter: function(val, rows,index){
                            return '<button onclick="comment('+rows.aid+')">评论</button>';
                        } 
                    }
                ]]
            })

        })
        function comment(aid) {
            $("#comment-dialog").dialog({
                closed:false,
                buttons:[{
                    text:'评论',
                    handler:function(){
                        $("#comment-form").form('submit',{
                            url:'/comment/saveComment?aid='+aid,
                            onsubmit:function(){
                                return $("#comment-form").form('validate');
                            },
                            success: function(flag) {
                                if(flag){
                                    $.messager.show({
                                        title:'我的消息',
                                        msg:'成功回复',
                                        timeout:500,
                                        showType:'slide'
                                    });
                                    $("#comment-dialog").dialog({
                                        closed:true
                                    })
                                }
                            }
                        })
                    }
                }]
            })
        }
    </script>
</head>
<body>
    <table id="dg"></table>  
    <div id="tb">
        <table>
            <tr>
                <td>
                    <input id="ctime" placeholder="请输入回复时间查询" editable="false" class="easyui-datebox">
                    <a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a>
                </td>
            </tr>
        </table>
        <a href="#" id="btn-remove" class="easyui-linkbutton" plain="true" iconCls="icon-remove">删除评论</a>
    </div>
    <%-- //添加对话框 --%>
    <div id="comment-dialog" class="easyui-dialog" title="请输入要评论的信息" closed="true" modal="true"
    style="width:400px;height:200px;">
        <form id="comment-form" method="post">
            <textarea name="content" cols="60" rows="30"></textarea>
        </form>
    </div>
</body>
</html>