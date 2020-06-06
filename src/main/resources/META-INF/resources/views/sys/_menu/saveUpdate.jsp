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
                    <div class="layui-form-item">
                        <label class="layui-form-label">菜单名<span style="color:red">*</span></label>
                        <div class="layui-input-block">
                            <input type="text" name="text" value="" class="layui-input" lay-verify="required"
                                   autocomplete="off" lay-verType="tips">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">链接</label>
                        <div class="layui-input-block">
                            <input type="text" name="href" value="" class="layui-input" autocomplete="off">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">是否展开</label>
                        <div class="layui-input-block">
                            <select name="expanded">
                                <option value=""></option>
                                <option value="true">是</option>
                                <option value="false">否</option>
                            </select>
                        </div>
                    </div>
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
    var SAVEUPDATE = '<%=path%>/menu/create'

    layui.config({
        base: '<%=path%>/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'table', 'form', 'upload', 'element'], function () {
        var $ = layui.$
        var table = layui.table
        var form = layui.form
        var upload = layui.upload;
        var element = layui.element


        //监听提交--添加
        form.on('submit(submit)', function (data) {
            submit(data);
        });

        function submit(data) {
            //接口地址
            var url = SAVEUPDATE
            //获取提交的字段
            var field = data.field;
            $.ajax(
                {
                    type: 'post',
                    url: url,
                    data: field,
                    success: function (rs) {
                        if (rs.ok) {
                            parent.location.reload()
                        } else {
                            layer.msg(rs.msg)
                        }
                    }
                }
            )
        }

    })
</script>
</body>
</html>
