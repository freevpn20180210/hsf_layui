package com.lyf.controller.sys;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.lyf.common.LT;
import com.lyf.common.Page;
import com.lyf.common.SupperDao;
import com.lyf.controller.BaseController;
import com.lyf.po.sys.Guest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigInteger;
import java.util.List;

/**
 * 访客信息
 * author:lyf
 * 20200605
 */
@Controller
@RequestMapping("guest")
public class GuestCon extends BaseController {


    @Autowired
    SupperDao dao;

    @RequestMapping("list")
    @ResponseBody
    JSONObject list(String[] keywords, Page page) {
        List<Guest> list = null;
        BigInteger count = null;
        if (LT.arrNotEmpty(keywords)) {
            list = dao.findByPage("from Guest " +
                    "where cname like concat('%',?1,'%') " +
                    "and time like concat('%',?2,'%') " +
                    "order by time desc,convertGBK(cname)", page, keywords);
            count = (BigInteger) dao.findOneBySql("select count(*) from guest " +
                    "where cname like concat('%',?1,'%') " +
                    "and time like concat('%',?2,'%') ", keywords);
        } else {
            list = dao.findByPage("from Guest order by time desc,convertGBK(cname)", page, null);
            count = (BigInteger) dao.findOneBySql("select count(*) from guest", null);
        }
        JSONObject rs = new JSONObject();
        JSONArray data = new JSONArray();
        list.forEach(po -> {
            data.add(po);
        });
        rs.put("data", data);
        rs.put("code", 0);
        rs.put("msg", "");
        rs.put("count", count);
        return rs;
    }

    @RequestMapping("del")
    @ResponseBody
    JSONObject del(Integer[] ids) {
        dao.delAll(Guest.class, ids);
        JSONObject jo = new JSONObject();
        jo.put("ok", true);
        return jo;
    }
}
