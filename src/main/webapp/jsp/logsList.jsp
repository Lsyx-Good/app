<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>日志页面</title>
    <link rel="stylesheet" type="text/css" href="/jeasyui/themes/bootstrap/easyui.css" />
    <link rel="stylesheet" type="text/css" href="/jeasyui/themes/icon.css" />
    <script type="text/javascript" src="/jeasyui/jquery.min.js"></script>
    <script type="text/javascript" src="/jeasyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="/jeasyui/easyui-lang-zh_CN.js"></script>
    <script>
        $(function(){
            
            $("#btn-search").click(function(){
                $("#dg").datagrid('reload',{
                    opername:$("#opername").val()
                })
            })

            $("#dg").datagrid({
                url: '/logs/listLogs', //请求服务端url地址
                fitColumns: true, //单元格自适应表格数据，防止出现滚动条
                fit: true, //表格自身适应父容器
                nowrap: false, //单元格数据显示换行
                pagination:true, //在底部显示分页工具栏
                pagePosition:"both",
                toolbar:'#tb',
                columns: [[ //表头二维数组
                { field: 'operid', checkbox:true },                
                { field: 'opername', title: '操作人', width:60 },
                { field: 'ip', title: '访问ip', width:60},
                { field: 'opertime', title: '操作时间', width:60 },
                { field: 'methods', title: '操作方法', width:100 },
                { field: 'ddesc', title: '访问描述', width:80 },       
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
                    <input id="opername" class="easyui-validatebox">
                    <a href="#" id="btn-search" class="easyui-linkbutton" iconCls="icon-search" plain="true">查询</a>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>