package com.lyf.controller.systemMonitor;

import com.alibaba.fastjson.JSONObject;
import com.lyf.common.SupperDao;
import com.lyf.tool.SystemUsageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 系统监控
 * author:lyf
 * 20200605
 */
@Controller
@RequestMapping("systemMonitor")
public class SystemMonitorCon {

    @Autowired
    SupperDao dao;

    @RequestMapping("show")
    @ResponseBody
    JSONObject show() {
        JSONObject rs = new JSONObject();
        JSONObject jo1 = SystemUsageUtil.getCpuUsageByOshi();
        JSONObject jo2 = SystemUsageUtil.getMemInfo();
        JSONObject jo3 = SystemUsageUtil.getDiskInfo();
        rs.put("cpu", jo1);
        rs.put("mem", jo2);
        rs.put("disk", jo3);
        return rs;
    }

}
