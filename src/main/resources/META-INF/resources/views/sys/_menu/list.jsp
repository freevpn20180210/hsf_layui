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
    <div class="layui-row layui-col-space5">
        <div class="layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-header" style="text-align: center;">
                    <button type="button" class="layui-btn layui-btn-sm layui-btn-radius" id="add">
                        添加根节点
                    </button>
                </div>
                <div class="layui-card-body">
                    <div class="layui-form" lay-filter="form">
                        <div class="layui-form-item">
                            <ul id="dtree" class="dtree" data-id="0"></ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-col-md9" id="updatePage">
            <div class="layui-card">
                <div class="layui-card-header layui-bg-blue" style="text-align: center"><h3>选项</h3>
                </div>
                <div class="layui-card-body">
                    <div class="layui-form" lay-filter="form">
                        <div class="layui-form-item">
                            <label class="layui-form-label">id</label>
                            <div class="layui-input-block">
                                <input type="text" name="id" value="" class="layui-input" disabled autocomplete="off">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">父节点</label>
                            <div class="layui-input-block">
                                <ul id="selTree1" class="dtree" data-id="0"></ul>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">菜单名</label>
                            <div class="layui-input-block">
                                <input type="text" name="text" value="" class="layui-input" autocomplete="off">
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
                        <div class="layui-form-item">
                            <label class="layui-form-label">排序<span style="color: red">*</span></label>
                            <div class="layui-input-block">
                                <input type="text" name="orderIndex" value="" class="layui-input" lay-verify="number"
                                       autocomplete="off">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">创建时间</label>
                            <div class="layui-input-block">
                                <input type="text" name="createTime" value="" class="layui-input" readonly
                                       autocomplete="off">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">修改时间</label>
                            <div class="layui-input-block">
                                <input type="text" name="updateTime" value="" class="layui-input" readonly
                                       autocomplete="off">
                            </div>
                        </div>
                        <div class="layui-form-item" style="text-align: center">
                            <button type="button" class="layui-btn layui-btn-sm layui-btn-radius" lay-submit
                                    lay-filter="submit" id="submit" style="display: none">
                                确认修改
                            </button>
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
    layui.config({
        base: '<%=path%>/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'table', 'form', 'upload', 'element', 'util', 'dtree'], function () {
        var $ = layui.$
        var table = layui.table
        var form = layui.form
        var upload = layui.upload;
        var element = layui.element
        var util = layui.util

        //第三方树形组件,位于layuiadmin->lib->extend->dtree.js
        var dtree = layui.dtree;

        var index = layer.load()

        var DTreeNode = dtree.render({
            elem: '#dtree',
            url: '<%=path%>/menu/list',
            success: function (res, $obj, first) {
                $('#add').click(function () {
                    layuiNewWindow_normalSubmit('添加', '<%=path%>/views/sys/_menu/saveUpdate.jsp', '600px', '500px')
                })
                layer.close(index)
            },
            skin: "layui",
            checkbar: true,
            checkbarType: "p-casc", // 默认就是all，其他的值为： no-all  p-casc   self  only
            menubar: true,
            menubarFun: {
                remove: function (checkbarNodes) { // 必须将该方法实现了，节点才会真正的从后台删除哦
                    var ids = []
                    $.each(checkbarNodes, function (i, v) {
                        ids.push(v.nodeId)
                    })
                    $.post('<%=path%>/menu/del', {ids: ids.toString()}, function (rs) {
                        if (rs.ok) {
                            myRefresh()
                        } else {
                            layer.msg(rs.msg)
                        }
                    })
                    return true//确认是否真的删除节点
                }
            },
            toolbar: true,
            toolbarShow: ["add", "delete"],
            toolbarFun: {
                addTreeNode: function (treeNode, $div) {
                    $.ajax({
                        type: "post",
                        data: JSON.stringify(treeNode),
                        url: "<%=path%>/menu/save",
                        contentType: 'application/json',
                        success: function (rs) {
                            if (rs.ok) {
                                DTreeNode.changeTreeNodeAdd(rs.id)
                                myRefresh()
                            } else {
                                layer.msg(rs.msg)
                            }
                        },
                    });
                },
                delTreeNode: function (treeNode, $div) {
                    $.ajax({
                        type: "post",
                        data: {ids: treeNode.nodeId},
                        url: "<%=path%>/menu/del",
                        success: function (rs) {
                            if (rs.ok) {
                                DTreeNode.changeTreeNodeDel(true)
                                myRefresh()
                            } else {
                                layer.msg(rs.msg)
                            }
                        },
                    });
                }
            },
        })

        //节点单击事件
        dtree.on("node('dtree')", function (obj) {
            var param = obj.param

            //获取节点信息
            $.post('<%=path%>/menu/getInfoById', {id: param.nodeId}, function (rs) {
                var po = rs.po
                $('#submit').show()
                form.val('form', {
                    'id': po.id,
                    'parentId': po.parentId,
                    'text': po.text,
                    'href': po.href,
                    'expanded': po.expanded + '',
                    'orderIndex': po.orderIndex,
                    'createTime': po.createTime,
                    'updateTime': po.updateTime,
                })
                $('#selTree1').attr('data-value', po.parentId)
                //重新加载下拉树
                dtree.reload("selTree1", {
                    url: "<%=path%>/menu/list",
                    selectTips: "无"
                });
                //监听提交--修改
                form.on('submit(submit)', function (data) {
                    submit(data);
                });

                function submit(data) {
                    var url = '<%=path%>/menu/update'
                    var field = data.field;
                    $.ajax(
                        {
                            type: 'post',
                            url: url,
                            data: field,
                            success: function (rs) {
                                if (rs.ok) {
                                    layer.msg('修改成功')
                                    if ($('input[name=parentId]').val() != po.parentId) {
                                        $('i[class="dtreefont dtree-icon-refresh"]').click()
                                    }
                                    if (param.level >= 2) {
                                        $('i[class="dtreefont dtree-icon-refresh"]').click()
                                    }
                                    myRefresh()
                                } else {
                                    layer.msg(rs.msg)
                                }
                            }
                        }
                    )
                }
            })
        });

        //节点双击事件
        dtree.on("nodedblclick('dtree')", function (obj) {
            var param = obj.param
            //单击展开或收缩节点
            if (!obj.param.leaf) {
                var $div = obj.dom;
                DTreeNode.clickSpread($div);
            }
        })

        //下拉树
        dtree.renderSelect({
            elem: "#selTree1",
            width: "100%",
            url: "<%=path%>/menu/list",
            selectInputName: {//选择完放入内部表单标签的键值对,值为表单的name
                nodeId: "parentId",
            },
            skin: "layui",
        });

        //增删改后的自定义刷新
        function myRefresh() {
            $('#submit').hide()
            form.val('form', {
                'id': '',
                'parentId': '',
                'text': '',
                'href': '',
                'expanded': '',
                'orderIndex': '',
                'createTime': '',
                'updateTime': '',
            })
            $('#selTree1').attr('data-value', 0)
            //重新加载下拉树
            dtree.reload("selTree1", {
                url: "<%=path%>/menu/list",
                selectTips: "无"
            });
        }

    });

</script>
</body>
</html>
