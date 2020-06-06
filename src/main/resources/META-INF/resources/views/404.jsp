<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title></title>
</head>
<style type="text/css">
    * {
        margin: 0;
        padding: 0;
    }

    body {
        background-color: #f8f8f8;
        -webkit-font-smoothing: antialiased;
    }

    .error {
        position: absolute;
        left: 50%;
        top: 50%;
        width: 483px;
        margin: -300px 0 0 -242px;
        padding-top: 199px;
        font-size: 18px;
        color: #666;
        text-align: center;
        background: #f8f8f8 url(<%=path%>/my/img/404.jpg) 0 0 no-repeat;
    }

    .error .remind {
        margin: 30px 0;
    }

    .error .button {
        display: inline-block;
        padding: 0 20px;
        line-height: 40px;
        font-size: 14px;
        color: #fff;
        background-color: #f8912d;
        text-decoration: none;
    }

    .error .button:hover {
        opacity: .9;
    }
</style>

<body>

<div class="error">
    <p class="remind">您访问的页面不存在，请返回主页！</p>
    <p><a class="button" href="<%=path%>/">返回主页</a></p>
</div>

<script>
    //判断当前页面时否是顶层页面
    var a = document.getElementsByTagName('a')[0]
    //如果当前页是顶层页面
    if (self == top) {
        //跳转到自己
        a.target = '_self'
    } else {
        //跳转到顶层页面
        a.target = '_top'
    }
</script>
</body>
</html>
