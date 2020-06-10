package com.lyf.config;

import com.alibaba.fastjson.support.config.FastJsonConfig;
import com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter;
import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.boot.web.server.ErrorPage;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.boot.web.servlet.server.ConfigurableServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.core.Ordered;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

/**
 * springboot核心配置类
 * author:lyf
 * 20200605
 */
@SpringBootConfiguration
public class MainConfig implements WebMvcConfigurer, WebServerFactoryCustomizer<ConfigurableServletWebServerFactory> {

    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        //创建fastJson消息转换器
        FastJsonHttpMessageConverter fastJsonHttpMessageConverter = new FastJsonHttpMessageConverter();

        List<MediaType> medias = new ArrayList<>();
        medias.add(MediaType.TEXT_HTML);
        medias.add(MediaType.APPLICATION_JSON_UTF8);
        fastJsonHttpMessageConverter.setSupportedMediaTypes(medias);

        FastJsonConfig fastJsonConfig = new FastJsonConfig();
        fastJsonConfig.setDateFormat("yyyy-MM-dd HH:mm:ss");
        fastJsonHttpMessageConverter.setFastJsonConfig(fastJsonConfig);

        //将fastjson添加到消息转换器列表
        converters.add(fastJsonHttpMessageConverter);
    }

    //页面跳转
    //spring boot欢迎页
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
//        registry.addViewController("/").setViewName("/index");
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
        WebMvcConfigurer.super.addViewControllers(registry);

    }

    // spring boot错误页
    @Override
    public void customize(ConfigurableServletWebServerFactory factory) {
        factory.addErrorPages(new ErrorPage(HttpStatus.NOT_FOUND, "/views/404.jsp"));
    }

    // 多文件上传
    @Bean
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
        //限制上传大小为30MB
//        multipartResolver.setMaxUploadSize(31457280);
        multipartResolver.setDefaultEncoding("utf-8");
        return multipartResolver;
    }

    // kaptcha验证码
    @Bean
    public DefaultKaptcha defaultKaptcha() {
        DefaultKaptcha defaultKaptcha = new DefaultKaptcha();
        Properties properties = new Properties();
        properties.setProperty("kaptcha.border", "yes");
        properties.setProperty("kaptcha.border.color", "30,144,255");
        //文本颜色
        properties.setProperty("kaptcha.textproducer.font.color", "blue");
        //文本大小
        properties.setProperty("kaptcha.textproducer.font.size", "32");
        //文本长度
        properties.setProperty("kaptcha.textproducer.char.length", "4");
        //文本字体样式
        properties.setProperty("kaptcha.textproducer.font.names", "Arial, Courier");
        //文本间隔
        properties.setProperty("kaptcha.textproducer.char.space", "6");
        //图片宽度
        properties.setProperty("kaptcha.image.width", "120");
        //图片高度
        properties.setProperty("kaptcha.image.height", "50");
        //图片样式
        /*
        水纹com.google.code.kaptcha.impl.WaterRipple(默认,相当丑)
        鱼眼com.google.code.kaptcha.impl.FishEyeGimpy(太花了)
        阴影com.google.code.kaptcha.impl.ShadowGimpy(还可以)
         */
        properties.setProperty("kaptcha.obscurificator.impl", "com.google.code.kaptcha.impl.ShadowGimpy");
        //去干扰线
        properties.setProperty("kaptcha.noise.impl", "com.google.code.kaptcha.impl.NoNoise");
        Config config = new Config(properties);
        defaultKaptcha.setConfig(config);
        return defaultKaptcha;
    }

    //WebSocket配置,在打包成war包时要注释,否则websocket不可用
    @Bean
    public ServerEndpointExporter serverEndpointExporter() {
        return new ServerEndpointExporter();
    }

    //自定义资源映射
    //若为jar包运行,对新建的外部文件夹进行注册,使以jar包的方式运行能读取和写入资源
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        //只拦截以File开头的url,若为/**,则拦截所有的url,会导致静态资源无法访问
        registry.addResourceHandler("/File/**")
                .addResourceLocations("file:File/");
    }

}
