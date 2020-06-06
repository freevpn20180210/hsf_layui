package com.lyf.tool;

import com.alibaba.fastjson.JSONObject;
import com.lyf.common.LT;
import com.sun.management.OperatingSystemMXBean;
import lombok.extern.slf4j.Slf4j;
import oshi.json.SystemInfo;
import oshi.json.hardware.CentralProcessor;
import oshi.json.hardware.GlobalMemory;
import oshi.json.hardware.HardwareAbstractionLayer;

import java.io.File;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.lang.management.ManagementFactory;
import java.nio.charset.Charset;

/**
 * 系统监控类-内存,硬盘,CPU,执行CMD命令
 * author:lyf
 * 20200605
 */
@Slf4j
public class SystemUsageUtil {

    private static SystemInfo systemInfo = new SystemInfo();

    //oshi.json的方式获取内存信息,速度慢
    public static JSONObject getMemInfoByOshi() {
        HardwareAbstractionLayer hal = systemInfo.getHardware();
        GlobalMemory memory = hal.getMemory();
        //可用内存
        long availableMem = memory.getAvailable() / 1024 / 1024;
        //总内存
        long totalMem = memory.getTotal() / 1024 / 1024;
        //已用内存
        long usedMem = totalMem - availableMem;
        //占用率
        double useRateMem = LT.div(usedMem, totalMem, 2);
        //log.info("getMemoryUsage available={},total={},userRate={}", available, total, useRate);

        JSONObject rs = new JSONObject(true);
        rs.put("usedMem", usedMem + "MB");
        rs.put("availableMem", availableMem + "MB");
        rs.put("totalMem", totalMem + "MB");
        rs.put("useRateMem", useRateMem * 100);
        return rs;
    }

    //OperatingSystemMXBean的方式获取内存信息--速度快
    public static JSONObject getMemInfo() {
        OperatingSystemMXBean mem = (OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean();
        //可用内存
        long availableMem = mem.getFreePhysicalMemorySize() / 1024 / 1024;
        //总内存
        long totalMem = mem.getTotalPhysicalMemorySize() / 1024 / 1024;
        //已用内存
        long usedMem = totalMem - availableMem;
        //内存占用率
        double useRateMem = LT.div(usedMem, totalMem, 2);

        JSONObject rs = new JSONObject(true);
        rs.put("usedMem", usedMem + "MB");
        rs.put("availableMem", availableMem + "MB");
        rs.put("totalMem", totalMem + "MB");
        rs.put("useRateMem", useRateMem * 100);
        return rs;
    }

    //File.listRoots()的方式获取硬盘信息--速度快,但只适用于正在使用的硬盘
    public static JSONObject getDiskInfo() {
        File[] disks = File.listRoots();
        // 可用容量
        long availableDisk = 0;
        // 总容量
        long totalDisk = 0;
        // 已用容量
        long usedDisk = 0;
        //遍历每个硬盘的分区,只适用于正在使用的硬盘
        for (File disk : disks) {
            availableDisk += disk.getUsableSpace();
            totalDisk += disk.getTotalSpace();
        }
        usedDisk = totalDisk - availableDisk;
        // 硬盘占用率
        double useRateDisk = LT.div(usedDisk, totalDisk, 2);

        JSONObject rs = new JSONObject(true);
        rs.put("usedDisk", usedDisk / 1024 / 1024 + "MB");
        rs.put("availableDisk", availableDisk / 1024 / 1024 + "MB");
        rs.put("totalDisk", totalDisk / 1024 / 1024 + "MB");
        rs.put("useRateDisk", useRateDisk * 100);
        return rs;
    }

    //oshi.json的方式获取CPU的使用率--速度慢
    public static JSONObject getCpuUsageByOshi() {
//        long startTime = System.currentTimeMillis();
        HardwareAbstractionLayer hal = systemInfo.getHardware();
        CentralProcessor processor = hal.getProcessor();
        double useRate = processor.getSystemCpuLoadBetweenTicks();
        JSONObject rs = new JSONObject(true);
        rs.put("useRateCPU", LT.div(useRate, 1, 2) * 100);
//        long endTime = System.currentTimeMillis();
//        需要1.5秒才能获取到
//        System.out.println(endTime - startTime);
        return rs;
    }

    //运行cmd命令
    private static String runCMD(String CMD) {
        StringBuilder sb = new StringBuilder();
        try {
            Process process = Runtime.getRuntime().exec(CMD);
            process.waitFor();
            //必须指定编码为GBK否则乱码
            LineNumberReader lnr = new LineNumberReader(new InputStreamReader(process.getInputStream(), Charset.forName("GBK")));
            String line;
            while ((line = lnr.readLine()) != null) {
                sb.append(line).append("\n");
            }
        } catch (Exception e) {
            sb = new StringBuilder(e.toString());
        }
        return sb.toString();
    }

}
