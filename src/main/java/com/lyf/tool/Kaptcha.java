package com.lyf.tool;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;

/**
 * 生成Kaptcha验证码类
 * author:lyf
 * 20200605
 */
@Component
public class Kaptcha {

    @Autowired
    DefaultKaptcha defaultKaptcha;

    //使用kaptcha生成验证码字符串,并把验证码图片输出到浏览器
    public void GenerateKaptcha(HttpServletRequest request, HttpServletResponse response) throws Exception {

        //图片输出流
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        //生成验证码字符串
        String createText = defaultKaptcha.createText();
        //将生成的验证码字符串保存到session中
        request.getSession().setAttribute("verifyCode", createText);

        //根据该验证码生成一张图片
        BufferedImage bufferedImage = defaultKaptcha.createImage(createText);
        //把图片写入到输出流
        ImageIO.write(bufferedImage, "jpg", byteArrayOutputStream);

        //图片输出流->图片字节数组
        byte[] jpg = byteArrayOutputStream.toByteArray();

        //设置response
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("image/jpeg");

        //将二进制数据输入到浏览器
        ServletOutputStream servletOutputStream = response.getOutputStream();
        servletOutputStream.write(jpg);
        servletOutputStream.flush();
        servletOutputStream.close();

    }
}
