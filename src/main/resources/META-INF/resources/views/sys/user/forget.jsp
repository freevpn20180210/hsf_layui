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
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-username"
                       for="name"></label>
                <input type="text" name="name" id="name" lay-verify="required"
                       placeholder="请输入注册时的用户名" class="layui-input">
            </div>
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-email"
                       for="mail"></label>
                <input type="text" name="mail" id="mail" lay-verify="email"
                       placeholder="请输入注册时的邮箱" class="layui-input">
            </div>
            <div class="layui-form-item">
                <div class="layui-row">
                    <div class="layui-col-xs7">
                        <label class="layadmin-user-login-icon layui-icon layui-icon-vercode"
                               for="verifyCode"></label>
                        <input type="text" name="verifyCode" id="verifyCode" lay-verify="required"
                               placeholder="图形验证码" class="layui-input">
                    </div>
                    <div class="layui-col-xs5">
                        <div style="margin-left: 10px;">
                            <img src="<%=path%>/getKaptcha" onclick="this.src='<%=path%>/getKaptcha'"
                                 class="layadmin-user-login-codeimg">
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-row">
                    <div class="layui-col-xs7">
                        <label class="layadmin-user-login-icon layui-icon layui-icon-vercode"
                               for="code"></label>
                        <input type="text" name="code" id="code" lay-verify="required"
                               placeholder="邮箱验证码" class="layui-input">
                    </div>
                    <div class="layui-col-xs5">
                        <div style="margin-left: 10px;">
                            <button type="button" class="layui-btn layui-btn-primary layui-btn-fluid"
                                    id="getCodeBtn">获取邮箱验证码
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="find">找回密码
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

        //根据用户名查询是否有该用户
        var name = $('#name')
        name.on('blur', function () {
            if (name.val()) {
                $.ajax(
                    {
                        type: 'post',
                        url: '<%=path%>/forget/isUserExist',
                        data: {name: name.val()},
                        success: function (rs) {
                            if (rs.ok) {
                                nameOK = true
                            } else {
                                nameOK = false;
                                layer.msg(rs.msg)
                            }
                        }
                    }
                )
            }
        })

        //根据用户名和邮箱,查询该用户绑定的邮箱是否验证
        var mail = $('#mail')
        mail.on('blur', function () {
            if (name.val() && mail.val()) {
                //邮箱的正则表达式
                var pattern = /\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/
                var test = pattern.test(mail.val())
                if (test) {
                    $.ajax(
                        {
                            type: 'post',
                            url: '<%=path%>/forget/isMailVerify',
                            data: {
                                name: name.val(),
                                mail: mail.val()
                            },
                            success: function (rs) {
                                if (rs.ok) {
                                    mailOk = true
                                } else {
                                    mailOk = false;
                                    layer.msg(rs.msg)
                                }
                            }
                        }
                    )
                } else {
                    layer.msg('邮箱格式不正确')
                }
            } else {
                layer.msg('请把用户名和邮箱都输入完整')
            }
        })

        //验证图形验证码
        var verifyCode = $('#verifyCode')
        verifyCode.on('blur', function () {
            if (name.val() && mail.val() && verifyCode.val()) {
                $.ajax(
                    {
                        type: 'post',
                        url: '<%=path%>/forget/verifyCode',
                        data: {
                            verifyCode: verifyCode.val(),
                        },
                        success: function (rs) {
                            if (rs.ok) {
                                verifyCodeOk = true
                            } else {
                                verifyCodeOk = false
                                layer.msg(rs.msg)
                            }
                        }
                    }
                )
            } else {
            }
        })

        //发送邮箱验证码
        var getCodeBtn = $('#getCodeBtn')
        codeOk = false
        getCodeBtn.click(function () {
            if (name.val() && mail.val() && verifyCode.val()) {
                if (nameOK && mailOk && verifyCodeOk) {
                    //弹出加载layer
                    var index = layer.load()
                    $.post('<%=path%>/forget/sendCode', {mail: mail.val()}, function (rs) {
                        if (rs.ok) {
                            codeOk = true
                            //禁用邮箱输入框
                            mail.attr('disabled', 'disabled')
                            layer.msg('验证码已发送至你的邮箱,请查收')
                            layer.close(index)
                            //60秒内禁止再次发送
                            getCodeBtn.addClass('layui-btn-disabled')
                            getCodeBtn.attr('disabled', true)
                            var time = 60
                            interval = setInterval(function () {
                                if (time > 0) {
                                    time--
                                    getCodeBtn.text('重新发送:' + time + '秒后')
                                } else {
                                    clearInterval(interval)
                                    getCodeBtn.removeClass('layui-btn-disabled')
                                    getCodeBtn.attr('disabled', false)
                                    getCodeBtn.text('获取邮箱验证码')
                                }
                            }, 1000)
                        } else {
                            codeOk = false
                            layer.msg(rs.msg)
                        }
                    })
                }
            }

        })

        //验证邮箱验证码
        form.on('submit(find)', function (obj) {
            var field = obj.field

            if (nameOK && mailOk && verifyCodeOk && codeOk) {
                $.ajax(
                    {
                        type: 'post',
                        url: '<%=path%>/forget/verifyMailCode',
                        data: {code: $('#code').val()},
                        success: function (rs) {
                            if (rs.ok) {
                                location.href = '<%=path%>/forget/toResetPwd?name=' + name.val()
                            } else {
                                layer.msg(rs.msg)
                            }
                        }
                    }
                )
            }
            return false;
        })

    });
</script>
</body>
</html>