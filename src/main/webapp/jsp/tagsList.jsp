<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>标签页面</title>
    <link rel="stylesheet" type="text/css" href="/jeasyui/themes/bootstrap/easyui.css" />
    <link rel="stylesheet" type="text/css" href="/jeasyui/themes/icon.css" />
    <script type="text/javascript" src="/jeasyui/jquery.min.js"></script>
    <script type="text/javascript" src="/jeasyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/jeasyui/easyui-lang-zh_CN.js"></script>
    <script>
        $(function() {
            //修改
            $("#btn-edit").click(function(){
                let array = $("#dg").datagrid('getSelections');
                if (array.length == 0) {
                    $.messager.alert('我的消息','请选择要删除的数据', 'error');
                }else if (array.length > 1) {
                    $.messager.alert('我的消息','只能选择一条记录进行删除', 'error');
                    $("#dg").datagrid('unselectAll'); // 取消选中的复选框
                }else {
                    //填充修改对话框中的数据
                    $("#edit-form").form('load',{
                        tname:array[0].tname,
                        tid:array[0].tid,
                        mtime:array[0].mtime
                    })

                    //弹出修改对话框
                    $("#edit-dialog").dialog({
                        closed:false,
                        buttons:[{
                            text:'保存',
                            iconCls: 'icon-save',
                            handler: function(){
                                $("#edit-form").form('submit',{
                                    url: '/tags/updateTags',
                                    onSubmit: function(){
                                        return $("#edit-form").form('validate');

                                    },
                                    success: function(flag){
                                        if (flag) {
                                            
                                            $.messager.show({
                                                title:'我的消息',
                                                msg:'修改数据成功',
                                                timeout:5000,
                                                showType:'slide'
                                            });
                                        }
                                        $("#edit-dialog").dialog({closed:true});
                                        $("#edit-form").form('clear');
                                        $("#dg").datagrid('reload');
                                    }
                                })
                            }
                        },{
                            text:'重置',
                            iconCls: 'icon-redo',
                            handler: function(){
                                
                            }
                        }]
                    })
                }
            })

            //删除
            $("#btn-remove").click(function(){
                let array=$("#dg").datagrid('getSelections');
                if (array.length == 0) {
                    $.messager.alert('我的消息','请选择要删除的数据','error');
                }else {
                    let ids = [];
                    for (let i in array) {
                        ids.push(array[i].tid);
                    }
                    $.post('/tags/removeTags',{"ids[]":ids},function(flag){
                        if (flag) {
                            $("#dg").datagrid('reload');
                            $.messager.show({
                                title:'我的消息',
                                msg:'删除数据成功',
                                timeout:5000,
                                showType:'slide'
                            });
                        }
                    })
                }
            })
            
            //添加按钮
            $("#btn-add").click(function(){
                //弹出对话框
                $("#add-dialog").dialog({
                    closed:false,
                    buttons:[{
                        text:'保存',
                        iconCls:'icon-save',
                        handler: function() {
                            $("#add-form").form('submit',{
                                url: '/tags/saveTags',
                                onSubmit: function() {
                                    return $("#add-form").form('validate');
                                },
                                success: function(flag) {
                                    if (flag) {
                                        $("#add-form").form('clear');
                                        $("#add-dialog").dialog({
                                            closed:true
                                        });
                                        $("#dg").datagrid('reload'); // 重新刷新表格
                                    }
                                }
                            })
                        }
                    },{
                        text:'重置',
                        iconCls:'icon-redo',
                        handler: function() {
                            alert('重置')
                        }
                    }]
                }) 
            })
            
            //条件查询
            $("#but-search").click(function(){
                $("#dg").datagrid('reload',{
                    tname:$("#tname").val()
                })
            })

            $("#dg").datagrid({
                url: '/tags/listTags', //请求服务端url地址
                fitColumns: true, //单元格自适应表格数据，防止出现滚动条
                fit: true, //表格自身适应父容器
                nowrap: false, //单元格数据显示换行
                pagination:true, //在底部显示分页工具栏
                pagePosition:"both",
                toolbar:'#tb',
                columns: [[ //表头二维数组
                { field: 'tid', checkbox:true },
                { field: 'tname', title: '标签名称', width:80},
                { field: 'ctime', title: '创建时间', width:80 },
                { field: 'mtime', title: '修改时间', width:80 }
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
                    <input class="easyui-validatebox" id="tname" placeholder="请输入标签名称查询" >
                    <a href="#" id="but-search" class="easyui-linkbutton"
                     iconCls="icon-search" plain="true">查询</a>
                </td>
            </tr>
        </table>
        <a href="#" id="btn-add" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加标签</a>
        <a href="#" id="btn-edit" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改标签</a>
        <a href="#" id="btn-remove" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除标签</a>
    </div>
    <%--添加对话框--%>
    <div id="add-dialog" class="easyui-dialog" title="添加标签" closed="true" modal="true"
    style="width:400px;height:200px;">
        <form id="add-form" method="post">
            <table>
                <tr>
                    <td>标签名称</td>
                    <td><input name="tname" class="easyui-validatebox" required="true"></td>
                </tr>
                <tr>
                    <td>创建时间</td>
                    <td><input name="ctime" class="easyui-datetimebox" required="true"></td>
                </tr>
            </table>
        </form>
    </div>
    <%--修改对话框--%>
    <div id="edit-dialog" class="easyui-dialog" title="修改标签" closed="true" modal="true"
    style="width:400px;height:200px;">
        <form id="edit-form" method="post">
            <table>
                <tr>
                    <td>标签名称</td>
                    <td>
                        <input name="tname" class="easyui-validatebox" required="true">
                        <%--隐藏域--%>
                        <input name="tid" type="hidden">
                    </td>
                </tr>
                <tr>
                    <td>修改时间</td>
                    <td><input name="mtime" class="easyui-datetimebox" required="true"></td>
                </tr>
            </table>
        </form>
    </div>
</body>

</html>