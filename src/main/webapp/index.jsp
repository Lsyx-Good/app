<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
 <title>首页</title>
    <link rel="stylesheet" type="text/css" href="/jeasyui/themes/bootstrap/easyui.css" />
    <link rel="stylesheet" type="text/css" href="/jeasyui/themes/icon.css" />
    <script type="text/javascript" src="/jeasyui/jquery.min.js"></script>
    <script type="text/javascript" src="/jeasyui/jquery.easyui.min.js"></script>
    <script src="/jeasyui/echarts.min.js"></script>
    <script>
        function openTabs(url, text) {
            if ($("#tabs").tabs('exists', text)) {
                $("#tabs").tabs("select", text)
            } else {
                let myContext = "<iframe frameborder='0' scrolling='auto' style = 'width: 100%; height: 100%;' src ="  + url +  "></iframe > ";
                $("#tabs").tabs('add', {
                    title: text,
                    closable: true,
                    content: myContext
                })
            }
        };
        $(function () {

            let myChart = echarts.init(document.getElementById('main'));
            let myChart1 = echarts.init(document.getElementById('main1'));
            let myChart2 = echarts.init(document.getElementById('main2'));
            let myChart3 = echarts.init(document.getElementById('main3'));

            $.post('/logs/countTimes', function (data) {
                // 指定图表的配置项和数据
                let option = {
                    title: {
                        text: '系统访问用户数据分析图'
                    },
                    tooltip: {},
                    legend: {
                        data: ['登录次数统计']
                    },
                    xAxis: {
                        data: data.names
                    },
                    yAxis: {},
                    series: [
                        {
                            name: '登录次数',
                            type: 'bar',
                            data: data.times
                        }
                    ]
                };
                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);
            })
            $.post('/tags/countTimesTags', function (data) {
                // 指定图表的配置项和数据
                let option = {
                    title: {
                        text:'标签类别问题数统计分析图'
                    },
                    tooltip: {
                        trigger: 'item'
                    },
                    legend: {
                        top: '5%',
                        left: 'center'
                    },
                    series: [
                        {
                            name: '类别下问题数',
                            type: 'pie',
                            radius: ['40%', '70%'],
                            avoidLabelOverlap: false,
                            label: {
                                show: false,
                                position: 'center'
                            },
                            emphasis: {
                                label: {
                                    show: true,
                                    fontSize: '40',
                                    fontWeight: 'bold'
                                }
                            },
                            labelLine: {
                                show: false
                            },
                            data: data
                        }
                    ]
                };
                // 使用刚指定的配置项和数据显示图表。
                myChart1.setOption(option);
            })
            $.post('/users/countSexTimes', function (data) {
                let sex = [];
                let counts = [];
                for (let i in data){
                    sex.push(data[i].sex);
                    counts.push(data[i].total);
                }

                // 指定图表的配置项和数据
                let option = {
                    title: {
                        text:'系统注册性别占比统计分析图'
                    },
                        xAxis: {
                            type: 'category',
                            data: sex
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [
                            {
                            data: counts,
                            type: 'line'
                            }
                        ]
                    };
                // 使用刚指定的配置项和数据显示图表。
                myChart2.setOption(option);
            })
            $.post('/question/countHotTitle', function (data) {

                // 指定图表的配置项和数据
                let option = {
                    title: {
                        text: '热点问题统计分析图',
                    },
                    tooltip: {
                        trigger: 'item'
                    },

                    series: [
                        {
                        name: '回复数',
                        type: 'pie',
                        radius: '50%',
                        data: data,
                        emphasis: {
                            itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                        }
                    ]
                    };
                // 使用刚指定的配置项和数据显示图表。
                myChart3.setOption(option);
            })
        })
    </script>
</head>

<body class="easyui-layout">

    <div data-options="region:'north',title:'问答管理系统',split:true" style="height: 100px">
        <div align="right" style="color:red">
            <h4>当前登录人[<shiro:principal></shiro:principal>]<a href="/zhuxiao">注销</a></h4>            
        </div>
    </div>
    <div data-options="region:'west',title:'导航菜单',split:true" style="width: 200px">
        <div class="easyui-accordion" style="width: 100%; height: 100%">
            <div title="提问信息管理">
                <shiro:hasAnyRoles name="0">
                    <a href="#" onclick="openTabs('jsp/tagsList.jsp','标签管理')" class="easyui-linkbutton" plain="true"
                    style="width: 100%;">标签管理</a>
                </shiro:hasAnyRoles>
                <shiro:hasAnyRoles name="0,1">
                    <a href="#" onclick="openTabs('jsp/questionList.jsp','提问管理')" class="easyui-linkbutton" plain="true"
                    style="width: 100%;">提问管理</a>
                </shiro:hasAnyRoles>
                <shiro:hasAnyRoles name="0,1">
                    <a href="#" onclick="openTabs('jsp/answerList.jsp','回复管理')" class="easyui-linkbutton" plain="true"
                    style="width: 100%;">回复管理</a>
                </shiro:hasAnyRoles>
            </div>
            <shiro:hasAnyRoles name="0,1">
                <div title="评论信息管理">
                    <a href="#" onclick="openTabs('jsp/commentList.jsp','评论管理')" class="easyui-linkbutton" plain="true"
                    style="width: 100%;">评论管理</a>
                </div>
            </shiro:hasAnyRoles>
            <!-- <shiro:hasAnyRoles name="0">
                <div title="数据分析管理">
                    <a href="#" onclick="openTabs('jsp/analyze.html','数据分析')" class="easyui-linkbutton" plain="true" style="width: 100%;">数据分析管理</a>
                </div>
            </shiro:hasAnyRoles> -->
            <shiro:hasAnyRoles name="0">
                <div title="系统信息管理">
                </shiro:hasAnyRoles>
            <shiro:hasAnyRoles name="1">
                <div title="个人信息管理">
                </shiro:hasAnyRoles>
                    <shiro:hasAnyRoles name="0">
                    <a href="#" onclick="openTabs('jsp/usersList.jsp','用户管理')" class="easyui-linkbutton" plain="true"
                    style="width: 100%;">用户管理</a>
                </shiro:hasAnyRoles>
                    <shiro:hasAnyRoles name="1">
                    <a href="#" onclick="openTabs('jsp/usersList.jsp','个人信息管理')" class="easyui-linkbutton" plain="true"
                    style="width: 100%;">个人信息管理</a>
                </shiro:hasAnyRoles>
                <shiro:hasAnyRoles name="0">
                    <a href="#" onclick="openTabs('jsp/logsList.jsp','日志管理')" class="easyui-linkbutton" plain="true"
                    style="width: 100%;">日志管理</a>
                    <a href="#" onclick="openTabs('jsp/rolesList.jsp','角色管理')" class="easyui-linkbutton" plain="true"
                    style="width: 100%;">角色管理</a>
                </shiro:hasAnyRoles>
            </div>
        </div>
    </div>
    <div data-options="region:'center',title:'显示'" style="padding: 5px; background: #eee">
        <div id="tabs" class="easyui-tabs" fit="true">
            <div title="首页">
                <table>
                    <tr>
                        <td>
                            <div id="main3" style="width: 500px;height: 300px;"></div>
                        </td>
                        <td>
                            <div id="main1" style="width: 500px;height: 300px;"></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div id="main2" style="width: 500px;height: 300px;"></div>
                        </td>
                        <td>
                            <div id="main" style="width: 500px;height: 300px;"></div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</body>
</html>