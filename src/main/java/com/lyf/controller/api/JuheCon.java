package com.lyf.controller.api;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lyf.common.LT;
import com.lyf.common.SupperDao;
import com.lyf.controller.BaseController;
import com.lyf.po.api.Oil;
import com.lyf.po.api.Toh;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * 聚合api
 * author:lyf
 * 20200605
 */
@Controller
@RequestMapping("juhe")
public class JuheCon extends BaseController {


    @Autowired
    SupperDao dao;

    //ip位置信息
    @RequestMapping("guest")
    @ResponseBody
    JSONObject guest() throws IOException {
        String url = "https://m.so.com/position";
        String body = LT.postForm(null, null, url);
        JSONObject rs = JSON.parseObject(body).getJSONObject("data");
        return rs;
    }

    //今日日期信息
    @RequestMapping("today")
    @ResponseBody
    JSONObject today() {
        return LT.getDateInfoOfToday();
    }

    //历史上的今天
    @RequestMapping("toh")
    @ResponseBody
    JSONObject toh() {
        JSONArray data = new JSONArray();
        List<Toh> list = dao.find("from Toh where createTime like concat ('%',?1,'%')",
                new Object[]{LT.formatDate(new Date(), "yyyy-MM-dd")});
        list.forEach(po -> {
            data.add(po);
        });

        JSONObject rs = new JSONObject();
        rs.put("data", data);
        rs.put("code", 0);
        rs.put("msg", "");
        rs.put("count", data.size());
        return rs;
    }

    //根据ip获取国内各省近7天的油价趋势(如ip定位在杭州就展现杭州近7天的油价趋势)
    @RequestMapping("getOilTrend")
    @ResponseBody
    JSONObject getOilTrend() throws IOException {
        //先查询当前ip的省份
        String url = "https://m.so.com/position";
        String body = LT.postForm(null, null, url);
        JSONObject jo = JSON.parseObject(body).getJSONObject("data");

        String country = jo.getJSONObject("position").getString("country");
        String province = jo.getJSONObject("position").getString("province")
                .replace("省", "")
                .replace("市", "")
                .replace("区", "");
        String city = jo.getJSONObject("position").getString("city");
        String ip = jo.getString("ip");
        String isp = jo.getJSONObject("position").getString("isp");

        //从表中获取该省近7天的油价数据
        List<Oil> list = dao.findBySqlNoMapping(Oil.class, "SELECT * FROM oil WHERE city like concat('%',?1,'%') " +
                "AND createTime >= DATE_SUB( NOW(), INTERVAL 7 DAY ) ORDER BY createTime", new Object[]{province});
        JSONArray a = new JSONArray();
        JSONArray b = new JSONArray();
        JSONArray c = new JSONArray();
        JSONArray d = new JSONArray();

        //日期-x轴
        JSONArray date = new JSONArray();
        //日期-匹配
        JSONArray date2 = new JSONArray();
        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");

        //获取距今前7天的日期,比如今天是6月1日,返回5月26日-6月1日
        for (int i = 6; i >= 0; i--) {
            Calendar cal = Calendar.getInstance();
            cal.setTime(new Date());
            cal.add(Calendar.DATE, -i);
            date.add(sdf.format(cal.getTime()));
            date2.add(sdf2.format(cal.getTime()));
        }
        //给y轴赋值
        for (Object o : date2) {
            for (Oil po : list) {
                //如果找到日期匹配,添加,进入下个日期匹配
                if (sdf2.format(po.getCreateTime()).equals(o)) {
                    a.add(po.getA());
                    b.add(po.getB());
                    c.add(po.getC());
                    d.add(po.getD());
                    list.remove(po);
                } else {//否则设0,进入下个日期匹配
                    a.add(0);
                    b.add(0);
                    c.add(0);
                    d.add(0);
                }
                break;
            }
        }
        JSONObject rs = new JSONObject();
        rs.put("date", date);
        rs.put("a", a);
        rs.put("b", b);
        rs.put("c", c);
        rs.put("d", d);
        rs.put("province", province);
        rs.put("country", country);
        rs.put("city", city);
        rs.put("ip", ip);
        rs.put("isp", isp);
        rs.put("ok", true);
        return rs;
    }

