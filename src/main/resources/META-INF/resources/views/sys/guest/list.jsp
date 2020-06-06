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
                            <label class="layui-form-label">地址：</label>
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

                    </div>
                    <%--顶部搜索框 end --%>

                    <%--顶部按钮--%>
                    <div style="padding-top: 10px;padding-bottom: 10px;text-align: center">
                        <button class="layui-btn layui-btn-danger" data-type="delAll">批量删除</button>
                    </div>

                    <%--表格主体--%>
                    <table id="table" lay-filter="table"></table>

                    <%--表格行基本操作按钮--%>
                    <script type="text/html" id="operation">
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
    var FIND = '<%=path%>/guest/list'
    var DEL = '<%=path%>/guest/del'
    var TOSAVEUPDATE = ''

    layui.config({
        base: '<%=path%>/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'table', 'form', 'laydate'], function () {
        var $ = layui.$
        var table = layui.table
        var form = layui.form
        var laydate = layui.laydate

        //日期选择器
        laydate.render({
            elem: '#time',
            type: 'date'
        })

        // 渲染表格
        table.render({
            elem: '#table',
            url: FIND,
            toolbar: '#toolbar',
            cols: [[
                {type: 'numbers'},
                {type: 'checkbox'},
                {field: 'cname', title: '地址', sort: true, align: 'center'},
                {field: 'ip', title: 'ip', sort: true, align: 'center'},
                {field: 'browser', title: '浏览器', sort: true, align: 'center'},
                {field: 'dev', title: '登录设备', sort: true, align: 'center'},
                {field: 'time', title: '时间', sort: true, align: 'center'},
                // 表格行操作按钮
                {title: '操作', toolbar: '#operation', align: 'center'}
            ]],
            page: true
        })

        /*******************************************顶部按钮添加对应方法*************************************************/
        /***********************************************基于data-type*************************************************/
            //获取顶部所有搜索框
        var searches = $('[data-uid=search]')

        //layui增删改查--基本顶部按钮的实现
        var active = layuiBaseTopBtn($, table, searches, DEL, TOSAVEUPDATE)

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
            layuiBaseEvent($, table, searches, obj, DEL, TOSAVEUPDATE)

        })

        /*******************************************layui增删改查--公共js模板*******************************************/
        //layuiPublic1($, searches)

    });

</script>
</body>
</html>
