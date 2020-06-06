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
                    <div class="layui-form" lay-filter="form">

                        <input type="hidden" name="id">
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
                                <button type="button" class="layui-btn layui-btn-normal layui-btn-sm" id="upload">
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
                            <label class="layui-form-label">用户名<span style="color: red;">*</span></label>
                            <div class="layui-input-inline">
                                <input type="text" name="name" value="" class="layui-input" autocomplete="off"
                                       lay-verify="required||minLength" lay-verType="tips">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">密码<span style="color: red;">*</span></label>
                            <div class="layui-input-inline">
                                <input type="password" name="pwd" value="" class="layui-input" autocomplete="off"
                                       lay-verify="required||minLength" lay-verType="tips">
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
                                <input type="radio" name="sex" value="男" title="男" checked>
                                <input type="radio" name="sex" value="女" title="女">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">手机<span style="color: red;">*</span></label>
                            <div class="layui-input-inline">
                                <input type="text" name="phone" value="" lay-verify="phone" autocomplete="off"
                                       class="layui-input" lay-verType="tips">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">邮箱</label>
                            <div class="layui-input-inline">
                                <input type="text" name="mail" value="" autocomplete="off" lay-verify="mail"
                                       class="layui-input" lay-verType="tips">
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

                        <div class="layui-form-item layui-hide">
                            <input type="button" lay-submit lay-filter="save" id="save">
                            <input type="button" lay-submit lay-filter="update" id="update">
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
    var SAVEUPDATE = '<%=path%>/user/saveUpdate'

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

        //自定义表单验证
        form.verify({
            minLength: function (value) {
                if (value.length < 5) {
                    return "长度必须大于5位"
                }
            },
            mail: function (value) {
                //可以为空,有值才去验证
                if (value) {
                    //邮箱的正则表达式
                    var pattern = /\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/
                    var test = pattern.test(value)
                    if (!test) {
                        return '邮箱格式不正确'
                    }
                }
            }
        })

        //监听提交--添加
        form.on('submit(save)', function (data) {
            submit(data);
        });

        //监听提交--修改
        form.on('submit(update)', function (data) {
            submit(data);
        });

        function submit(data) {
            //接口地址
            var url = SAVEUPDATE
            //获取提交的字段
            var field = data.field

            $.ajax(
                {
                    type: 'post',
                    url: url,
                    data: field,
                    success: function (rs) {
                        if (rs.ok) {
                            parent.layui.table.reload('table'); //重载表格
                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                            parent.layer.close(index); //再执行关闭
                        } else {
                            layer.msg(rs.msg)
                        }
                    }
                }
            )
        }

        //上传头像
        layuiUploadPic($, upload, element, '#upload', '<%=path%>/user/picUpload',
            'img', 'input[name=pic]', 'div[class=layui-progress')

    });
</script>
</body>
</html>