    //根据ip获取国内各省近7天的油价趋势的分析
    @RequestMapping("analyze")
    @ResponseBody
    JSONObject analyze(String province) {
        JSONObject rs = new JSONObject();
        String date1 = LT.getDateFromToday(0, "yyyy-MM-dd");
        String date2 = LT.getDateFromToday(1, "yyyy-MM-dd");

        String sql = "SELECT * FROM oil " +
                "WHERE city LIKE concat( '%', ?1, '%' ) " +
                "AND createTime LIKE concat( '%', ?2, '%' ) " +
                "order by createTime desc limit 1";

        Oil oil1 = (Oil) dao.findOneBySql(Oil.class, sql, new Object[]{province, date1});
        Oil oil2 = (Oil) dao.findOneBySql(Oil.class, sql, new Object[]{province, date2});
        if (LT.isEmpty(oil1)) {
            rs.put("ok", false);
            rs.put("msg", "今日油价暂无数据,无法分析,请在0点15分之后重试");
            return rs;
        }
        //今天
        double a1 = Double.parseDouble(oil1.getA());
        double b1 = Double.parseDouble(oil1.getB());
        double c1 = Double.parseDouble(oil1.getC());
        double d1 = Double.parseDouble(oil1.getD());
        //昨天
        double a2 = Double.parseDouble(oil2.getA());
        double b2 = Double.parseDouble(oil2.getB());
        double c2 = Double.parseDouble(oil2.getC());
        double d2 = Double.parseDouble(oil2.getD());

        //图标
        String priceNomal = "<i class=\"layui-icon layui-icon-subtraction\" style=\" color: #1E9FFF;\"></i>";
        String priceUp = "<i class=\"layui-icon layui-icon-up\" style=\" color: red;\"></i>";
        String priceDown = "<i class=\"layui-icon layui-icon-down\" style=\" color: green;\"></i>";
        //计算今天比昨天的增减了多少钱
        String s0 = a1 == a2 ? "平稳" + priceNomal : (a1 > a2 ? "上升" + LT.subDouble(a1, a2) + "元" + priceUp : "下降" + LT.subDouble(a2, a1) + "元" + priceDown);
        //计算今天比昨天的增减了多少幅度
        double p0 = a1 == a2 ? 0 : (a1 > a2 ? LT.mul(LT.div(LT.subDouble(a1, a2), a2, 4), 100) : LT.mul(LT.div(LT.subDouble(a2, a1), a2, 4), 100));

        String s92 = b1 == b2 ? "平稳" + priceNomal : (b1 > b2 ? "上升" + LT.subDouble(b1, b2) + "元" + priceUp : "下降" + LT.subDouble(b2, b1) + "元" + priceDown);
        double p92 = b1 == b2 ? 0 : (b1 > b2 ? LT.mul(LT.div(LT.subDouble(b1, b2), b2, 4), 100) : LT.mul(LT.div(LT.subDouble(b2, b1), b2, 4), 100));

        String s95 = c1 == c2 ? "平稳" + priceNomal : (c1 > c2 ? "上升" + LT.subDouble(c1, c2) + "元" + priceUp : "下降" + LT.subDouble(c2, c1) + "元" + priceDown);
        double p95 = c1 == c2 ? 0 : (c1 > c2 ? LT.mul(LT.div(LT.subDouble(c1, c2), c2, 4), 100) : LT.mul(LT.div(LT.subDouble(c2, c1), c2, 4), 100));

        String s98 = d1 == d2 ? "平稳" + priceNomal : (d1 > d2 ? "上升" + LT.subDouble(d1, d2) + "元" + priceUp : "下降" + LT.subDouble(d2, d1) + "元" + priceDown);
        double p98 = d1 == d2 ? 0 : (d1 > d2 ? LT.mul(LT.div(LT.subDouble(d1, d2), d2, 4), 100) : LT.mul(LT.div(LT.subDouble(d2, d1), d2, 4), 100));

        JSONObject data = new JSONObject(true);
        data.put("s0", s0);
        data.put("s92", s92);
        data.put("s95", s95);
        data.put("s98", s98);

        data.put("p0", p0);
        data.put("p92", p92);
        data.put("p95", p95);
        data.put("p98", p98);

        rs.put("data", data);
        rs.put("ok", true);
        return rs;
    }
}
