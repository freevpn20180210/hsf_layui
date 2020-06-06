<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Access-Control-Allow-Origin" content="*"/>
    <title></title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="<%=path%>/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="<%=path%>/layuiadmin/style/admin.css" media="all">
</head>
<body>

<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md8">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">快捷方式</div>
                        <div class="layui-card-body">
                            <div class="layui-carousel layadmin-carousel layadmin-shortcut">
                                <div carousel-item>
                                    <ul class="layui-row layui-col-space10">
                                        <li class="layui-col-xs3">
                                            <a lay-href="https://www.baidu.com">
                                                <i class="layui-icon layui-icon-search"></i>
                                                <cite>百度一下</cite>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs3">
                                            <a href="https://www.hao123.com/">
                                                <i class="layui-icon layui-icon-find-fill"></i>
                                                <cite>网址导航</cite>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs3">
                                            <a lay-href="http://tool.liumingye.cn/music/">
                                                <i class="layui-icon layui-icon-headset"></i>
                                                <cite>听音乐</cite>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs3">
                                            <a lay-href="http://www.qmaile.com/">
                                                <i class="layui-icon layui-icon-play"></i>
                                                <cite>看视频</cite>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs3">
                                            <a lay-href="https://news.163.com/">
                                                <i class="layui-icon layui-icon-read"></i>
                                                <cite>新闻</cite>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs3">
                                            <a lay-href="http://www.4399.com/">
                                                <i class="layui-icon layui-icon-release"></i>
                                                <cite>小游戏</cite>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs3">
                                            <a lay-href="https://tool.lu/">
                                                <i class="layui-icon layui-icon-util"></i>
                                                <cite>在线工具</cite>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs3">
                                            <a lay-href="https://blog.csdn.net/weixin_41763571">
                                                <i class="layui-icon layui-icon-star"></i>
                                                <cite>我的博客</cite>
                                            </a>
                                        </li>
                                    </ul>
                                    <ul class="layui-row layui-col-space10">

                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header" id="today"></div>
                        <div class="layui-card-body">
                            <div class="layui-carousel layadmin-carousel layadmin-backlog">
                                <div carousel-item>
                                    <ul class="layui-row layui-col-space10">
                                        <li class="layui-col-xs6">
                                            <div class="layadmin-backlog-body">
                                                <h3>您的位置</h3>
                                                <p><cite id="position" style="font-size: 22px">66</cite></p>
                                            </div>
                                        </li>
                                        <li class="layui-col-xs6">
                                            <div class="layadmin-backlog-body">
                                                <h3>您的网络</h3>
                                                <p><cite id="isp" style="font-size: 22px">12</cite></p>
                                            </div>
                                        </li>
                                        <li class="layui-col-xs6">
                                            <div class="layadmin-backlog-body">
                                                <h3>您的ip</h3>
                                                <p><cite id="ip" style="font-size: 22px">99</cite></p>
                                            </div>
                                        </li>
                                        <li class="layui-col-xs6">
                                            <div class="layadmin-backlog-body">
                                                <h3>您的设备</h3>
                                                <p><cite id="userAgent" style="font-size: 22px">20</cite></p>
                                            </div>
                                        </li>
                                    </ul>
                                    <ul class="layui-row layui-col-space10">
                                        <li class="layui-col-xs6">
                                            <div lay-href="<%=path%>/views/chat/chat.jsp" class="layadmin-backlog-body">
                                                <h3>聊天室</h3>
                                                <p><cite style="font-size: 22px">点击</cite></p>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header">油价趋势</div>
                        <div class="layui-card-body">
                            <div class="layui-row">
                                <div class="layui-col-sm10">
                                    <div id="oil" class="layui-carousel layadmin-carousel layadmin-dataview"></div>
                                </div>
                                <div class="layui-col-sm2">
                                    <div class="layuiadmin-card-list">
                                        <p class="layuiadmin-normal-font"><span style="color: #FF7F50">#0</span>较昨日价格
                                        </p>
                                        <span id="s0"></span>
                                        <div lay-filter="p0" class="layui-progress layui-progress-big"
                                             lay-showPercent="yes">
                                            <div id='p0' class="layui-progress-bar" lay-percent="0%"></div>
                                        </div>
                                    </div>
                                    <div class="layuiadmin-card-list">
                                        <p class="layuiadmin-normal-font"><span style="color: #87CEFA">#92</span>较昨日价格
                                        </p>
                                        <span id="s92"></span>
                                        <div lay-filter="p92" class="layui-progress layui-progress-big"
                                             lay-showPercent="yes">
                                            <div id='p92' class="layui-progress-bar" lay-percent="0%"></div>
                                        </div>
                                    </div>
                                    <div class="layuiadmin-card-list">
                                        <p class="layuiadmin-normal-font"><span style="color: #DA70D6">#95</span>较昨日价格
                                        </p>
                                        <span id="s95"></span>
                                        <div lay-filter="p95" class="layui-progress layui-progress-big"
                                             lay-showPercent="yes">
                                            <div id='p95' class="layui-progress-bar" lay-percent="0%"></div>
                                        </div>
                                    </div>
                                    <div class="layuiadmin-card-list">
                                        <p class="layuiadmin-normal-font"><span style="color: #32CD32">#98</span>较昨日价格
                                        </p>
                                        <span id="s98"></span>
                                        <div lay-filter="p98" class="layui-progress layui-progress-big"
                                             lay-showPercent="yes">
                                            <div id='p98' class="layui-progress-bar" lay-percent="0%"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-card">
                        <div class="layui-card-header">历史上的今天</div>
                        <div class="layui-card-body">
                            <table id="table" lay-filter="table"></table>
                            <%--图片模板--%>
                            <script type="text/html" id="imgTpl">
                                <img style="width: 30px; height: 30px;" src='{{d.pic }}'
                                     onerror="this.src='<%=basePath%>my/img/staff.png'"
                                     onclick="
                                     function isPC() {
                                        var userAgent = navigator.userAgent;
                                        var Agents = ['Android', 'iPhone', 'SymbianOS', 'Windows Phone', 'iPad', 'iPod'];
                                        var flag = true;
                                        for (var v = 0; v < Agents.length; v++) {
                                            if (userAgent.indexOf(Agents[v]) > 0) {
                                            flag = false;
                                            break;
                                            }
                                        }
                                        return flag;
                                     }
                                     var area;
                                     if(isPC()){
                                        area=[this.width, this.height]
                                     }else{
                                        area=['80%','60%']
                                     }
                                     layer.open(
                                        {
                                          type:1,
                                          title: false,
                                          content:'<img src=' +this.src+ '>',
                                          skin: 'layui-layer-rim',
                                          area: area,
                                          shadeClose: true,
                                         }
                                     )">
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-col-md4">
            <div class="layui-card">
                <div class="layui-card-header">版本信息</div>
                <div class="layui-card-body layui-text">
                    <table class="layui-table">
                        <colgroup>
                            <col width="100">
                            <col>
                        </colgroup>
                        <tbody>
                        <tr>
                            <td>当前版本</td>
                            <td>1.0</td>
                        </tr>
                        <tr>
                            <td>基于框架</td>
                            <td>
                                <script type="text/html" template>
                                    layui-v{{ layui.v }}
                                </script>
                                <button id="intro" class="layui-btn layui-btn-sm">网站简介</button>
                            </td>
                        </tr>
                        <tr>
                            <td>主要特色</td>
                            <td>零门槛 / 响应式 / 清爽 / 极简</td>
                        </tr>
                        <tr>
                            <td>技术栈</td>
                            <td style="padding-bottom: 0;">
                                <div class="layui-btn-container">
                                    <button id="technical" class="layui-btn layui-btn-danger">查看</button>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="layui-card">
                <div class="layui-card-header">系统实时监控</div>
                <div class="layui-card-body layadmin-takerates">
                    <div class="layui-progress" lay-showPercent="yes" lay-filter="cpu">
                        <h3>CPU使用率</h3>
                        <div class="layui-progress-bar" lay-percent="0%"></div>
                    </div>
                    <div class="layui-progress" lay-showPercent="yes" lay-filter="mem">
                        <h3>内存占用率</h3>
                        <div class="layui-progress-bar layui-bg-red" lay-percent="0%"></div>
                    </div>
                    <div class="layui-progress" lay-showPercent="yes" lay-filter="disk">
                        <h3>硬盘占用率</h3>
                        <div class="layui-progress-bar layui-bg-red" lay-percent="0%"></div>
                    </div>
                </div>
            </div>

            <div class="layui-card">
                <div class="layui-card-header">系统详细信息</div>
                <div class="layui-card-body layadmin-takerates layui-bg-blue">
                    <div>
                        <div>内存信息:</div>
                        <div>
                            <span id="availableMem"></span><br>
                            <span id="usedMem"></span><br>
                            <span id="totalMem"></span>
                        </div>
                    </div>
                    <hr>
                    <div>
                        <div>硬盘信息:</div>
                        <div>
                            <span id="availableDisk"></span><br>
                            <span id="usedDisk"></span><br>
                            <span id="totalDisk"> </span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="layui-card">
                <div class="layui-card-header">
                    作者心语
                    <i class="layui-icon layui-icon-tips" lay-tips="要支持的噢" lay-offset="5"></i>
                </div>
                <div class="layui-card-body layui-text layadmin-text" id="saying">
                    <p>待我君临天下，许你四海为家</p>
                    <p> 待我了无牵挂，许你浪迹天涯</p>
                    <p> 待我半生戎马du，许你共话桑麻</p>
                    <p> 待我功成名达，许你花前月下</p>
                    <p> 待我名满华夏，许你放歌纵马</p>
                    <p> 待我弦断音垮，许你青丝白发</p>
                    <p> 待我不再有她，许你淡饭粗茶</p>
                    <p> 待我高头大马专，许你嫁衣红霞</p>
                    <p> 待我富贵荣华，属许你十里桃花</p>
                    <p> 待我一袭袈裟，许你相思放下</p>
                    <p> 不困于心,不乱于情,不念过往,不畏将来</p>
                    <p> 旅行不是为了风景,而是为了人生</p>
                    <p>—— lyf（<a href="http://www.layui.com/" target="_blank">layui.com</a>）</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<%=path%>/layuiadmin/layui/layui.js"></script>
