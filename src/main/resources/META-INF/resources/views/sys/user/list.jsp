<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
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
                            <label class="layui-form-label">用户名</label>
                            <div class="layui-input-block">
                                <input type="text" placeholder="请输入" autocomplete="off"
                                       class="layui-input" data-uid="search">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">邮箱</label>
                            <div class="layui-input-block">
                                <input type="text" placeholder="请输入" autocomplete="off"
                                       class="layui-input" data-uid="search">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">性别</label>
                            <div class="layui-input-block">
                                <select data-uid="search">
                                    <option value="">不限</option>
                                    <option value="男">男</option>
                                    <option value="女">女</option>
                                </select>
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
                        <button class="layui-btn layuiadmin-btn-list" data-type="save">添加</button>
                        <button class="layui-btn layui-btn-danger" data-type="delAll">批量删除</button>
                    </div>

                    <%--表格主体--%>
                    <table id="table" lay-filter="table"></table>

                    <%--表格行基本操作按钮--%>
                    <script type="text/html" id="operation">
                        <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="update"><i
                                class="layui-icon layui-icon-edit">修改</i></a>
                        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
                                class="layui-icon layui-icon-delete">删除</i></a>
                    </script>

                    <%--表格行操作按钮--%>
                    <script type="text/html" id="updateRole">
                        <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="updateRole"><i
                                class="layui-icon layui-icon-auz"></i></a>
                    </script>

                    <%--表格行操作按钮--%>
                    <script type="text/html" id="updateMenu">
                        <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="updateMenu"><i
                                class="layui-icon layui-icon-menu-fill"></i></a>
                    </script>

                    <%--表格行操作按钮--%>
                    <script type="text/html" id="updatePerm">
                        <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="updatePerm"><i
                                class="layui-icon layui-icon-app"></i></a>
                    </script>

                    <%--表格行操作按钮--%>
                    <script type="text/html" id="updatePwd">
                        <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="updatePwd"><i
                                class="layui-icon layui-icon-password"></i></a>
                    </script>

                    <%--图片模板--%>
                    <script type="text/html" id="imgTpl">
                        <img style="width: 30px; height: 30px;" src='<%=basePath%>{{ d.pic }}'
                             onerror="this.src='<%=basePath%>my/img/staff.png'">
                    </script>

                    <%--复选框模板--%>
                    <script type="text/html" id="checkboxTpl">
                        <input type="checkbox" name="locked" value="{{d.locked}}" title="锁定" lay-filter="locked" {{
                               d.locked== 1 ? 'checked' : '' }}>
                    </script>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<%=path%>/layuiadmin/layui/layui.js"></script>
<script src="<%=path%>/my/fast.js"></script>
<script>
    var FIND = '<%=path%>/user/list'
    var DEL = '<%=path%>/user/del'
    var TOSAVEUPDATE = '<%=path%>/user/toSaveUpdate?id='

    layui.config({
        base: '<%=path%>/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'table', 'form', 'laydate'], function () {
        var $ = layui.$
        var table = layui.table
        var form = layui.form
        var laydate = layui.laydate

        // 渲染表格
        table.render({
            elem: '#table',
            url: FIND,
            toolbar: '#toolbar',
            cols: [[
                {type: 'numbers'},
                {type: 'checkbox'},
                {field: 'id', title: 'ID', sort: true, align: 'center', width: '100'},
                {field: 'name', title: '用户名', sort: true, align: 'center', width: '100'},
                {field: 'nickname', title: '昵称', sort: true, align: 'center', width: '150'},
                {field: 'realname', title: '真实姓名', sort: true, align: 'center', width: '120'},
                {field: 'pic', title: '头像', sort: true, align: 'center', templet: '#imgTpl', width: '100'},
                {field: 'sex', title: '性别', sort: true, align: 'center', width: '100'},
                {field: 'phone', title: '手机', sort: true, align: 'center', width: '150'},
                {field: 'mail', title: '邮箱', sort: true, align: 'center', width: '200'},
                {field: 'mailVerified', title: '邮箱是否已验证', sort: true, align: 'center', width: '200'},
                {field: 'address', title: '地址', sort: true, align: 'center', width: '200'},
                {field: 'remark', title: '备注', sort: true, align: 'center', width: '200'},
                {field: 'locked', title: '是否锁定', sort: true, align: 'center', templet: '#checkboxTpl', width: '150'},
                {field: 'createTime', title: '创建时间', sort: true, align: 'center', width: '200'},
                {field: 'updateTime', title: '修改时间', sort: true, align: 'center', width: '200'},
                // 表格行操作按钮
                {title: '角色管理', toolbar: '#updateRole', sort: true, align: 'center', width: '120'},
                {title: '菜单管理', toolbar: '#updateMenu', sort: true, align: 'center', width: '120'},
                {title: '功能管理', toolbar: '#updatePerm', sort: true, align: 'center', width: '120'},
                {title: '修改密码', toolbar: '#updatePwd', sort: true, align: 'center', width: '120'},
                {title: '操作', toolbar: '#operation', align: 'center', width: '200'}
            ]],
            page: true
        })

        //监听锁定操作
        form.on('checkbox(locked)', function (obj) {
            //是否锁定
            var locked = obj.elem.checked
            //监听表格行
            table.on('row(table)', function (obj) {
                //取得行数据
                var data = obj.data;
                $.post('<%=path%>/user/locked', {id: data.id, locked: locked})
            })
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

            //额外事件按钮
            if (obj.event === 'updateRole') {
                var url = '<%=path%>/views/sys/user/addRole.jsp?id=' + data.id
                layuiBaseNewWindow_normalSubmit('角色管理', url, searches)
            }
            if (obj.event === 'updateMenu') {
                var url = '<%=path%>/views/sys/user/addMenu.jsp?id=' + data.id
                layuiBaseNewWindow_normalSubmit('菜单管理', url, searches)
            }
            if (obj.event === 'updatePerm') {
                var url = '<%=path%>/views/sys/user/addPerm.jsp?id=' + data.id
                layuiBaseNewWindow_normalSubmit('功能管理', url, searches)
            }
            if (obj.event === 'updatePwd') {
                var url = '<%=path%>/views/sys/user/updatePwd.jsp?id=' + data.id
                layuiBaseNewWindow_normalSubmit('修改密码', url, searches)
            }
        })

        /*******************************************layui增删改查--公共js模板*******************************************/
        //layuiPublic1($, searches)

    });
</script>
</body>
</html>
