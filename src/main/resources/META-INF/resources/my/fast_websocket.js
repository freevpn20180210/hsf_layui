var fast_websocket = {
    init: function (host, port, path) {
        if (typeof (WebSocket) == "undefined") {
            console.log("您的浏览器不支持WebSocket")
        } else {
            var socket = new WebSocket('ws://' + host + ':' + port + path);

            //连接成功时触发
            socket.onopen = function () {
                console.log("连接成功");
            },

                //连接失败时触发
                socket.onerror = function () {
                    console.log("连接失败");
                },
                //连接关闭时触发
                socket.onclose = function () {
                    console.log("连接关闭");
                }
            return socket
        }
    }
}
