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
                <div class="layui-card-body" pad15>
                    <div class="layui-form">

                        <div class="layui-form-item">
                            <label class="layui-form-label">当前密码<span style="color: red">*</span></label>
                            <div class="layui-input-inline">
                                <input type="password" name="oldPwd" lay-verify="required"
                                       lay-verType="tips"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">新密码<span style="color: red">*</span></label>
                            <div class="layui-input-inline">
                                <input type="password" name="newPwd" lay-verify="required||minLength"
                                       lay-verType="tips"
                                       autocomplete="off"
                                       id="newPwd" class="layui-input">
                            </div>
                            <div class="layui-form-mid layui-word-aux">5个字符以上</div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">确认新密码<span style="color: red">*</span></label>
                            <div class="layui-input-inline">
                                <input type="password" name="rePwd" lay-verify="required||minLength||rePwd"
                                       lay-verType="tips"
                                       autocomplete="off"
                                       id="rePwd" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button class="layui-btn" lay-submit lay-filter="update">确认修改</button>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="<%=path%>/layuiadmin/layui/layui.js"></script>
<script>
    var SAVEUPDATE = '<%=path%>/userInfo/updatePwd'

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

        /**
         * required (必填项)
         phone（手机号）
         email（邮箱）
         url（网址）
         number（数字）
         date（日期）
         identity(身份证)
         */
        //自定义表单验证
        form.verify({
            minLength: function (value) {
                if (value.length < 5) {
                    return "密码长度必须大于5位"
                }
            },
            rePwd: function (v) {
                var newPwd = $('#newPwd').val()
                if (v != newPwd) {
                    return "两次输入的密码不一致"
                }
            }

        })

        //监听提交
        form.on('submit(update)', function (data) {
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
                            layer.msg("修改成功")
                            setTimeout(function () {
                                top.location.reload()
                            }, 1000)
                        } else {
                            layer.msg(rs.msg)
                        }
                    }
                }
            )
        })

    })
</script>
</body>
</html>
