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
                    <div class="layui-form" lay-filter="form">
                        <input type="hidden" name="id">
                        <input type="hidden" name="pwd">
                        <input type="hidden" name="pic">
                        <input type="hidden" name="mailVerified">
                        <input type="hidden" name="locked">
                        <input type="hidden" name="createTime">
                        <input type="hidden" name="updateTime">

                        <div class="layui-form-item">
                            <label class="layui-form-label">头像</label>
                            <div class="layui-input-inline">
                                <img width="50" height="50" src="<%=basePath%>${po.pic}"
                                     onerror="this.src='<%=basePath%>/my/img/staff.png'">
                                <button class="layui-btn layui-btn-normal layui-btn-sm" id="upload">
                                    <i class="layui-icon layui-icon-upload"></i>上传头像
                                </button>
                                <div class="layui-progress" lay-showpercent="true" style="margin-top: 5px;display: none"
                                     lay-filter="progress">
                                    <div class="layui-progress-bar" lay-percent="0%"></div>
                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">我的角色</label>
                            <div class="layui-input-inline">
                                <input type="text" name="roleName" value="" class="layui-input" disabled>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">用户名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="name" value="" class="layui-input" autocomplete="off" disabled>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">昵称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="nickname" value="" class="layui-input" autocomplete="off">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">真实姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="realname" value="" class="layui-input" autocomplete="off">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">性别</label>
                            <div class="layui-input-inline">
                                <input type="radio" name="sex" value="男" title="男">
                                <input type="radio" name="sex" value="女" title="女">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">手机<span style="color: red;">*</span></label>
                            <div class="layui-input-inline">
                                <input type="text" name="phone" value="" lay-verify="phone" autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">邮箱</label>
                            <div class="layui-input-inline">
                                <input type="text" name="mail" value="" autocomplete="off"
                                       class="layui-input">
                                <button class="layui-btn layui-btn-radius layui-btn-xs layui-btn-danger"
                                        id='isVerifyBtn'
                                        style="display: none;margin-top: 5px"></button>
                            </div>
                        </div>

                        <div class="layui-form-item" id="codeDiv" style="display: none;">
                            <label class="layui-form-label">验证码<span style="color: red;">*</span></label>
                            <div class="layui-input-inline">
                                <input type="text" name="code" autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">地址</label>
                            <div class="layui-input-inline">
                                <input type="text" name="address" value="" class="layui-input" autocomplete="off">
                            </div>
                        </div>

                        <div class="layui-form-item layui-form-text">
                            <label class="layui-form-label">备注</label>
                            <div class="layui-input-block">
                                <textarea name="remark" class="layui-textarea"></textarea>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button class="layui-btn" lay-submit lay-filter="update" id="update">确认修改</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<%=path%>/layuiadmin/layui/layui.js"></script>
<script src="<%=path%>/my/fast.js"></script>
<script>
    var SAVEUPDATE = '<%=path%>/userInfo/saveUpdate'

    layui.config({
        base: '<%=path%>/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'table', 'form', 'upload', 'element'], function () {
        var $ = layui.$
        var form = layui.form
        var upload = layui.upload;
        var element = layui.element

        //进入该页面时为表单赋值
        form.val('form', {
            'roleName': '${roleName}',
            'id': '${po.id}',
            'name': '${po.name}',
            'pwd': '${po.pwd}',
            'nickname': '${po.nickname}',
            'realname': '${po.realname}',
            'pic': '${po.pic}',
            'sex': '${po.sex}',
            'phone': '${po.phone}',
            'mail': '${po.mail}',
            'mailVerified': '${po.mailVerified}',
            'address': '${po.address}',
            'remark': '${po.remark}',
            'locked': '${po.locked}',
            'createTime': '${po.createTime}',
            'updateTime': '${po.updateTime}',
        })

        //是否可以提交表单
        var canSubmit = true
        //不能提交的提示
        var tip

        //监听提交--修改
        form.on('submit(update)', function (data) {
            //接口地址
            var url = SAVEUPDATE
            //获取提交的字段
            var field = data.field

            if (canSubmit) {
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
            } else {
                layer.msg(tip)
            }
        })

        //上传头像
        layuiUploadPic($, upload, element, '#upload', '<%=path%>/userInfo/picUpload',
            'img', 'input[name=pic]', 'div[class=layui-progress')

//*************************************************邮箱业务Start*************************************************//
        //邮箱:①绑定->②验证
        var mail = $('input[name=mail]')
        //邮箱是否被验证的按钮
        var isVerifyBtn = $('#isVerifyBtn')

        //如果用户已经绑定了邮箱
        if ('${po.mail}') {
            //显示邮箱是否被验证的按钮
            $('#isVerifyBtn').show()
            //如果邮箱没有验证,点击验证
            if ('${po.mailVerified}' == '' || '${po.mailVerified}' == 'false') {
                isVerifyBtn.text("点击验证")
                isVerifyBtn.on('click', function () {
                    //弹出加载layer
                    var index = layer.load()
                    $.post('<%=path%>/userInfo/sendCode', {mail: mail.val()}, function (rs) {
                        if (rs.ok) {
                            canSubmit = true
                            //禁用邮箱输入框
                            mail.attr('disabled', 'disabled')
                            layer.msg('验证码已发送至你的邮箱,请查收')
                            layer.close(index)
                            //显示验证码输入框
                            $('#codeDiv').show()
                            $('input[name=code]').attr('lay-verify', 'required')
                            //60秒内禁止再次发送
                            isVerifyBtn.addClass('layui-btn-disabled')
                            isVerifyBtn.attr('disabled', true)
                            var time = 60
                            interval = setInterval(function () {
                                if (time > 0) {
                                    time--
                                    isVerifyBtn.text('重新发送:' + time + '秒后')
                                } else {
                                    clearInterval(interval)
                                    isVerifyBtn.removeClass('layui-btn-disabled')
                                    isVerifyBtn.attr('disabled', false)
                                    isVerifyBtn.text('点击验证')
                                }
                            }, 1000)
                        } else {
                            canSubmit = false
                            layer.msg(rs.msg)
                        }
                    })
                })
            } else {//如果邮箱已被验证,显示已验证
                isVerifyBtn.text('已验证')
                isVerifyBtn.removeClass('layui-btn-danger')
            }
        }

        //当邮箱失去焦点,有值且符合格式,判断邮箱是否被其他用户绑定
        mail.on('blur', function () {
            if (mail.val()) {
                //邮箱的正则表达式
                var pattern = /\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/
                var test = pattern.test(mail.val())
                if (test) {
                    $.ajax(
                        {
                            url: '<%=path%>/userInfo/isBlindByOthers',
                            data: {mail: mail.val()},
                            success: function (rs) {
                                if (rs.ok) {
                                    canSubmit = true
                                } else {
                                    canSubmit = false
                                    tip = rs.msg
                                    layer.msg(rs.msg)
                                }
                            }
                        }
                    )
                } else {
                    canSubmit = false
                    tip = '邮箱格式不正确'
                    layer.msg('邮箱格式不正确')
                }
                //如果邮箱已被验证,说明已被绑定,如果想换邮箱,说明输入的邮箱和绑定的邮箱不同,
                //满足这两个条件,就隐藏邮箱是否被验证的按钮,不发送验证码
                if ('${po.mailVerified}' == 'true' && mail.val() != '${po.mail}') {
                    isVerifyBtn.hide()
                }
            } else {
                isVerifyBtn.hide()
            }
        })
//*************************************************邮箱业务End*************************************************//

    })
</script>
</body>
</html>
