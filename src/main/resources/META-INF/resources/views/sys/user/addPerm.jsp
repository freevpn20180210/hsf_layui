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
    <link href="<%=path%>/layuiadmin/lib/extend/dtree/dtree.css" media="all" rel="stylesheet">
    <link href="<%=path%>/layuiadmin/lib/extend/dtree/font/dtreefont.css" media="all" rel="stylesheet">
</head>
<body>

<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card-body">
                <div class="layui-form" lay-filter="form">
                    <ul id="dtree" class="dtree" data-id="0"></ul>
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
    }).use(['index', 'table', 'form', 'upload', 'element', 'dtree'], function () {
        var $ = layui.$
        var table = layui.table
        var form = layui.form
        var upload = layui.upload;
        var element = layui.element

        //第三方树形组件,位于layuiadmin->lib->extend->dtree.js
        var dtree = layui.dtree;

        var index = layer.load()

        var DTreeNode = dtree.render({
            elem: '#dtree',
            url: '<%=path%>/user/listPerm',
            success: function (res, $obj, first) {
                layer.close(index)
            },
            skin: "layui",
            checkbar: true,
            checkbarType: "all", // 默认就是all，其他的值为： no-all  p-casc   self  only
            menubar: true,
            menubarTips: {
                group: ["moveDown", "moveUp", "refresh", "checkAll", "unCheckAll"]
            },
            done: function (res, $ul, first) {
                $.post('<%=path%>/user/getPermIdByRoleId', {id: '${param.id}'}, function (rs) {
                    //初始化选中复选框
                    var params = dtree.chooseDataInit("dtree", rs.toString());
                    //监听提交
                    form.on('submit(submit)', function (data) {
                        //获取选中复选框的节点值
                        var data = dtree.getCheckbarNodesParam("dtree");
                        //勾选的id数组
                        var ids = []
                        $.each(data, function (i, v) {
                            //减0是为了返回number类型而不是string
                            ids.push(v.nodeId - 0)
                        })
                        $.ajax(
                            {
                                type: 'post',
                                url: "<%=path%>/user/addPerm",
                                data: {id: '${param.id}', permissionIds: ids.toString()},
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
                    })
                })

            }
        })


    });

</script>
</body>
</html>
