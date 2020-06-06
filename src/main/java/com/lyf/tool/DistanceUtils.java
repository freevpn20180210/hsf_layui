package com.lyf.tool;

import com.lyf.common.LT;

import java.awt.geom.Point2D;
import java.util.List;

/**
 * 空间计算类
 * author:lyf
 * 20200605
 */
public final class DistanceUtils {

    /**
     * 地球半径,单位m
     */
    private static final double EARTH_RADIUS = 6378137;

    /**
     * 根据经纬度，计算两点间的距离
     *
     * @param longitude1 第一个点的经度
     * @param latitude1  第一个点的纬度
     * @param longitude2 第二个点的经度
     * @param latitude2  第二个点的纬度
     * @return 返回距离 单位米
     */
    public static double getDistance(double longitude1, double latitude1, double longitude2, double latitude2) {
        // 纬度
        double lat1 = Math.toRadians(latitude1);
        double lat2 = Math.toRadians(latitude2);
        // 经度
        double lng1 = Math.toRadians(longitude1);
        double lng2 = Math.toRadians(longitude2);
        // 纬度之差
        double a = lat1 - lat2;
        // 经度之差
        double b = lng1 - lng2;
        // 计算两点距离的公式
        double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2) +
                Math.cos(lat1) * Math.cos(lat2) * Math.pow(Math.sin(b / 2), 2)));
        // 弧长乘地球半径, 返回单位: 米
        s = s * EARTH_RADIUS;
        return s;
    }

//    public static void main(String[] args) {
//        double d1 = getDistance(121.449408, 28.679258, 121.442329, 28.675487);
//        double d2 = getDistance(121.268566, 28.655334, 121.25139, 28.656713);
//        System.out.println(d1);
//        System.out.println(d2);
//    }


    /**
     * 判断点是否在多边形内，如果点位于多边形的顶点或边上，也算做点在多边形内，直接返回true
     *
     * @param point 检测点
     * @param pts   多边形各顶点集合
     * @return 点在多边形内返回true, 否则返回false
     */
    public static boolean isInPolygon(Point2D.Double point, List<Point2D.Double> pts) {

        if (LT.listNotEmpty(pts)) {
            int N = pts.size();
            boolean boundOrVertex = true; //如果点位于多边形的顶点或边上，也算做点在多边形内，直接返回true
            int intersectCount = 0;//cross points count of x
            double precision = 2e-10; //浮点类型计算时候与0比较时候的容差
            Point2D.Double p1, p2;//neighbour bound vertices
            Point2D.Double p = point; //当前点

            p1 = pts.get(0);//left vertex
            for (int i = 1; i <= N; ++i) {//check all rays
                if (p.equals(p1)) {
                    return boundOrVertex;//p is an vertex
                }

                p2 = pts.get(i % N);//right vertex
                if (p.x < Math.min(p1.x, p2.x) || p.x > Math.max(p1.x, p2.x)) {//ray is outside of our interests
                    p1 = p2;
                    continue;//next ray left point
                }

                if (p.x > Math.min(p1.x, p2.x) && p.x < Math.max(p1.x, p2.x)) {//ray is crossing over by the algorithm (common part of)
                    if (p.y <= Math.max(p1.y, p2.y)) {//x is before of ray
                        if (p1.x == p2.x && p.y >= Math.min(p1.y, p2.y)) {//overlies on a horizontal ray
                            return boundOrVertex;
                        }

                        if (p1.y == p2.y) {//ray is vertical
                            if (p1.y == p.y) {//overlies on a vertical ray
                                return boundOrVertex;
                            } else {//before ray
                                ++intersectCount;
                            }
                        } else {//cross point on the left side
                            double xinters = (p.x - p1.x) * (p2.y - p1.y) / (p2.x - p1.x) + p1.y;//cross point of y
                            if (Math.abs(p.y - xinters) < precision) {//overlies on a ray
                                return boundOrVertex;
                            }

                            if (p.y < xinters) {//before ray
                                ++intersectCount;
                            }
                        }
                    }
                } else {//special case when ray is crossing through the vertex
                    if (p.x == p2.x && p.y <= p2.y) {//p crossing over p2
                        Point2D.Double p3 = pts.get((i + 1) % N); //next vertex
                        if (p.x >= Math.min(p1.x, p3.x) && p.x <= Math.max(p1.x, p3.x)) {//p.x lies between p1.x & p3.x
                            ++intersectCount;
                        } else {
                            intersectCount += 2;
                        }
                    }
                }
                p1 = p2;//next ray left point
            }

            if (intersectCount % 2 == 0) {//偶数在多边形外
                return false;
            } else { //奇数在多边形内
                return true;
            }
        } else {
            return true;
        }
    }

    /**
     * 返回一个点是否在一个多边形区域内， 如果点位于多边形的顶点或边上，不算做点在多边形内，返回false
     *
     * @param point
     * @param polygon
     * @return
     */
    public static boolean checkWithJdkGeneralPath(Point2D.Double point, List<Point2D.Double> polygon) {
        if (LT.listNotEmpty(polygon)) {
            java.awt.geom.GeneralPath p = new java.awt.geom.GeneralPath();
            Point2D.Double first = polygon.get(0);
            p.moveTo(first.x, first.y);
            polygon.remove(0);
            for (Point2D.Double d : polygon) {
                p.lineTo(d.x, d.y);
            }
            p.lineTo(first.x, first.y);
            p.closePath();
            return p.contains(point);
        } else {
            return true;
        }
    }

}
