<%@ page language="java" pageEncoding="UTF-8" %>
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

</head>
<body class="layui-layout-body">

<div id="LAY_app">
    <div class="layui-layout layui-layout-admin">
        <div class="layui-header">
            <!-- 头部区域 -->
            <ul class="layui-nav layui-layout-left">
                <li class="layui-nav-item layadmin-flexible" lay-unselect>
                    <a href="javascript:;" layadmin-event="flexible" title="侧边伸缩">
                        <i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a href="http://www.layui.com/admin/" target="_blank" title="前台">
                        <i class="layui-icon layui-icon-website"></i>
                    </a>
                </li>
                <li class="layui-nav-item" lay-unselect>
                    <a href="javascript:;" layadmin-event="refresh" title="刷新">
                        <i class="layui-icon layui-icon-refresh-3"></i>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <input type="text" placeholder="搜索..." autocomplete="off" class="layui-input layui-input-search"
                           layadmin-event="serach" lay-action="template/search.html?keywords=">
                </li>
            </ul>
            <ul class="layui-nav layui-layout-right" lay-filter="layadmin-layout-right">
                <li class="layui-nav-item" lay-unselect>
                    <a lay-href="app/message/index.html" layadmin-event="message" lay-text="消息中心">
                        <i class="layui-icon layui-icon-notice"></i>
                        <!-- 如果有新消息，则显示小圆点 -->
                        <span class="layui-badge-dot"></span>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a href="javascript:;" layadmin-event="theme">
                        <i class="layui-icon layui-icon-theme"></i>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a href="javascript:;" layadmin-event="note">
                        <i class="layui-icon layui-icon-note"></i>
                    </a>
                </li>
                <li class="layui-nav-item layui-hide-xs" lay-unselect>
                    <a href="javascript:;" layadmin-event="fullscreen">
                        <i class="layui-icon layui-icon-screen-full"></i>
                    </a>
                </li>
                <li class="layui-nav-item" lay-unselect>
                    <a href="javascript:;">
                        <cite>
                            <img width="30" height="30" src="<%=basePath%>${po.pic}"
                                 onerror="this.src='<%=basePath%>my/img/staff.png'">
                            ${po.name}
                        </cite>
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a lay-href="<%=path%>/userInfo/getUser?userId=${po.id}">基本资料</a></dd>
                        <dd><a lay-href="<%=path%>/views/sys/user/info/password.jsp">修改密码</a></dd>
                        <hr>
                        <dd id="logout" style="text-align: center;"><a>退出</a></dd>
                    </dl>
                </li>

                //版本信息
                <%--  <li class="layui-nav-item layui-hide-xs" lay-unselect>
                      <a href="javascript:;" layadmin-event="about"><i
                              class="layui-icon layui-icon-more-vertical"></i></a>
                  </li>
                  <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-unselect>
                      <a href="javascript:;" layadmin-event="more"><i class="layui-icon layui-icon-more-vertical"></i></a>
                  </li>--%>
            </ul>
        </div>

        <!-- 侧边菜单 -->
        <div class="layui-side layui-side-menu">
            <div class="layui-side-scroll">
                <div class="layui-logo" lay-href="" onclick="top.location.reload()">
                    <h3>首&nbsp&nbsp&nbsp&nbsp页</h3>
                </div>

                <!--后台返回的json格式的菜单-->
                <script type="text/html" template lay-url="<%=path%>/getIndexMenu?v={{ layui.admin.v }}"
                        lay-done="layui.element.render('nav', 'layadmin-system-side-menu');" id="TPL_layout">
                    <div lay-templateid="TPL_layout">
                        <ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu"
                            lay-filter="layadmin-system-side-menu">
                            {{#
                            var dataName = layui.setter.response.dataName ? layui.setter.response.dataName : 'data';
                            layui.each(d[dataName], function(index,item){
                            }}
                            <li class="layui-nav-item {{ item.spread ? typeof item.list === 'object' && item.list.length > 0 ? 'layui-nav-itemed' : 'layui-this': '' }}"
                                myDir="1">
                                {{# if(item.url){ }}
                                <a lay-href="{{ item.url }}" lay-tips="{{ item.title }}" lay-direction="2">
                                    {{# }else{ }}
                                    <a href="javascript:;" lay-tips="{{ item.title }}" lay-direction="2">
                                        {{# } }}
                                        {{# if(item.icon){ }}
                                        <i class="layui-icon {{ item.icon }}"></i>
                                        {{# } }}
                                        <cite>{{ item.title }}</cite>
                                    </a>
                                    {{#
                                    var itemListFun = function(itemList, myDir){
                                    myDir = myDir || 2;
                                    if(typeof itemList === 'object' && itemList.length > 0){ }}
                                    <dl class="layui-nav-child">
                                        {{# layui.each(itemList, function(index2, item2){ }}
                                        <dd data-name="{{ item2.name || '' }}"
                                            class="{{ item2.spread ? (typeof item2.list === 'object' && item2.list.length > 0 ? 'layui-nav-itemed' : 'layui-this' ) : ''}}"
                                            myDir="{{ myDir }}">
                                            {{# if(item2.icon){ }}
                                            <i class="layui-icon {{ item.icon }}"></i>
                                            {{# } }}
                                            {{# if(item2.url){ }}
                                            <a lay-href="{{ item2.url }}">{{ item2.title }}</a>
                                            {{# }else{ }}
                                            <a href="javascript:;">{{ item2.title }}</a>
                                            {{# } }}
                                            {{# itemListFun(item2.list,myDir+1);}}
                                        </dd>
                                        {{# }) }}
                                    </dl>
                                    {{# } }}
                                    {{# };
                                    itemListFun(item.list); }}
                            </li>
                            {{# }) }}
                        </ul>
                    </div>
                </script>

            </div>
        </div>

        <!-- 页面标签 -->
        <div class="layadmin-pagetabs" id="LAY_app_tabs">
            <div class="layui-icon layadmin-tabs-control layui-icon-prev" layadmin-event="leftPage"></div>
            <div class="layui-icon layadmin-tabs-control layui-icon-next" layadmin-event="rightPage"></div>
            <div class="layui-icon layadmin-tabs-control layui-icon-down">
                <ul class="layui-nav layadmin-tabs-select" lay-filter="layadmin-pagetabs-nav">
                    <li class="layui-nav-item" lay-unselect>
                        <a href="javascript:;"></a>
                        <dl class="layui-nav-child layui-anim-fadein">
                            <dd layadmin-event="closeThisTabs"><a href="javascript:;">关闭当前标签页</a></dd>
                            <dd layadmin-event="closeOtherTabs"><a href="javascript:;">关闭其它标签页</a></dd>
                            <dd layadmin-event="closeAllTabs"><a href="javascript:;">关闭全部标签页</a></dd>
                        </dl>
                    </li>
                </ul>
            </div>
            <div class="layui-tab" lay-unauto lay-allowClose="true" lay-filter="layadmin-layout-tabs">
                <ul class="layui-tab-title" id="LAY_app_tabsheader">
                    <li lay-id="home/console.html" lay-attr="home/console.html" class="layui-this"><i
                            class="layui-icon layui-icon-home"></i></li>
                </ul>
            </div>
        </div>

        <!-- 主体内容 -->
        <div class="layui-body" id="LAY_app_body">
            <div class="layadmin-tabsbody-item layui-show">
                <iframe src="<%=path%>/views/myConsole.jsp" frameborder="0"
                        class="layadmin-iframe"></iframe>
            </div>
        </div>

        <!-- 辅助元素，一般用于移动设备下遮罩 -->
        <div class="layadmin-body-shade" layadmin-event="shade"></div>
    </div>
</div>

<script src="<%=path%>/layuiadmin/layui/layui.js"></script>
<script>
    layui.config({
        base: '<%=path%>/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use('index', function () {
        var $ = layui.$

        //设置左侧菜单树的颜色
        //#20222A:树的背景色
        //#009688:点击后菜单项的背景色
        //#20222A:logo的背景色
        //#2D93CA:鼠标悬浮在菜单项的背景色
        $('#LAY_layadmin_theme').html('.layui-side-menu,.layadmin-pagetabs .layui-tab-title li:after,.layadmin-pagetabs .layui-tab-title li.layui-this:after,.layui-layer-admin .layui-layer-title,.layadmin-side-shrink .layui-side-menu .layui-nav>.layui-nav-item>.layui-nav-child{background-color:#20222A !important;}' +
            '.layui-nav-tree .layui-this,.layui-nav-tree .layui-this>a,.layui-nav-tree .layui-nav-child dd.layui-this,.layui-nav-tree .layui-nav-child dd.layui-this a{background-color:#009688 !important;}' +
            '.layui-layout-admin .layui-logo{background-color:#20222A !important;}' +
            '.layui-nav-tree>li:hover{background-color:#2D93CA}'
        )

        $('#logout').on('click', function () {
            layer.confirm('确定退出吗?', function (index) {
                $.post('<%=path%>/userLogout', function (rs) {
                    if (rs.ok) {
                        top.location.href = '<%=path%>/views/login.jsp'
                    }
                })
            })
        })
    })
</script>

</body>
</html>