<script src="<%=path%>/my/fast.js"></script>
<%--中国天气网--%>
<script type="text/javascript">
    WIDGET = {FID: 'lOYj9lErgA'}
</script>
<script type="text/javascript" src="https://apip.weatherdt.com/float/static/js/r.js?v=1111"></script>
<script>
    layui.config({
        base: '<%=path%>/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'console', 'table', 'sample', 'echarts', 'element'], function () {
        var $ = layui.$
        var table = layui.table
        var echarts = layui.echarts
        var element = layui.element

        //今日日期信息
        $.post('<%=path%>/juhe/today', (rs) => {
            function showTime() {
                var date = dateFtt('yyyy-MM-dd HH:mm:ss', new Date())
                $('#today').html(date + '  ' + rs.day_of_week_format +
                    '  第' + rs.day_of_year + '天,' +
                    '第' + rs.week_of_year + '周')
            }

            setInterval(() => {
                showTime()
            }, 1000)
        })
        //国内油价趋势图表
        !function getOilTrend() {
            var index = layer.load(1)
            $.ajax(
                {
                    async: false,
                    type: 'post',
                    url: "<%=path%>/juhe/getOilTrend",
                    success: function (rs) {
                        if (rs.ok) {
                            layer.close(index)
                            var userAgent = ''
                            if (isPC()) {
                                userAgent = '电脑'
                            } else {
                                userAgent = '手机'
                            }
                            $('#position').text(rs.province + rs.city)
                            $('#isp').text(rs.isp)
                            $('#ip').text(rs.ip)
                            $('#userAgent').text(userAgent)
                            var chart = echarts.init(document.getElementById('oil'))
                            var option = {
                                title: {
                                    text: new Date().getFullYear() + '年'
                                },
                                tooltip: {
                                    trigger: 'axis'
                                },
                                legend: {
                                    data: ['#0', '#92', '#95', '#98']
                                },
                                xAxis: {
                                    boundaryGap: false, //从起点开始
                                    data: rs.date
                                },
                                yAxis: {
                                    type: 'value'
                                },
                                series: [
                                    {
                                        smooth: true,
                                        name: '#0',
                                        type: 'line',
                                        data: rs.a,
                                    },
                                    {
                                        smooth: true,
                                        name: '#92',
                                        type: 'line',
                                        data: rs.b,
                                    },
                                    {
                                        smooth: true,
                                        name: '#95',
                                        type: 'line',
                                        data: rs.c,
                                    },
                                    {
                                        smooth: true,
                                        name: '#98',
                                        type: 'line',
                                        data: rs.d,
                                    },
                                ]
                            };
                            chart.setOption(option, true);
                            $.ajax(
                                {
                                    type: 'post',
                                    url: "<%=path%>/juhe/analyze",
                                    data: {province: rs.province},
                                    success: function (rs) {
                                        if (rs.ok) {
                                            var data = rs.data
                                            $('#s0').html(data.s0)
                                            $('#s92').html(data.s92)
                                            $('#s95').html(data.s95)
                                            $('#s98').html(data.s98)
                                            //必须延时一段时间进度条才能被正确渲染,layui也不行啊
                                            setTimeout(() => {
                                                function extracted(dataS, $p) {
                                                    if (dataS.indexOf('上升') != -1) {
                                                        $($p).addClass('layui-bg-red')
                                                    }
                                                }

                                                extracted(data.s0, '#p0');
                                                extracted(data.s92, '#p92');
                                                extracted(data.s95, '#p95');
                                                extracted(data.s98, '#p98');
                                                //修改进度条文本颜色
                                                $('span.layui-progress-text').attr('style', 'color:black')
                                                element.progress('p0', data.p0 + '%');
                                                element.progress('p92', data.p92 + '%');
                                                element.progress('p95', data.p95 + '%');
                                                element.progress('p98', data.p98 + '%');
                                            }, 200)
                                        } else {
                                            layer.msg(rs.msg)
                                        }
                                    },
                                },
                            )
                        }
                    },
                    error: function (rs) {
                        getOilTrend()
                    },
                    timeout: 10000
                },
            )
        }()

        //系统监控
        setInterval(() => {
            $.post('<%=path%>/systemMonitor/show', (rs) => {
                element.progress('cpu', rs.cpu.useRateCPU.toFixed(2) + '%');
                element.progress('mem', rs.mem.useRateMem.toFixed(2) + '%');
                element.progress('disk', rs.disk.useRateDisk.toFixed(2) + '%');
                $('#availableMem').html('可用:' + rs.mem.availableMem)
                $('#usedMem').html('已用:' + rs.mem.usedMem)
                $('#totalMem').html('总容量:' + rs.mem.totalMem)
                $('#availableDisk').html('可用:' + rs.disk.availableDisk)
                $('#usedDisk').html('已用:' + rs.disk.usedDisk)
                $('#totalDisk').html('总容量:' + rs.disk.totalDisk)
            })
        }, 1500)


        //网站简介
        $('#intro').on('click', function () {
            var index = layer.open({
                type: 1,
                title: false,
                closeBtn: false,
                area: '300px;',
                shade: 0.8,
                shadeClose: true,
                resize: false,
                content: '<div style="padding: 50px; line-height: 22px;' +
                    ' background-color: #393D49; color: #fff; font-weight: 300;">' +
                    'Hi,各位小伙伴,本网站是我在业余时间制作的,目的是构建一套基于layui的基本后台管理系统框架<br><br>' +
                    '你可以在这里上网冲浪,听歌看视频,了解新闻,玩小游戏,与匿名用户相互聊天,观察最近国内油价趋势,查看历史上的今天等<br><br>' +
                    '也欢迎访问我的CSDN博客,星辰大海,始于足下 ^_^</div>',
                btn: ['赞', '踩'],
                btnAlign: 'c', yes: function (index, layero) {
                    layer.msg('谢谢!', {icon: 1});
                    layer.close(index)
                },
                btn2: function (index, layero) {
                    layer.msg('不开心。。', {icon: 5});
                    layer.close(index)
                }
            });
        });

        //查看技术栈
        $('#technical').on('click', function () {
            var index = layer.open({
                type: 1,
                title: false,
                closeBtn: false,
                area: '300px;',
                shade: 0.8,
                shadeClose: true,
                resize: false,
                content: '<div style="padding: 50px; line-height: 22px;' +
                    ' background-color: #393D49; color: #fff; font-weight: 300;">' +
                    '前端:<br>layui,html,css,js,jquery<br><br>' +
                    '后端:<br>springboot,spring,hibernate,<br>shiro,kaptcha,okhttp3,<br>fileupload,websocket,jms等<br><br>' +
                    '数据库:<br>mysql</div>',
                btn: ['赞', '踩'],
                btnAlign: 'c', yes: function (index, layero) {
                    layer.msg('谢谢!', {icon: 1});
                    layer.close(index)
                },
                btn2: function (index, layero) {
                    layer.msg('不开心。。', {icon: 5});
                    layer.close(index)
                }
            });
        });

        // 渲染表格
        table.render({
            elem: '#table',
            url: '<%=path%>/juhe/toh',
            toolbar: '#toolbar',
            height: 490,
            cols: [[
                {type: 'numbers'},
                {field: 'title', title: '事件', sort: true, align: 'center', width: '240'},
                {field: 'des', title: '详细', sort: true, align: 'center', width: '350'},
                {field: 'year', title: '年', sort: true, align: 'center', width: '80'},
                {field: 'month', title: '月', sort: true, align: 'center', width: '60'},
                {field: 'day', title: '日', sort: true, align: 'center', width: '60'},
                {field: 'pic', title: '图片', sort: true, align: 'center', templet: '#imgTpl', width: '60'},
            ]],
        })

        var css = 'text-shadow:0 0 4px #FFF,0 -5px 4px #ff3,2px -10px 6px #fd3, -2px -15px 11px #f80, 2px -25px 18px #f20;'
        $('#saying>p:even').attr('style', 'margin-top:15px;color:#22A1FF;font-family:楷体;font-size:16px;' + css)
        $('#saying>p:odd').attr('style', 'color:#f619cb;font-family:楷体;font-size:16px;')
    });
</script>
</body>
</html>

