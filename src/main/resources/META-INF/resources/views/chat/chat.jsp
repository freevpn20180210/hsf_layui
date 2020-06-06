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
    <meta content="webkit" name="renderer">
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0"
          name="viewport">
    <link href="<%=path%>/layuiadmin/layui/css/layui.css" media="all" rel="stylesheet">
    <link href="<%=path%>/layuiadmin/style/admin.css" media="all" rel="stylesheet">
    <style>
        @media screen and (max-width: 800px) {
            body {
                background-color: lightblue;
            }
        }

        div.chat {
            text-align: center;
            background-color: rgba(129, 86, 255, 0.35);
            margin: 0 auto;
            border: 1px solid #000;
            width: 50vh;
        }

        div.chat > textarea {
            width: 50vh;
            height: 60vh;

        }
    </style>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body">
                    <div class="chat">
                        <br>欢迎来到极简聊天室<br/><br/>
                        <textarea id="content" readonly="readonly" style="font-size: 15px;"></textarea><br>
                        <div style=" margin-top: 20px">
                            用户：<input type="text" id="user" autocomplete="off">
                            <button onclick="joinRoom()" id="joinRoom">加入群聊</button>
                            <button onclick="exitRoom()" id="exitRoom">退出群聊</button>
                            <br/><br/>
                            说点啥: <input type="text" id="msg" autocomplete="off" disabled>
                            <button id="sendMsg" onclick="sendMsg()" disabled>发送消息</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var url = "ws://" + location.host + "/chat/";
    var ws = null;

    //加入聊天室
    function joinRoom() {
        if (ws) {
            alert("你已经在聊天室，不能再加入");
            return;
        }
        var username = document.getElementById("user").value;
        if (username == '') {
            alert('请填写用户名再加入群聊')
            return;
        }
        ws = new WebSocket(url + username);
        //连接成功时触发
        ws.onopen = function () {
            console.log("连接成功")
            document.getElementById("msg").disabled = false
            document.getElementById("sendMsg").disabled = false
            document.getElementById("joinRoom").disabled = true
            document.getElementById("exitRoom").disabled = false
            document.getElementById("msg").focus()

        };
        //连接失败时触发
        ws.onerror = function () {
            alert('连接失败')
        };
        //连接关闭时触发
        ws.onclose = function () {
            console.log("连接关闭");
        };
        //收到服务端消息时触发,用户发送消息,服务器收到消息并返回
        ws.onmessage = function (rs) {
            document.getElementById("content").append(rs.data + "\r\n");
        };
    }

    //退出聊天室
    function exitRoom() {
        if (ws) {
            ws.close();
            ws = null;
            document.getElementById("msg").disabled = true
            document.getElementById("sendMsg").disabled = true
            document.getElementById("joinRoom").disabled = false
            document.getElementById("exitRoom").disabled = true
        }
    }

    //发送消息
    function sendMsg() {
        if (ws) {
            if (document.getElementById("msg").value != '') {
                ws.send(document.getElementById("msg").value);
                document.getElementById("msg").value = "";
            }
        }
    }

    //回车发送消息
    document.onkeydown = function (e) {
        var theEvent = window.event || e;
        var code = theEvent.keyCode || theEvent.which || theEvent.charCode;
        if (code == 13) {
            sendMsg();
            document.getElementById("msg").focus()
        }
    }

</script>
</body>
</html>