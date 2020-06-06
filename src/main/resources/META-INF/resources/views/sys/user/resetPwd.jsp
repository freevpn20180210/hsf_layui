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
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="<%=path%>/layuiadmin/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="<%=path%>/layuiadmin/style/admin.css" media="all">
    <link rel="stylesheet" href="<%=path%>/layuiadmin/style/login.css" media="all">
</head>

<div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">
    <div class="layadmin-user-login-main">
        <div class="layadmin-user-login-box layadmin-user-login-header">
            <h2>找回密码</h2>
            <p></p>
        </div>
        <div class="layadmin-user-login-box layadmin-user-login-body layui-form">

            <input value="${param.name}" name="name" hidden>
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-password"
                       for="newPwd"></label>
                <input type="password" name="newPwd" id="newPwd" lay-verify="required||minLength"
                       placeholder="新密码" class="layui-input">
            </div>
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-password"
                       for="rePwd"></label>
                <input type="password" name="rePwd" id="rePwd" lay-verify="required||minLength"
                       placeholder="确认密码" class="layui-input">
            </div>
            <div class="layui-form-item">
                <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="resetPwd">重置新密码
                </button>
            </div>

        </div>
    </div>

</div>

<script src="<%=path%>/layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '<%=path%>/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'user'], function () {
        var $ = layui.$
        var form = layui.form

        form.render();

        //自定义表单验证
        form.verify({
            minLength: function (value) {
                if (value.length < 5) {
                    return "密码长度必须大于5位"
                }
            }

        })

        //重置密码
        form.on('submit(resetPwd)', function (obj) {
            var field = obj.field;

            //确认密码
            if (field.newPwd !== field.rePwd) {
                return layer.msg('两次密码输入不一致');
            }

            $.ajax(
                {
                    type: 'post',
                    url: '<%=path%>/forget/resetPwd',
                    data: field,
                    success: function (rs) {
                        if (rs.ok) {
                            layer.msg('密码已成功重置', {
                                offset: '15px',
                                icon: 1,
                                time: 1000
                            }, function () {
                                location.href = '<%=path%>/views/login.jsp'
                            })
                        } else {
                            layer.msg(rs.msg)
                        }
                    }
                })

            return false
        })

    });
</script>
</body>
</html>