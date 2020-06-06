package com.lyf.task;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lyf.common.LT;
import com.lyf.common.SupperDao;
import com.lyf.po.api.Oil;
import com.lyf.po.api.Toh;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 自定义定时任务类
 * author:lyf
 * 20200605
 */
@Component
@EnableScheduling
public class MyTask implements SchedulingConfigurer {

    @Autowired
    SupperDao dao;

    //时间表达式格式:秒,分,时,日,月,周
    //举例说明
    //例1：每隔5秒执行一次：*/5 * * * * ?
    //
    //例2：每隔5分执行一次：0 */5 * * * ?
    //
    //例3：每天半夜12点30分执行一次：0 30 0 * * ? （注意日期域为0不是24）
    //         每天凌晨1点执行一次：0 0 1 * * ?
    //         每天10：15执行一次： 0 15 10 * * ?
    //         每天中午十二点执行一次：0 0 12 * * ?
    //         每天14点到14：59分，每1分钟执行一次：0 * 14 * * ?
    //         每天14点到14：05分，每1分钟执行一次：0 0-5 14 * * ?
    //         每天14点到14：55分，每5分钟执行一次：0 0/5 14 * * ?
    //         每天14点到14：55分，和18点到18点55分，每5分钟执行一次：0 0/5 14,18 * * ?
    //         每天18点、22点执行一次：0 0 18,22 * * ?
    //         每天7点到23点，每整点执行一次：0 0 7-23 * * ?
    //         每个整点执行一次：0 0 0/1 * * ?
    //
    //例4：每月1号凌晨1点执行一次：0 0 1 1 * ?
    //         每月15号的10点15分执行一次：0 15 10 15 * ?
    //         每月的最后一天的10：15执行一次：0 15 10 L * ?
    //
    //例5：每月最后一天23点执行一次：0 0 23 L * ?
    //
    //例6：每周星期天凌晨1点执行一次：0 0 1 ? * L
    //         三月的每周三的14：10和14：44执行一次：0 10,44 14 ? 3 WED
    //         每个周一、周二、周三、周四、周五的10：15执行一次：0 15 10 ? * MON-FRI
    //         每月最后一个周五的10：15执行一次：0 15 10 ? * 6L
    //
    //﻿
    //例7：2016年的每天早上10：15执行一次: 0 15 10 * * ? 2016


    //每天0点15分执行一次
    private String cron = "0 15 0 * * ?";

    @Override
    public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
        taskRegistrar.addTriggerTask(() -> {
                    try {
                        saveTodayOil();
                        saveToh();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }, triggerContext -> {
                    return new CronTrigger(cron).nextExecutionTime(triggerContext);
                }
        );
    }

    //保存今日国内各省油价
    public void saveTodayOil() throws IOException {
        String url = "http://apis.juhe.cn/gnyj/query?key=bace1d535d49320ec3e0953cd48b5dd8";
        String body = LT.postForm(null, null, url);
        JSONArray ja = JSON.parseObject(body).getJSONArray("result");
        for (Object o : ja) {
            JSONObject jo = (JSONObject) o;
            String city = jo.getString("city");
            String a = jo.getString("0h");
            String b = jo.getString("92h");
            String c = jo.getString("95h");
            String d = jo.getString("98h");
            Oil oil = new Oil();
            oil.setCity(city);
            oil.setA(a);
            oil.setB(b);
            oil.setC(c);
            oil.setD(d);
            oil.setCreateTime(new Timestamp(new Date().getTime()));
            dao.save(oil);
        }
    }

    //保存历史上的今天
    public void saveToh() throws IOException {
        String url = "http://api.juheapi.com/japi/toh";
        String key = "41a90f86f48a99dc58da7457b36f62dd";
        int month = LT.getDateInfoOfToday().getIntValue("month");
        int day = LT.getDateInfoOfToday().getIntValue("day");

        Map formMap = new LinkedHashMap();
        formMap.put("v", "1.0");
        formMap.put("month", String.valueOf(month));
        formMap.put("day", String.valueOf(day));
        formMap.put("key", key);
        String body = LT.postForm(formMap, null, url);
        JSONArray data = JSON.parseObject(body).getJSONArray("result");

        for (Object o : data) {
            JSONObject jo = (JSONObject) o;
            Toh po = new Toh();
            po.setTitle(jo.getString("title"));
            po.setDes(jo.getString("des"));
            po.setYear(jo.getString("year"));
            po.setMonth(jo.getString("month"));
            po.setDay(jo.getString("day"));
            po.setPic(jo.getString("pic"));
            po.setCreateTime(new Timestamp(new Date().getTime()));
            dao.save(po);
        }
    }
}
