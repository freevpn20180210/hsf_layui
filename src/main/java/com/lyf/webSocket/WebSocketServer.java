package com.lyf.webSocket;

import com.lyf.common.LT;
import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 极简聊天室类
 * author:lyf
 * 20200605
 */
@ServerEndpoint("/chat/{username}")
@Component
public class WebSocketServer {
    //客户端与服务端建立连接-->服务端向各个客户端发送消息(谁加入了群聊)-->客户端向服务端发送消息-->服务端把该消息发送给各个已经连接的客户端
    @Getter
    @Setter
    //简单测试用，真正的场景请考虑线程安全的容器或其它并发解决方案
    private static List<Session> sessions = new ArrayList<>();

    /**
     * 连接成功时触发
     */
    @OnOpen
    public void onOpen(Session session, @PathParam("username") String username) {
        sessions.add(session);
        sendMsg(LT.formatDate(new Date()) + "\r\n" + "[" + username + "] 加入了群聊" + "\r\n");
    }

    /**
     * 发生错误时触发
     */
    @OnError
    public void onError(Session session, Throwable error) {
        error.printStackTrace();
    }

    /**
     * 连接关闭时触发
     */
    @OnClose
    public void onClose(Session session, @PathParam("username") String username) {
        sessions.remove(session);
        sendMsg(LT.formatDate(new Date()) + "\r\n" + "[" + username + "] 退出了群聊" + "\r\n");
    }

    /**
     * 收到客户端消息时触发
     */
    @OnMessage
    public void onMessage(String msg, @PathParam("username") String username) {
        sendMsg(LT.formatDate(new Date()) + "\r\n" + username + "说:" + msg + "\r\n");
    }

    //向每个客户端同时发送消息
    private void sendMsg(String msg) {
        for (Session session : sessions) {
            session.getAsyncRemote().sendText(msg);
        }
    }
}
