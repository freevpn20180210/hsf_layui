package com.lyf.common;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import okhttp3.*;
import org.springframework.util.MultiValueMap;
import org.springframework.util.ResourceUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.mail.Authenticator;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;

/**
 * 自定义工具类
 * 依赖okhttp3,fastjson,fileupload,javax.mail,spring-boot-starter-web
 * author:lyf
 * time:2019-09-03
 * time:2020-06-02
 */
public class LT {

    /**
     * 对象为空
     *
     * @param o 对象
     * @return boolean
     */
    public static boolean isEmpty(Object o) {
        return o == null || ("").equals(o);
    }

    /**
     * 对象非空
     *
     * @param o 对象
     * @return boolean
     */
    public static boolean isNotEmpty(Object o) {
        return !isEmpty(o);
    }

    /**
     * ajax返回json对象
     *
     * @param response
     * @param jo
     */
    public static void ajaxOutPutJson(HttpServletResponse response, JSONObject jo) {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        try {
            response.getWriter().print(jo.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * ajax返回json数组对象
     *
     * @param response
     * @param ja
     */
    public static void ajaxOutPutJsonArray(HttpServletResponse response, JSONArray ja) {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        try {
            response.getWriter().print(ja.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 发送get请求--OkHttp
     *
     * @param headerMap 发送的请求头键值对
     * @param url       目标接口地址
     * @return 请求结果
     */
    public static String get(Map<String, String> headerMap, String url) throws IOException {
        int time = 10;
        OkHttpClient client = new OkHttpClient.Builder().connectTimeout(time, TimeUnit.SECONDS).writeTimeout(time, TimeUnit.SECONDS)
                .readTimeout(time, TimeUnit.SECONDS)
                .build();

        //定义请求
        Request request = null;

        //如果没有请求头,直接创建请求
        if (mapEmpty(headerMap)) {
            request = new Request.Builder().url(url).get().build();
        } else {//如果有请求头,封装请求头,再创建请求
            Request.Builder reqestBuilder = new Request.Builder();
            for (Map.Entry<String, String> entry : headerMap.entrySet()) {
                reqestBuilder = reqestBuilder.addHeader(entry.getKey(), entry.getValue());
            }
            request = reqestBuilder.url(url).get().build();
        }
        Call call = client.newCall(request);
        try {
            //发送请求并返回结果
            return call.execute().body().string();
        } catch (IOException e) {
            throw new RuntimeException("连接超时!");
        }
    }

    /**
     * 发送post请求--OkHttp
     * 请求类型:application/json
     *
     * @param jo        发送的json
     * @param headerMap 发送的请求头键值对
     * @param url       目标接口地址
     * @return 请求结果
     */
    public static String postJson(JSONObject jo, Map<String, String> headerMap, String url) throws IOException {
        OkHttpClient client = new OkHttpClient.Builder()
                .connectTimeout(10, TimeUnit.SECONDS)
                .writeTimeout(10, TimeUnit.SECONDS)
                .readTimeout(10, TimeUnit.SECONDS)
                .build();

        //创建请求体
        RequestBody jsonBody = FormBody.create(MediaType.parse("application/json; charset=utf-8"), jo.toString());

        //定义请求
        Request request = null;

        //如果没有请求头,直接创建请求
        if (mapEmpty(headerMap)) {
            request = new Request.Builder().url(url).post(jsonBody).build();
        } else {//如果有请求头,封装请求头,再创建请求
            Request.Builder reqestBuilder = new Request.Builder();
            for (Map.Entry<String, String> entry : headerMap.entrySet()) {
                reqestBuilder = reqestBuilder.addHeader(entry.getKey(), entry.getValue());
            }
            request = reqestBuilder.url(url).post(jsonBody).build();
        }
        Call call = client.newCall(request);
        try {
            //发送请求并返回结果
            return call.execute().body().string();
        } catch (IOException e) {
            throw new RuntimeException("连接超时!");
        }
    }

    /**
     * 发送post请求--OkHttp
     * 请求类型:x-www-form-urlencoded(表单提交)
     *
     * @param formMap   发送的表单键值对
     * @param headerMap 发送的请求头键值对
     * @param url       目标接口地址
     * @return 请求结果
     */
    public static String postForm(Map<String, String> formMap, Map<String, String> headerMap, String url) throws IOException {
        OkHttpClient client = new OkHttpClient.Builder()
                .connectTimeout(10, TimeUnit.SECONDS)
                .writeTimeout(10, TimeUnit.SECONDS)
                .readTimeout(10, TimeUnit.SECONDS)
                .build();

        //封装请求体
        FormBody.Builder formBuilder = new FormBody.Builder();
        if (formMap != null) {
            formMap.forEach((k, v) -> {
                formBuilder.add(k, v);
            });
        }

        //创建请求体
        RequestBody formBody = formBuilder.build();

        //定义请求
        Request request = null;

        //如果没有请求头,直接创建请求
        if (mapEmpty(headerMap)) {
            request = new Request.Builder().url(url).post(formBody).build();
        } else {//如果有请求头,封装请求头,再创建请求
            Request.Builder reqestBuilder = new Request.Builder();
            for (Map.Entry<String, String> entry : headerMap.entrySet()) {
                reqestBuilder = reqestBuilder.addHeader(entry.getKey(), entry.getValue());
            }
            request = reqestBuilder.url(url).post(formBody).build();
        }
        Call call = client.newCall(request);
        try {
            //发送请求并返回结果
            return call.execute().body().string();
        } catch (IOException e) {
            throw new RuntimeException("连接超时!");
        }
    }

    /**
     * @param headerMap 发送的请求头键值对
     * @param url       目标接口地址
     * @return 请求结果
     * @throws IOException
     */
    public static String getReq(Map<String, String> headerMap, String url) throws IOException {
        OkHttpClient client = new OkHttpClient.Builder()
                .connectTimeout(10, TimeUnit.SECONDS)
                .writeTimeout(10, TimeUnit.SECONDS)
                .readTimeout(10, TimeUnit.SECONDS)
                .build();

        //定义请求
        Request request = null;

        //如果没有请求头,直接创建请求
        if (mapEmpty(headerMap)) {
            request = new Request.Builder().url(url).get().build();
        } else {//如果有请求头,封装请求头,再创建请求
            Request.Builder reqestBuilder = new Request.Builder();
            for (Map.Entry<String, String> entry : headerMap.entrySet()) {
                reqestBuilder = reqestBuilder.addHeader(entry.getKey(), entry.getValue());
            }
            request = reqestBuilder.url(url).get().build();
        }
        Call call = client.newCall(request);
        try {
            //发送请求并返回结果
            return call.execute().body().string();
        } catch (IOException e) {
            throw new RuntimeException("连接超时!");
        }
    }

    //获取当前时间--给文件上传用
    private static String getTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        return sdf.format(new Date());
    }

    /**
     * 多文件上传1
     * 更复杂,如果有多个上传框不必保证它们的name一致就能使多个上传框同时使用
     * 页面有几个上传框就视作几个上传框
     *
     * @param request
     * @param dir     输出目录
     * @return Map(fileName, size)  返回文件信息
     */
    public static Map multipartUpload1(HttpServletRequest request, String dir) {
        Map<String, String> fileInfoMap = new HashMap();
        //创建多文件解析器
        MultipartResolver resolver = new CommonsMultipartResolver(request.getSession().getServletContext());
        //检查form中的enctype是否是multipart/form-data
        if (resolver.isMultipart(request)) {
            //将request转为多文件request
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            //fileMap里k为这个上传框的name,v为这个上传框里的文件集合,v=List<MultipartFile>
            //如果前端只有一个上传框,fileMap只遍历一次
            //如果前端有多个上传框,name如果一样会把所有文件放进一个上传框来算,fileMap只遍历一次;name如果不一样,有几个上传框fileMap遍历几次
            MultiValueMap<String, MultipartFile> fileMap = multipartRequest.getMultiFileMap();
            if (mapEmpty(fileMap)) {
                return null;
            }
            //遍历所有input上传框
            fileMap.forEach((k, v) -> {
                //遍历文件集合
                v.forEach(file -> {
                    //保存路径为编译后的项目目录下的webapp目录下的x目录
                    //spring mvc的上传地址
                    //String path = request.getServletContext().getRealPath(dir);
                    String path = null;
                    try {
                        //spring boot的上传地址
                        path = ResourceUtils.getURL("classpath:META-INF/resources").getPath() + dir;
                        //如果保存路径不存在则创建相应目录
                        File target = new File(path);
                        if (!target.exists()) {
                            target.mkdirs();
                        }
                    } catch (FileNotFoundException e) {
                        e.printStackTrace();
                    }
                    //分割文件名
                    String[] fileNameSplit = file.getOriginalFilename().split("\\.");
                    //保存的文件名(原文件名_当前时间.类型)
                    String fileName = fileNameSplit[0] + "_" + getTime() + "." + fileNameSplit[1];
                    //文件大小
                    String size = String.valueOf(file.getSize() / 1024);
                    //返回文件信息
                    fileInfoMap.put(fileName, size);
                    try {
                        //保存文件
                        file.transferTo(new File(path + "/" + fileName));
                    } catch (IOException e) {
                        e.printStackTrace();
                        return;
                    }
                });
            });
            return fileInfoMap;
        } else {
            return null;
        }
    }

    /**
     * 多文件上传2
     * 更简洁,但是如果有多个上传框必须保证它们的name一致才能使多个上传框同时使用
     * 页面上无论有几个上传框都视作一个上传框
     *
     * @param files files为上传框的name.定义为数组是为了使上传框一次可以上传多个文件
     * @param dir   输出目录
     * @return JSONArray({ fileName, size } ...)  返回文件信息
     */
    public static JSONArray multipartUpload2(MultipartFile[] files, String dir) {
        if (LT.arrEmpty(files)) {
            return null;
        }
        JSONArray ja = new JSONArray();
        for (MultipartFile file : files) {
            JSONObject jo = new JSONObject(true);
            try {
                //得到文件上传路径
                Path directory = Paths.get(dir);
                if (!Files.exists(directory)) {
                    Files.createDirectories(directory);
                }

                //将原文件名(包括后缀名)倒转--以下写法是为了解决有的文件名中有N多个点导致保存问题的冲突
                StringBuilder sb = new StringBuilder();
                sb.append(file.getOriginalFilename());
                sb.reverse();
                //分割倒转后的文件名
                String[] fileNameSplit = sb.toString().split("\\.");
                //获得倒转后缀名
                String suffix_r = fileNameSplit[0];//gpj
                //获得不包括倒转后缀名的倒转文件名
                String fileName_r = sb.toString().substring(sb.toString().indexOf(suffix_r + ".") + (suffix_r + ".").length());
                //将倒转后缀名转正
                String suffix = new StringBuilder().append(suffix_r).reverse().toString();
                //将倒转文件名转正
                String fileName = new StringBuilder().append(fileName_r).reverse().toString();
                //保存的文件名(原文件名_当前时间.类型)
                String finalFileName = fileName + "_" + getTime() + "." + suffix;
                //文件大小
                String size = String.valueOf(file.getSize() / 1024);
                //返回文件信息
                jo.put("fileName", finalFileName);
                jo.put("size", size);
                //保存文件
                file.transferTo(new File(directory + "/" + finalFileName));
                ja.add(jo);
            } catch (Exception e) {
                e.printStackTrace();
                continue;
            }
        }
        return ja;
    }

    /**
     * 读取properties文件,getResourceAsStream("/")得到的是classpath的位置
     *
     * @param filePath
     * @return
     */
    public static Properties readProps(String filePath) {
        Properties props = new Properties();
        InputStream in = in = LT.class.getResourceAsStream(filePath);
        try {
            props.load(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return props;
    }

    /**
     * URL编码
     *
     * @param str
     * @return
     * @throws UnsupportedEncodingException
     */
    public static String getURLEncoderString(String str) {
        if (LT.isEmpty(str)) {
            return null;
        }
        try {
            return URLEncoder.encode(str, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * URL解码
     *
     * @param str
     * @return
     * @throws UnsupportedEncodingException
     */
    public static String getURLDecoderString(String str) {
        if (LT.isEmpty(str)) {
            return null;
        }
        try {
            return URLDecoder.decode(str, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * String转date--固定格式
     *
     * @param date
     * @return Date
     * @throws ParseException
     */
    public static Date parseDate(String date) throws ParseException {
        if (LT.isNotEmpty(date)) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            return sdf.parse(date);
        } else {
            return null;
        }
    }

    /**
     * String转date--自定义格式
     *
     * @param date
     * @param pattern
     * @return Date
     * @throws ParseException
     */
    public static Date parseDate(String date, String pattern) throws ParseException {
        if (LT.isNotEmpty(date)) {
            SimpleDateFormat sdf = new SimpleDateFormat(pattern);
            return sdf.parse(date);
        } else {
            return null;
        }
    }

    /**
     * date转String--固定格式
     *
     * @param date
     * @return String
     */
    public static String formatDate(Date date) {
        if (LT.isNotEmpty(date)) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            return sdf.format(date);
        } else {
            return null;
        }
    }

    /**
     * date转String--自定义格式
     *
     * @param date
     * @param pattern
     * @return String
     */
    public static String formatDate(Date date, String pattern) {
        if (LT.isNotEmpty(date)) {
            SimpleDateFormat sdf = new SimpleDateFormat(pattern);
            return sdf.format(date);
        } else {
            return null;
        }
    }

    /**
     * 格式化date返回date--固定格式
     *
     * @param date
     * @return Date
     * @throws ParseException
     */
    public static Date date2DateFormat(Date date) throws ParseException {
        return parseDate(formatDate(date));
    }

    /**
     * 格式化date返回date--自定义格式
     *
     * @param date
     * @param pattern
     * @return Date
     * @throws ParseException
     */
    public static Date date2DateFormat(Date date, String pattern) throws ParseException {
        return parseDate(formatDate(date, pattern), pattern);
    }

    /**
     * 数组转String,连接字符默认是逗号,带中括号
     *
     * @param arr
     * @return
     */
    public static String arr2Str(Object[] arr) {
        return Arrays.toString(arr);
    }

    /**
     * 数组转String,自定义连接字符,生成的数组元素带双引号,带中括号
     *
     * @param arr  数组
     * @param join 连接字符
     * @return String
     */
    public static String arr2Str(Object[] arr, String join) {
        if (arr == null)
            return null;

        int len = arr.length;
        if (len <= 0)
            return "[]";

        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; ; i++) {
            sb.append("\"");
            sb.append(String.valueOf(arr[i]));
            sb.append("\"");
            if (i == len - 1)
                return sb.append(']').toString();
            sb.append(join);
        }
    }

    /**
     * 数组转String,自定义连接字符,生成的数组元素不带双引号,带中括号
     *
     * @param arr  数组
     * @param join 连接字符
     * @return String
     */
    public static String arr2StrNoDQM(Object[] arr, String join) {
        if (arr == null)
            return null;

        int len = arr.length;
        if (len <= 0)
            return "[]";

        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; ; i++) {
            sb.append(String.valueOf(arr[i]));
            if (i == len - 1)
                return sb.append(']').toString();
            sb.append(join);
        }
    }

    /**
     * 数组转String,自定义连接字符,生成的数组元素带双引号,不带中括号
     *
     * @param arr
     * @param join
     * @return
     */
    public static String arr2StrNoBrackets(Object[] arr, String join) {
        if (arr == null)
            return null;

        int len = arr.length;
        if (len <= 0)
            return "";

        StringBuilder sb = new StringBuilder();
        for (int i = 0; ; i++) {
            sb.append("\"");
            sb.append(String.valueOf(arr[i]));
            sb.append("\"");
            if (i == len - 1)
                return sb.toString();
            sb.append(join);
        }
    }

    /**
     * 数组转String,自定义连接字符,生成的数组元素不带双引号,不带中括号
     *
     * @param arr
     * @param join
     * @return
     */
    public static String arr2StrNoDQMNoBrackets(Object[] arr, String join) {
        if (arr == null)
            return null;

        int len = arr.length;
        if (len <= 0)
            return "";

        StringBuilder sb = new StringBuilder();
        for (int i = 0; ; i++) {
            sb.append(String.valueOf(arr[i]));
            if (i == len - 1)
                return sb.toString();
            sb.append(join);
        }
    }

    /**
     * 数组转list,不使用Arrays.asList因为该方法转成的list无法进行add,remove等操作,因为它的长度等于数组长度,被限定了
     *
     * @param o
     * @return
     */
    public static List arr2List(Object[] o) {
        if (isEmpty(o)) {
            return null;
        }
        List list = new ArrayList();
        for (int i = 0; i < o.length; i++) {
            list.add(o[i]);
        }
        return list;
    }

    /**
     * String转String数组
     *
     * @param str    字符串
     * @param reggex 正则表达式 若有特殊字符,如\ | * : . ^ @ 应在前添加转义字符\\ 若特殊字符为\ 转义字符为\
     * @return String[]
     */
    public static String[] str2Arr(String str, String reggex) {
        return str.split(reggex);
    }

    /**
     * 数组为空
     *
     * @param o
     * @return boolean
     */
    public static boolean arrEmpty(Object[] o) {
        if (isEmpty(o)) {
            return true;
        }
        return o.length <= 0 ? true : false;
    }

    /**
     * 数组不为空
     *
     * @param o
     * @return boolean
     */
    public static boolean arrNotEmpty(Object[] o) {
        return !arrEmpty(o);
    }

    /**
     * list为空
     *
     * @param list
     * @return boolean
     */
    public static boolean listEmpty(List list) {
        if (isEmpty(list)) {
            return true;
        }
        return list.size() <= 0 ? true : false;
    }

    /**
     * list不为空
     *
     * @param list
     * @return boolean
     */
    public static boolean listNotEmpty(List list) {
        return !listEmpty(list);
    }

    /**
     * list转String数组
     *
     * @param list
     * @return
     */
    public static String[] list2StrArr(List list) {
        if (listEmpty(list)) {
            return null;
        }
        String[] strings = new String[list.size()];
        for (int i = 0; i < list.size(); i++) {
            strings[i] = String.valueOf(list.get(i));
        }
        return strings;
    }

    /**
     * list转String数组,使用set去重
     *
     * @param list
     * @return
     */
    public static String[] list2StrArrWithSet(List list) {
        if (listEmpty(list)) {
            return null;
        }
        Set<String> set = new HashSet<String>();
        list.forEach(po -> {
            set.add(String.valueOf(po));
        });
        return set.toArray(new String[set.size()]);
    }

    /**
     * list转String,数组元素带双引号,带中括号
     *
     * @param list
     * @return
     */
    public static String list2Str(List list) {
        if (listEmpty(list)) {
            return null;
        }
        return arr2Str(list2StrArr(list), ",");
    }

    /**
     * list转String,使用set去重,数组元素带双引号,带中括号
     *
     * @param list
     * @return
     */
    public static String list2StrWithSet(List list) {
        if (listEmpty(list)) {
            return null;
        }
        return arr2Str(list2StrArrWithSet(list), ",");
    }

    /**
     * list转String,数组元素不带双引号,带中括号
     *
     * @param list
     * @return
     */
    public static String list2StrNoDQM(List list) {
        if (listEmpty(list)) {
            return null;
        }
        return arr2StrNoDQM(list2StrArr(list), ",");
    }

    /**
     * list转String,使用set去重,数组元素不带双引号,带中括号
     *
     * @param list
     * @return
     */
    public static String list2StrWithSetNoDQM(List list) {
        if (listEmpty(list)) {
            return null;
        }
        return arr2StrNoDQM(list2StrArrWithSet(list), ",");
    }

    /**
     * list转String,数组元素带双引号,不带中括号
     *
     * @param list
     * @return
     */
    public static String list2StrNoBrackets(List list) {
        if (listEmpty(list)) {
            return null;
        }
        return arr2StrNoBrackets(list2StrArr(list), ",");
    }

    /**
     * list转String,使用set去重,数组元素带双引号,不带中括号
     *
     * @param list
     * @return
     */
    public static String list2StrWithSetNoBrackets(List list) {
        if (listEmpty(list)) {
            return null;
        }
        return arr2StrNoBrackets(list2StrArrWithSet(list), ",");
    }

    /**
     * list转String,数组元素不带双引号,不带中括号
     *
     * @param list
     * @return
     */
    public static String list2StrNoDQMNoBrackets(List list) {
        if (listEmpty(list)) {
            return null;
        }
        return arr2StrNoDQMNoBrackets(list2StrArr(list), ",");
    }

    /**
     * list转String,使用set去重,数组元素不带双引号,不带中括号
     *
     * @param list
     * @return
     */
    public static String list2StrWithSetNoDQMNoBrackets(List list) {
        if (listEmpty(list)) {
            return null;
        }
        return arr2StrNoDQMNoBrackets(list2StrArrWithSet(list), ",");
    }

    /**
     * map为空
     *
     * @param map
     * @return boolean
     */
    public static boolean mapEmpty(Map map) {
        if (isEmpty(map)) {
            return true;
        }
        return map.size() <= 0 ? true : false;
    }

    /**
     * map不为空
     *
     * @param map
     * @return boolean
     */
    public static boolean mapNotEmpty(Map map) {
        return !mapEmpty(map);
    }

    /**
     * set为空
     *
     * @param set
     * @return boolean
     */
    public static boolean setEmpty(Set set) {
        if (isEmpty(set)) {
            return true;
        }
        return set.size() <= 0 ? true : false;
    }

    /**
     * set不为空
     *
     * @param set
     * @return boolean
     */
    public static boolean setNotEmpty(Set set) {
        return !setEmpty(set);
    }

    /**
     * 移动文件到另一个目录
     *
     * @param request
     * @param oldFileName   原文件名
     * @param targetDirName 目标目录
     * @return 原文件名
     */
    public static String mvFile2OtherDir(HttpServletRequest request, String oldFileName, String targetDirName) {
        File file = new File(request.getServletContext().getRealPath(oldFileName));
        File targetDir = new File(request.getServletContext().getRealPath(targetDirName));
        if (!targetDir.exists()) {
            targetDir.mkdirs();
        }
        File targetFile = new File(request.getServletContext().getRealPath(targetDirName) + "/" + file.getName());
        file.renameTo(targetFile);
        return file.getName();
    }

    /**
     * 删除文件
     *
     * @param filePath 文件相对路径
     * @return 是否删除
     */
    public static boolean deleteFile(String filePath) {
        boolean result = false;
        //得到文件删除路径
        Path directory = Paths.get(filePath);
        File file = new File(directory.toString());
        if (file.exists()) {
            file.delete();
            result = true;
        }
        return result;
    }

    /**
     * java mail发送邮件
     *
     * @param to      收件人
     * @param subject 标题
     * @param content 正文
     * @return
     */
    public static boolean sendEmail(String to, String subject, String content) {
        //1.设置发送地址
        Properties props = new Properties();
        props.setProperty("mail.host", "smtp.qq.com");
        props.setProperty("mail.smtp.auth", "true");

        //2.设置发件人权限,userName为qq号,password为授权码
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("704799339", "vyiwsbylpujzbcgg");
            }
        };

        //3.创建session
        Session session = Session.getInstance(props, auth);

        //4.创建MimeMessage
        MimeMessage msg = new MimeMessage(session);

        try {
            //5.设置发件人
            msg.setFrom(new InternetAddress("704799339@qq.com"));
            //6.设置收件人
            msg.setRecipients(MimeMessage.RecipientType.TO, to);
            //7.设置标题
            msg.setSubject(subject);
            //8.设置正文
            msg.setContent(content, "text/html;charset=utf-8");
            // msg.setRecipients(RecipientType.CC, "xxxxxx@sohu.com");//设置抄送
            //msg.setRecipients(RecipientType.BCC, "xxxxxx@sina.com");//设置暗送
            // 9.发送
            Transport.send(msg);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 生成指定区间的随机小数
     *
     * @param min
     * @param max
     * @return
     */
    public static double RandomDecimal(double min, double max) {
        //最大数左边的整数部分
        int maxLeft = (int) max;
        //最大数右边的小数部分
        double maxRight = max - maxLeft;

        //最小数左边的整数部分
        int minLeft = (int) min;
        //最小数右边的小数部分
        double minRight = min - minLeft;

        Random random = new Random();
        //生成数的小数部分最小值是0,最大值是1*(max - min)(不包括)
        double rsRight = random.nextDouble() * (max - min);

        double rs = min + rsRight;
        return rs;
    }

    /**
     * 返回两个数组中不同的元素
     *
     * @param t1
     * @param t2
     * @return
     */
    public static List arrCompare(Object[] t1, Object[] t2) {
        List list1 = Arrays.asList(t1);
        List list2 = Arrays.asList(t2);
        List diff = new ArrayList();
        for (Object o : t2) {
            if (!list1.contains(o)) {
                diff.add(o);
            }
        }
        for (Object o : t1) {
            if (!list2.contains(o)) {
                diff.add(o);
            }
        }
        return diff;
    }

    /**
     * 返回两个List中不同的元素
     *
     * @param t1
     * @param t2
     * @return
     */
    public static List arrCompare(List t1, List t2) {
        List diff = new ArrayList();
        for (Object o : t2) {
            if (!t1.contains(o)) {
                diff.add(o);
            }
        }
        for (Object o : t1) {
            if (!t2.contains(o)) {
                diff.add(o);
            }
        }
        return diff;
    }

    /**
     * 返回距今多少天的那天的日期
     *
     * @param amout   要距离今天几天,0为不距离,输出的就是今天
     * @param pattern 时间格式化表达式
     * @return
     */
    public static String getDateFromToday(int amout, String pattern) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.add(Calendar.DATE, -amout);
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        return sdf.format(cal.getTime());
    }

    /**
     * 根据当前时间,返回json格式的时间详细信息
     *
     * @return
     */
    public static JSONObject getDateInfoOfToday() {
        //假设今天是2020年6月3号的1点18分
        Calendar cal = Calendar.getInstance();
        //年 2020
        int year = cal.get(Calendar.YEAR);
        //月 6
        int month = cal.get(Calendar.MONTH) + 1;
        //日 3
        int day = cal.get(Calendar.DATE);
        //时 1
        int hour = cal.get(Calendar.HOUR_OF_DAY);

        //这周是今年的第几周 23
        int week_of_year = cal.get(Calendar.WEEK_OF_YEAR);
        //这周是这月的第几周 1
        int week_of_month = cal.get(Calendar.WEEK_OF_MONTH);
        //今天是今年的第几天 155
        int day_of_year = cal.get(Calendar.DAY_OF_YEAR);
        //今天是这月的第几天 3
        int day_of_month = cal.get(Calendar.DAY_OF_MONTH);
        //今天是这个周的第几天 4 对应(1,2,3,4,5,6,7)
        int day_of_week = cal.get(Calendar.DAY_OF_WEEK);
        String[] arrs = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
        String day_of_week_format = arrs[day_of_week - 1];
        //今天的周几是本月的第几个周几 今天周三,是本月的第一个周三
        int day_of_week_in_month = cal.get(Calendar.DAY_OF_WEEK_IN_MONTH);

        JSONObject rs = new JSONObject(true);
        rs.put("year", year);
        rs.put("month", month);
        rs.put("day", day);
        rs.put("hour", hour);
        rs.put("week_of_year", week_of_year);
        rs.put("week_of_month", week_of_month);
        rs.put("day_of_year", day_of_year);
        rs.put("day_of_month", day_of_month);
        rs.put("day_of_week", day_of_week);
        rs.put("day_of_week_format", day_of_week_format);
        rs.put("day_of_week_in_month", day_of_week_in_month);
        return rs;
    }

    /**
     * 不丢失精度的加法运算
     *
     * @param m1
     * @param m2
     * @return
     */
    public static double addDouble(double m1, double m2) {
        BigDecimal p1 = new BigDecimal(Double.toString(m1));
        BigDecimal p2 = new BigDecimal(Double.toString(m2));
        return p1.add(p2).doubleValue();
    }

    /**
     * 不丢失精度的减法运算
     *
     * @param m1
     * @param m2
     * @return
     */
    public static double subDouble(double m1, double m2) {
        BigDecimal p1 = new BigDecimal(Double.toString(m1));
        BigDecimal p2 = new BigDecimal(Double.toString(m2));
        return p1.subtract(p2).doubleValue();
    }

    /**
     * 不丢失精度的乘法运算
     *
     * @param m1
     * @param m2
     * @return
     */
    public static double mul(double m1, double m2) {
        BigDecimal p1 = new BigDecimal(Double.toString(m1));
        BigDecimal p2 = new BigDecimal(Double.toString(m2));
        return p1.multiply(p2).doubleValue();
    }


    /**
     * 不丢失精度的除法运算
     *
     * @param m1
     * @param m2
     * @param scale 保留几位
     * @return
     */
    public static double div(double m1, double m2, int scale) {
        if (scale < 0) {
            throw new IllegalArgumentException("Parameter error");
        }
        BigDecimal p1 = new BigDecimal(Double.toString(m1));
        BigDecimal p2 = new BigDecimal(Double.toString(m2));
        return p1.divide(p2, scale, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    public static void main(String[] args) {
//        System.out.println(RandomDecimal(28.770999, 29.256168));
//        String time = getDateFromToday(0, "yyyy-MM-dd HH:mm:ss");
//        System.out.println(time);
    }


}
