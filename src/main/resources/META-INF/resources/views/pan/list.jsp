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
    <title></title>
    <meta content="webkit" name="renderer">
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0"
          name="viewport">
    <link href="<%=path%>/layuiadmin/layui/css/layui.css" media="all" rel="stylesheet">
    <link href="<%=path%>/layuiadmin/style/admin.css" media="all" rel="stylesheet">
</head>
<body>

<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body">

                    <%--顶部搜索框 start --%>
                    <div class="layui-form layui-card-header layuiadmin-card-header-auto">
                        <div class="layui-inline">
                            <label class="layui-form-label">文件名：</label>
                            <div class="layui-input-block">
                                <input type="text" placeholder="请输入" autocomplete="off"
                                       class="layui-input" data-uid="search">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">时间：</label>
                            <div class="layui-input-block">
                                <input type="text" placeholder="请输入" autocomplete="off"
                                       class="layui-input" data-uid="search" id="time">
                            </div>
                        </div>

                        <div class="layui-inline" style="margin-left: 30px">
                            <button class="layui-btn" data-type="search">
                                <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>搜索
                            </button>
                            <button class="layui-btn layui-btn-radius layui-btn-danger" data-type="clear">
                                <i class="layui-icon layui-icon-close layuiadmin-button-btn"></i>清空
                            </button>
                        </div>

                        <div style="padding-top: 10px;padding-bottom: 10px;">
                            <div id="panInfo">
                                <span id="totle"></span>
                                <span id="used"></span>
                                <span id="usable"></span>
                            </div>
                            <div class="layui-progress" lay-showpercent="true" style="margin-top: 5px;"
                                 lay-filter="usedRate">
                                <div class="layui-progress-bar" lay-percent="0%"></div>
                            </div>
                        </div>

                    </div>
                    <%--顶部搜索框 end --%>

                    <%--顶部按钮--%>
                    <div style="padding-top: 10px;padding-bottom: 10px;text-align: center">
                        <button class="layui-btn layui-btn-normal" data-type="uploadFile" id="uploadFile">上传文件</button>
                        <button class="layui-btn layui-btn-danger" data-type="delAll">批量删除</button>
                    </div>

                    <div style="padding-top: 10px;padding-bottom: 10px;">
                        <div class="layui-progress" lay-showpercent="true" style="margin-top: 5px;display: none"
                             lay-filter="progress">
                            <div class="layui-progress-bar" lay-percent="0%"></div>
                        </div>
                    </div>
                    <%--表格主体--%>
                    <table id="table" lay-filter="table"></table>

                    <%--表格行基本操作按钮--%>
                    <script type="text/html" id="operation">
                        <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="download"><i
                                class="layui-icon layui-icon-download-circle">下载</i></a>
                        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
                                class="layui-icon layui-icon-delete">删除</i></a>
                    </script>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<%=path%>/layuiadmin/layui/layui.js"></script>
<script src="<%=path%>/my/fast.js"></script>
<script>
    var FIND = '<%=path%>/pan/list'
    var DEL = '<%=path%>/pan/del'
    var TOSAVEUPDATE = ''

    layui.config({
        base: '<%=path%>/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'table', 'form', 'laydate', 'upload', 'element'], function () {
        var $ = layui.$
        var table = layui.table
        var form = layui.form
        var laydate = layui.laydate
        var upload = layui.upload;
        var element = layui.element

        //日期选择器
        laydate.render({
            elem: '#time',
            type: 'date'
        })

        $('#panInfo>span:eq(0)').css({'color': 'green'})
        $('#panInfo>span:eq(1)').css({'padding-left': '35%', 'color': 'red'})
        $('#panInfo>span:eq(2)').css({'padding-left': '35%', 'color': 'blue'})
        //得到登录的用户的网盘容量信息
        $.post('<%=path%>/pan/getLoginUserPanInfo', (rs) => {
            if (rs.ok) {
                setTimeout(() => {
                    $('#totle').html('总容量:' + rs.total + 'MB')
                    $('#used').html('已用容量:' + rs.used + 'MB')
                    $('#usable').html('剩余容量:' + rs.usable + 'MB')
                    element.progress('usedRate', rs.usedRate + '%')
                }, 300)
            }
        })

        // 渲染表格
        table.render({
            elem: '#table',
            url: FIND,
            toolbar: '#toolbar',
            cols: [[
                {type: 'numbers'},
                {type: 'checkbox'},
                {field: 'name', title: '文件名', sort: true, align: 'center', width: '500'},
                {field: 'size', title: '大小', sort: true, align: 'center', width: '150'},
                {field: 'createTime', title: '上传时间', sort: true, align: 'center', width: '300'},
                // 表格行操作按钮
                {title: '操作', toolbar: '#operation', align: 'center', width: '350'}
            ]],
            page: true,
        })

        /*******************************************顶部按钮添加对应方法*************************************************/
        /***********************************************基于data-type*************************************************/
            //获取顶部所有搜索框
        var searches = $('[data-uid=search]')

        //layui增删改查--基本顶部按钮的实现
        var active = layuiBaseTopBtn_reload($, table, searches, DEL, TOSAVEUPDATE)

        //上传文件按钮
        active.uploadFile = layuiUploadFile($, table, upload, element,
            '#uploadFile', '<%=path%>/pan/fileUpload', 'div[class=layui-progress]')

        //给按钮注册点击事件
        $('.layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        })

        /*******************************************表格行按钮对应的方法*************************************************/
        /*********************************************基于事件lay-event***********************************************/
        //表格行工具栏事件--tool(table)中的table为表格id
        table.on('tool(table)', function (obj) {
            var data = obj.data;
            //layui增删改查--基本事件按钮的实现
            layuiBaseEvent_reload($, table, searches, obj, DEL, TOSAVEUPDATE)
            //下载文件
            if (obj.event === 'download') {
                $(obj.tr).find('a[lay-event=download]').attr('href', '<%=basePath%>' + data.path)
            }
        })

        /*******************************************layui增删改查--公共js模板*******************************************/
        //layuiPublic1($, searches)

    });

</script>
</body>
</html>
