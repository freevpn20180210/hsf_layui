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
            <div class="layui-card-body">
                <div class="layui-form" lay-filter="form">
                    <div id="tree"></div>
                    <div class="layui-form-item layui-hide">
                        <input type="button" lay-submit lay-filter="submit" id="submit">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<%=path%>/layuiadmin/layui/layui.js"></script>
<script src="<%=path%>/my/fast.js"></script>
<script>
    layui.config({
        base: '<%=path%>/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'table', 'form', 'upload', 'element', 'tree'], function () {
        var $ = layui.$
        var table = layui.table
        var form = layui.form
        var upload = layui.upload;
        var element = layui.element
        var tree = layui.tree

        layuiBaseTree($, tree, form, '<%=path%>/user/listRole', '<%=path%>/user/getRoleIdByUserId', '<%=path%>/user/addRole',
            'tree', '${param.id}', 'roleIds')

    });

</script>
</body>
</html>
