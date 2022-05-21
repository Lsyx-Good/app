<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>问题页面</title>
    <link rel="stylesheet" type="text/css" href="/jeasyui/themes/bootstrap/easyui.css" />
    <link rel="stylesheet" type="text/css" href="/jeasyui/themes/icon.css" />
    <script type="text/javascript" src="/jeasyui/jquery.min.js"></script>
    <script type="text/javascript" src="/jeasyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/jeasyui/easyui-lang-zh_CN.js"></script>
    <script>
        $(function(){
            $("#btn-edit").click(function(){
                let array = $("#dg").datagrid('getSelections');
                if(array.length == 0) {
                    $.messager.alert('我的消息','请选择要修改的数据','error');
                } else if (array.length > 1) {
                    $.messager.alert('我的消息','只能选择一条记录进行修改','error');
                    $("#dg").datagrid('unselectAll');
                }else {
                    //填充修改表单
                    $("#edit-form").form('load',{
                        title:array[0].title,
                        content:array[0].content,
                        tid:array[0].tid,
                        qid:array[0].qid
                    })
                    //弹出修改对话框
                    $("#edit-dialog").dialog({
                        closed:false,
                        buttons:[{
                            text:'保存',
                            handler: function(){
                                $("#edit-form").form('submit',{
                                    url:'/question/updateQuestion',
                                    onSubmit: function(){
                                        return $("#edit-form").form('validate');
                                    },
                                    success: function(flag) {
                                        if (flag) {
                                            $("#dg").datagrid('reload');
                                            $.messager.show({
                                                title:'我的消息',
                                                msg:'修改数据成功',
                                                timeout:5000,
                                                showType:'slide'
                                            });
                                            $("#edit-dialog").dialog({closed:true});
                                        }
                                    }
                                })
                            }
                        },{
                            text:'重置',
                            handler: function(){
                                $("#edit-form").form('clear');
                            }
                        }]
                    })
                }
            })
            //删除
            $("#btn-remove").click(function(){
                let array = $("#dg").datagrid('getSelections');
                if (array.length == 0)  {
                    $.messager.alert('我的消息','请选择要删除的数据', 'error');
                }else {
                    let ids = [];
                    for (let i in array) {
                        ids.push(array[i].qid);

                    }
                    $.post('/question/removeQuestion',{"ids[]":ids},function (flag) {
                        if (flag) {
                            $.messager.show({
                            title:'我的消息',
                            msg:'删除成功',
                            timeout:5000,
                            showType:'slide'
                        });
                        $("#dg").datagrid('reload');
                        }
                    })
                }
            })
            
            //添加
            $("#btn-add").click(function () {
                $("#add-dialog").dialog({
                    closed:false,
                    buttons:[{
                        text:'保存',
                        iconCls: 'icon-save',
                        handler: function () {
                            $("#add-form").form('submit',{
                                url: '/question/saveQuestion',
                                onSubmit: function(){
                                    return $("#add-form").form('validate')
                                },
                                success: function(flag) {
                                    if (flag) {
                                        $("#dg").datagrid('reload');
                                        $.messager.show({
                                            title:'我的消息',
                                            msg:'添加数据成功',
                                            timeout:5000,
                                            showType:'slide'
                                        });
                                        $("#add-dialog").dialog({
                                            closed:true
                                        })
                                    }
                                }
                            })
                        }
                    }]
                })
            })
            //条件查询
            $("#btn-search").click(function(){
                $("#dg").datagrid('reload',{
                    title:$("#title").val()
                })
            })
            $("#dg").datagrid({
                url: '/question/listQuestion', //请求服务端url地址
                fitColumns: true, //单元格自适应表格数据，防止出现滚动条
                fit: true, //表格自身适应父容器
                nowrap: true, //单元格数据显示换行
                pagination:true, //在底部显示分页工具栏
                pagePosition:"both",
                toolbar:'#tb',
                columns: [[ //表头二维数组
                { field: 'qid', checkbox:true, width:80 },                
                { field: 'title', title: '问题标题', width:80 },
                { field: 'content', title: '问题内容', width:80 },
                { field: 'tname', title: '分类标签', width:80 },
                { field: 'ctime', title: '提问时间', width:80 },
                { field: 'mtime', title: '修改时间', width:80 },
                { field: 'uname', title: '用户名称', width:80},
                { field: 'xxx', title: '回复', width:80, formatter:function(val, row, index){
                    return '<button onclick="answer('+row.qid+')">回复</button>';
                }},
                ]]
            })
        })
        function answer(qid) {
            $("#answer-dialog").dialog({
                closed:false,
                buttons:[{
                    text:'回复',
                    handler:function(){
                        $("#answer-form").form('submit',{
                            url:'/answer/saveAnswer?qid='+qid,
                            onSubmit: function(){
                                return $("#answer-form").form('validate');
                            },
                            success: function(flag){
                                if(flag) {
                                    // $.messager.alert('我的消息','回复成功','info');
                                    $.messager.show({
                                            title:'我的消息',
                                            msg:'回复成功',
                                            timeout:5000,
                                            showType:'slide'
                                        });
                                    $("#answer-dialog").dialog({
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
                    <input class="easyui-validatebox" id="title" placeholder="请输入标题查询">
                    <a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a> 
                </td>
            </tr>
        </table>
        <a href="#" id="btn-add" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加问题</a>
        <a href="#" id="btn-edit" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改提问</a>
        <a href="#" id="btn-remove" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除提问</a>
    </div>

    <%-- //添加对话框 --%>
    <div id="add-dialog" class="easyui-dialog" title="添加问题" closed="true" modal="true"
    style="width:400px;height:200px;">
        <form id="add-form" method="post">
            <table>
                <tr>
                    <td>选择标签</td>
                    <td>
                        <input class="easyui-combobox" name="tid" required="false" data-options="valueField:'tid',textField:'tname',url:'/tags/list'">
                    </td>
                </tr>
                <tr>
                    <td>问题标题</td>
                    <td><input name="title" class="easyui-validatebox" required="true"></td>
                </tr>
                <tr>
                    <td>描述</td>
                    <td>
                        <textarea name="content"></textarea>
                    </td>
                </tr>
            </table>
        </form>
    
    </div>
    
    <%-- //添加对话框 --%> 
    <div id="edit-dialog" class="easyui-dialog" title="修改问题" closed="true" modal="true"
    style="width:400px;height:200px;">
        <form id="edit-form" method="post">
            <table>
                <tr>
                    <td>选择标签</td>
                    <td>
                        <input class="easyui-combobox" name="tid" required="false" data-options="valueField:'tid',textField:'tname',url:'/tags/list'">
                    </td>
                </tr>
                <tr>
                    <td>问题标题</td>
                    <td>
                        <input name="title" class="easyui-validatebox" required="true">
                        <input type="hidden" name="qid">
                    </td>
                </tr>
                <tr>
                    <td>描述</td>
                    <td>
                        <textarea name="content"></textarea>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <%-- //添加对话框 --%> 
    <div id="answer-dialog" class="easyui-dialog" title="请输入回复信息" closed="true" modal="true"
    style="width:400px;height:200px;">
        <form id="answer-form" method="post">
            <textarea  name="content" rows="10" cols="30" placeholder="请输入回复内容">
            </textarea>
        </form>
    </div>

</body>
</html>