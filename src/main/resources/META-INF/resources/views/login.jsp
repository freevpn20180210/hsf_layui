<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="icon" href="<%=path%>/my/img/yasuo.ico"/>
    <link rel="stylesheet" media="screen" href="<%=path%>/my/login/style.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/my/login/reset.css"/>
</head>
<body style="padding: 0px">

<div id="particles-js">
    <div class="login">
        <div class="login-1"
             style="font-size: 30px;font-family:方正粗黑宋简体;margin-top: 30px;box-sizing:border-box;
             color: #333;text-align: center">
            欢迎使用
        </div>
        <div class="login-3"
             style="font-size: 24px;font-family:楷体;margin-top: 30px;margin-bottom:30px;box-sizing:border-box;
             color: #333;text-align: center">
            自娱自乐平台
        </div>
        <div class="login-center clearfix">
            <div class="login-center-img"><img src="<%=path%>/my/login/name.png"/></div>
            <div class="login-center-input">
                <input type="text" name="name" value="test1" placeholder="请输入您的用户名" onfocus="this.placeholder=''"
                       onblur="this.placeholder='请输入您的用户名'" autocomplete="off"/>
                <div class="login-center-input-text">用户名</div>
            </div>
        </div>
        <div class="login-center clearfix">
            <div class="login-center-img"><img src="<%=path%>/my/login/password.png"/></div>
            <div class="login-center-input">
                <input type="password" name="pwd" value="test1" placeholder="请输入您的密码" onfocus="this.placeholder=''"
                       onblur="this.placeholder='请输入您的密码'"/>
                <div class="login-center-input-text">密码</div>
            </div>
        </div>
        <div class="login-center clearfix">
            <div class="login-center-img"><img src="<%=path%>/my/login/verifyCode.png"/></div>
            <div class="login-center-input">
                <input type="text" name="verifyCode" value="" placeholder="请输入验证码" onfocus="this.placeholder=''"
                       onblur="this.placeholder='请输入验证码'" autocomplete="off"/>
                <div style="padding-top: 20px;margin-left: 20px">
                    <img id='verifyCodeImg' src="<%=path%>/getKaptcha" onclick="this.src='<%=path%>/getKaptcha'"
                         style="cursor:pointer;float: left;"/>
                    <div style="float: left;padding-left: 30px;margin-top: 5px">
                        <label for="rememberMe">记住我</label>
                        <input id='rememberMe' type="checkbox" name="rememberMe"/>
                    </div>
                </div>
                <div class="login-center-input-text">验证码</div>
            </div>
        </div>
        <div class="login-button">
            登陆
        </div>
        <div style="text-align: center;margin-top: 5px">
            <a href="<%=path%>/views/sys/user/forget.jsp"><span style="color:blue">忘记密码?</span></a>
        </div>
    </div>
    <div class="sk-rotating-plane"></div>
</div>

<script src="<%=path%>/my/jquery-1.8.3.min.js"></script>
<script src="<%=path%>/my/login/particles.min.js"></script>
<script src="<%=path%>/my/login/app.js"></script>
<script src="<%=path%>/layuiadmin/layui/layui.js"></script>
<script src="<%=path%>/my/fast.js"></script>

<script type="text/javascript">

    function hasClass(elem, cls) {
        cls = cls || '';
        if (cls.replace(/\s/g, '').length == 0) return false; //当cls没有参数时，返回false
        return new RegExp(' ' + cls + ' ').test(' ' + elem.className + ' ');
    }

    function addClass(ele, cls) {
        if (!hasClass(ele, cls)) {
            ele.className = ele.className == '' ? cls : ele.className + ' ' + cls;
        }
    }

    function removeClass(ele, cls) {
        if (hasClass(ele, cls)) {
            var newClass = ' ' + ele.className.replace(/[\t\r\n]/g, '') + ' ';
            while (newClass.indexOf(' ' + cls + ' ') >= 0) {
                newClass = newClass.replace(' ' + cls + ' ', ' ');
            }
            ele.className = newClass.replace(/^\s+|\s+$/g, '');
        }
    }

    /*********************************************************************************************************/
    $(function () {
        //避免在iframe里出现登录页面
        if (self != top) {
            top.location.reload()
        }
        //移动焦点至用户名
        $('input[name=name]').focus()

        //如果发生对象的keydown事件,表示已经获得该对象的焦点
        //当用户名按回车,焦点移至密码
        $('input[name=name]').keydown(function (e) {
            if (e.keyCode == 13) {
                $('input[name=pwd]').focus()
            }
        })
        //当密码按回车,焦点移至验证码
        $('input[name=pwd]').keydown(function (e) {
            if (e.keyCode == 13) {
                $('input[name=verifyCode]').focus()
            }
        })
        //当验证码按回车,登录
        $('input[name=verifyCode]').keydown(function (e) {
            if (e.keyCode == 13) {
                login()
            }
        })
        //点击登录按钮,登录
        $(".login-button").click(function () {
            login()
        })

    })

    //登录
    function login() {
        layui.config({
            base: '<%=path%>/layuiadmin/' //静态资源所在路径
        }).extend({
            index: 'lib/index' //主入口模块
        }).use(['index', 'table'], function () {
            var $ = layui.$

            var name = $('input[name=name]').val()
            var pwd = $('input[name=pwd]').val()
            var verifyCode = $('input[name=verifyCode]').val()
            var rememberMe = $('input[name=rememberMe]')[0].checked

            if (name && pwd) {
                if (verifyCode) {
                    //启用加载动画
                    addClass(document.querySelector(".sk-rotating-plane"), "active")
                    document.querySelector(".login").style.display = "none"

                    //从第三方接口获取登录信息
                    $.post('<%=path%>/juhe/guest', (data) => {
                        var ip = data.ip;
                        var cname = data.position.city;
                        var time = dateFtt("yyyy-MM-dd HH:mm:ss", new Date());
                        var browser = whatBrowser()
                        var dev = isPC() ? '电脑' : '手机'
                        //登录
                        $.ajax(
                            {
                                url: '<%=path%>/userLogin',
                                data: {
                                    verifyCode: verifyCode,
                                    name: name,
                                    pwd: pwd,
                                    ip: ip,
                                    cname: cname,
                                    time: time,
                                    browser: browser,
                                    dev: dev,
                                    rememberMe: rememberMe,
                                },
                                async: false,
                                type: 'post',
                                success: function (rs) {
                                    if (rs.ok) {
                                        //进入首页
                                        location.href = '<%=path%>/'
                                    } else {
                                        //移除加载动画
                                        removeClass(document.querySelector(".sk-rotating-plane"), "active")
                                        document.querySelector(".login").style.display = "block"
                                        //刷新验证码
                                        $('#verifyCodeImg')[0].src = '<%=path%>/getKaptcha'
                                        layer.msg(rs.msg)
                                        $('input[name=verifyCode]').val('')
                                        $('input[name=verifyCode]').focus()
                                    }
                                },
                                error: function () {
                                    //移除加载动画
                                    removeClass(document.querySelector(".sk-rotating-plane"), "active")
                                    document.querySelector(".login").style.display = "block"
                                    layer.msg("服务器出错！");
                                }
                            })
                    })
                } else {
                    layer.msg('请输入验证码')
                }
            } else {
                layer.msg('用户名或密码不能为空')
            }
        })

    }

</script>
</body>
</html>
