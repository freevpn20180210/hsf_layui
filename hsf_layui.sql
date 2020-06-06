/*
 Navicat MySQL Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50730
 Source Host           : localhost:3306
 Source Schema         : hsf_layui

 Target Server Type    : MySQL
 Target Server Version : 50730
 File Encoding         : 65001

 Date: 07/06/2020 01:36:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for guest
-- ----------------------------
DROP TABLE IF EXISTS `guest`;
CREATE TABLE `guest`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `browser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dev` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of guest
-- ----------------------------

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `href` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `iconFont` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `expanded` tinyint(1) NULL DEFAULT NULL,
  `isShow` tinyint(1) NULL DEFAULT NULL,
  `orderIndex` int(11) NULL DEFAULT NULL,
  `parentId` int(11) NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createTime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updateTime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '系统管理', '', NULL, NULL, 0, NULL, 0, NULL, NULL, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (2, '用户管理', 'views/sys/user/list.jsp', NULL, NULL, NULL, NULL, 1, 1, '', '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (3, '权限管理', '', NULL, NULL, NULL, NULL, 2, 1, '', '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (4, '菜单权限', 'views/sys/_menu/list.jsp', NULL, NULL, NULL, NULL, 1, 3, '能否看到菜单', '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (5, '功能权限', 'views/sys/perm/list.jsp', NULL, NULL, NULL, NULL, 2, 3, '能否增删改查', '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (6, '数据权限', '', NULL, NULL, NULL, NULL, 3, 3, '能看到哪些数据', '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (7, '字段权限', '', NULL, NULL, NULL, NULL, 4, 3, '能看到哪些字段', '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (8, '日志管理', '', NULL, NULL, NULL, NULL, 3, 1, NULL, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (9, '登录日志', 'views/sys/guest/list.jsp', NULL, NULL, NULL, NULL, 1, 8, '', '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (10, 'VIP音乐免费听', 'http://tool.liumingye.cn/music/', NULL, NULL, NULL, NULL, 3, NULL, NULL, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (11, '百度一下', 'https://www.baidu.com', NULL, NULL, NULL, NULL, 1, NULL, NULL, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (12, '作者博客', 'https://blog.csdn.net/weixin_41763571', NULL, NULL, NULL, NULL, 10, NULL, NULL, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (13, 'VIP视频免费看', 'http://www.qmaile.com/', NULL, NULL, NULL, NULL, 4, NULL, NULL, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (14, '新闻', 'https://news.163.com/', NULL, NULL, NULL, NULL, 5, NULL, NULL, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (15, '小游戏', 'http://www.4399.com/', NULL, NULL, NULL, NULL, 7, NULL, NULL, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (16, '在线工具', 'https://tool.lu/', NULL, NULL, NULL, NULL, 8, NULL, NULL, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (17, '网站导航', 'https://www.hao123.com/', NULL, NULL, NULL, NULL, 2, NULL, NULL, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (18, '聊天室', 'views/chat/chat.jsp', NULL, NULL, NULL, NULL, 6, NULL, NULL, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `menu` VALUES (19, '我的网盘', 'views/pan/list.jsp', NULL, NULL, NULL, NULL, 9, NULL, NULL, '2020-06-06 00:00:00', '2020-06-06 00:00:00');

-- ----------------------------
-- Table structure for oil
-- ----------------------------
DROP TABLE IF EXISTS `oil`;
CREATE TABLE `oil`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `a` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `b` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `c` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `d` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createTime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 218 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '国内油价' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oil
-- ----------------------------
INSERT INTO `oil` VALUES (1, '北京', '5.13', '5.50', '5.86', '6.84', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (2, '上海', '5.08', '5.47', '5.82', '6.52', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (3, '江苏', '5.07', '5.49', '5.84', '6.72', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (4, '天津', '5.09', '5.49', '5.80', '6.72', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (5, '重庆', '5.19', '5.59', '5.91', '6.65', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (6, '江西', '5.14', '5.48', '5.88', '6.88', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (7, '辽宁', '5.03', '5.48', '5.84', '6.36', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (8, '安徽', '5.13', '5.49', '5.91', '6.74', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (9, '内蒙古', '5.01', '5.45', '5.82', '6.39', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (10, '福建', '5.10', '5.49', '5.86', '6.41', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (11, '宁夏', '5.01', '5.43', '5.73', '6.60', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (12, '甘肃', '5.02', '5.41', '5.78', '6.15', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (13, '青海', '5.05', '5.46', '5.85', '0', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (14, '广东', '5.11', '5.53', '5.99', '6.85', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (15, '山东', '5.09', '5.48', '5.88', '6.60', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (16, '广西', '5.17', '5.57', '6.02', '6.85', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (17, '山西', '5.15', '5.48', '5.91', '6.61', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (18, '贵州', '5.21', '5.63', '5.95', '6.85', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (19, '陕西', '5.02', '5.41', '5.72', '6.38', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (20, '海南', '5.19', '6.62', '7.02', '7.91', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (21, '四川', '5.21', '5.56', '5.99', '6.52', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (22, '河北', '5.09', '5.49', '5.80', '6.62', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (23, '西藏', '5.67', '6.41', '6.77', '0', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (24, '河南', '5.09', '5.50', '5.88', '6.53', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (25, '新疆', '4.99', '5.38', '5.79', '6.46', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (26, '黑龙江', '4.95', '5.48', '5.88', '6.70', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (27, '吉林', '5.03', '5.47', '5.90', '6.43', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (28, '云南', '5.19', '5.65', '6.06', '6.74', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (29, '湖北', '5.09', '5.51', '5.90', '6.47', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (30, '浙江', '5.09', '5.49', '5.84', '6.39', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (31, '湖南', '5.16', '5.47', '5.82', '6.62', '2020-06-01 00:15:00');
INSERT INTO `oil` VALUES (32, '北京', '5.13', '5.50', '5.86', '6.84', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (33, '上海', '5.08', '5.47', '5.82', '6.52', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (34, '江苏', '5.07', '5.49', '5.84', '6.72', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (35, '天津', '5.09', '5.49', '5.80', '6.72', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (36, '重庆', '5.19', '5.59', '5.91', '6.65', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (37, '江西', '5.14', '5.48', '5.88', '6.88', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (38, '辽宁', '5.03', '5.48', '5.84', '6.36', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (39, '安徽', '5.13', '5.49', '5.91', '6.74', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (40, '内蒙古', '5.01', '5.45', '5.82', '6.39', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (41, '福建', '5.10', '5.49', '5.86', '6.41', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (42, '宁夏', '5.01', '5.43', '5.73', '6.60', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (43, '甘肃', '5.02', '5.41', '5.78', '6.15', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (44, '青海', '5.05', '5.46', '5.85', '0', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (45, '广东', '5.11', '5.53', '5.99', '6.85', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (46, '山东', '5.09', '5.48', '5.88', '6.60', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (47, '广西', '5.17', '5.57', '6.02', '6.85', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (48, '山西', '5.15', '5.48', '5.91', '6.61', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (49, '贵州', '5.21', '5.63', '5.95', '6.85', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (50, '陕西', '5.02', '5.41', '5.72', '6.38', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (51, '海南', '5.19', '6.62', '7.02', '7.91', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (52, '四川', '5.21', '5.56', '5.99', '6.52', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (53, '河北', '5.09', '5.49', '5.80', '6.62', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (54, '西藏', '5.67', '6.41', '6.77', '0', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (55, '河南', '5.09', '5.50', '5.88', '6.53', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (56, '新疆', '4.99', '5.38', '5.79', '6.46', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (57, '黑龙江', '4.95', '5.48', '5.88', '6.70', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (58, '吉林', '5.03', '5.47', '5.90', '6.43', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (59, '云南', '5.19', '5.65', '6.06', '6.74', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (60, '湖北', '5.09', '5.51', '5.90', '6.47', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (61, '浙江', '5.09', '5.49', '5.84', '6.39', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (62, '湖南', '5.16', '5.47', '5.82', '6.62', '2020-06-02 00:15:00');
INSERT INTO `oil` VALUES (63, '北京', '5.13', '5.50', '5.86', '6.84', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (64, '上海', '5.08', '5.47', '5.82', '6.52', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (65, '江苏', '5.07', '5.49', '5.84', '6.72', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (66, '天津', '5.09', '5.49', '5.80', '6.72', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (67, '重庆', '5.19', '5.59', '5.91', '6.65', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (68, '江西', '5.14', '5.48', '5.88', '6.88', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (69, '辽宁', '5.03', '5.48', '5.84', '6.36', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (70, '安徽', '5.13', '5.49', '5.91', '6.74', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (71, '内蒙古', '5.01', '5.45', '5.82', '6.39', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (72, '福建', '5.10', '5.49', '5.86', '6.41', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (73, '宁夏', '5.01', '5.43', '5.73', '6.60', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (74, '甘肃', '5.02', '5.41', '5.78', '6.15', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (75, '青海', '5.05', '5.46', '5.85', '0', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (76, '广东', '5.11', '5.53', '5.99', '6.85', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (77, '山东', '5.09', '5.48', '5.88', '6.60', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (78, '广西', '5.17', '5.57', '6.02', '6.85', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (79, '山西', '5.15', '5.48', '5.91', '6.61', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (80, '贵州', '5.21', '5.63', '5.95', '6.85', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (81, '陕西', '5.02', '5.41', '5.72', '6.38', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (82, '海南', '5.19', '6.62', '7.02', '7.91', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (83, '四川', '5.21', '5.56', '5.99', '6.52', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (84, '河北', '5.09', '5.49', '5.80', '6.62', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (85, '西藏', '5.67', '6.41', '6.77', '0', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (86, '河南', '5.09', '5.50', '5.88', '6.53', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (87, '新疆', '4.99', '5.38', '5.79', '6.46', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (88, '黑龙江', '4.95', '5.48', '5.88', '6.70', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (89, '吉林', '5.03', '5.47', '5.90', '6.43', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (90, '云南', '5.19', '5.65', '6.06', '6.74', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (91, '湖北', '5.09', '5.51', '5.90', '6.47', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (92, '浙江', '5.09', '5.49', '5.84', '6.39', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (93, '湖南', '5.16', '5.47', '5.82', '6.62', '2020-06-03 00:15:00');
INSERT INTO `oil` VALUES (94, '北京', '5.13', '5.50', '5.86', '6.84', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (95, '上海', '5.08', '5.47', '5.82', '6.52', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (96, '江苏', '5.07', '5.49', '5.84', '6.72', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (97, '天津', '5.09', '5.49', '5.80', '6.72', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (98, '重庆', '5.19', '5.59', '5.91', '6.65', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (99, '江西', '5.14', '5.48', '5.88', '6.88', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (100, '辽宁', '5.03', '5.48', '5.84', '6.36', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (101, '安徽', '5.13', '5.49', '5.91', '6.74', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (102, '内蒙古', '5.01', '5.45', '5.82', '6.39', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (103, '福建', '5.10', '5.49', '5.86', '6.41', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (104, '宁夏', '5.01', '5.43', '5.73', '6.60', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (105, '甘肃', '5.02', '5.41', '5.78', '6.15', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (106, '青海', '5.05', '5.46', '5.85', '0', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (107, '广东', '5.11', '5.53', '5.99', '6.85', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (108, '山东', '5.09', '5.48', '5.88', '6.60', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (109, '广西', '5.17', '5.57', '6.02', '6.85', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (110, '山西', '5.15', '5.48', '5.91', '6.61', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (111, '贵州', '5.21', '5.63', '5.95', '6.85', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (112, '陕西', '5.02', '5.41', '5.72', '6.38', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (113, '海南', '5.19', '6.62', '7.02', '7.91', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (114, '四川', '5.21', '5.56', '5.99', '6.52', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (115, '河北', '5.09', '5.49', '5.80', '6.62', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (116, '西藏', '5.67', '6.41', '6.77', '0', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (117, '河南', '5.09', '5.50', '5.88', '6.53', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (118, '新疆', '4.99', '5.38', '5.79', '6.46', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (119, '黑龙江', '4.95', '5.48', '5.88', '6.70', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (120, '吉林', '5.03', '5.47', '5.90', '6.43', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (121, '云南', '5.19', '5.65', '6.06', '6.74', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (122, '湖北', '5.09', '5.51', '5.90', '6.47', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (123, '浙江', '5.09', '5.49', '5.84', '6.39', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (124, '湖南', '5.16', '5.47', '5.82', '6.62', '2020-06-04 00:15:00');
INSERT INTO `oil` VALUES (125, '北京', '5.13', '5.50', '5.86', '6.84', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (126, '上海', '5.08', '5.47', '5.82', '6.52', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (127, '江苏', '5.07', '5.49', '5.84', '6.72', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (128, '天津', '5.09', '5.49', '5.80', '6.72', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (129, '重庆', '5.19', '5.59', '5.91', '6.65', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (130, '江西', '5.14', '5.48', '5.88', '6.88', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (131, '辽宁', '5.03', '5.48', '5.84', '6.36', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (132, '安徽', '5.13', '5.49', '5.91', '6.74', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (133, '内蒙古', '5.01', '5.45', '5.82', '6.39', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (134, '福建', '5.10', '5.49', '5.86', '6.41', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (135, '宁夏', '5.01', '5.43', '5.73', '6.60', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (136, '甘肃', '5.02', '5.41', '5.78', '6.15', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (137, '青海', '5.05', '5.46', '5.85', '0', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (138, '广东', '5.11', '5.53', '5.99', '6.85', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (139, '山东', '5.09', '5.48', '5.88', '6.60', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (140, '广西', '5.17', '5.57', '6.02', '6.85', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (141, '山西', '5.15', '5.48', '5.91', '6.61', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (142, '贵州', '5.21', '5.63', '5.95', '6.85', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (143, '陕西', '5.02', '5.41', '5.72', '6.38', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (144, '海南', '5.19', '6.62', '7.02', '7.91', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (145, '四川', '5.21', '5.56', '5.99', '6.52', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (146, '河北', '5.09', '5.49', '5.80', '6.62', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (147, '西藏', '5.67', '6.41', '6.77', '0', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (148, '河南', '5.09', '5.50', '5.88', '6.53', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (149, '新疆', '4.99', '5.38', '5.79', '6.46', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (150, '黑龙江', '4.95', '5.48', '5.88', '6.70', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (151, '吉林', '5.03', '5.47', '5.90', '6.43', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (152, '云南', '5.19', '5.65', '6.06', '6.74', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (153, '湖北', '5.09', '5.51', '5.90', '6.47', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (154, '浙江', '5.09', '5.49', '5.84', '6.39', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (155, '湖南', '5.16', '5.47', '5.82', '6.62', '2020-06-05 00:15:00');
INSERT INTO `oil` VALUES (156, '北京', '5.13', '5.50', '5.86', '6.84', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (157, '上海', '5.08', '5.47', '5.82', '6.52', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (158, '江苏', '5.07', '5.49', '5.84', '6.72', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (159, '天津', '5.09', '5.49', '5.80', '6.72', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (160, '重庆', '5.19', '5.59', '5.91', '6.65', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (161, '江西', '5.14', '5.48', '5.88', '6.88', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (162, '辽宁', '5.03', '5.48', '5.84', '6.36', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (163, '安徽', '5.13', '5.49', '5.91', '6.74', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (164, '内蒙古', '5.01', '5.45', '5.82', '6.39', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (165, '福建', '5.10', '5.49', '5.86', '6.41', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (166, '宁夏', '5.01', '5.43', '5.73', '6.60', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (167, '甘肃', '5.02', '5.41', '5.78', '6.15', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (168, '青海', '5.05', '5.46', '5.85', '0', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (169, '广东', '5.11', '5.53', '5.99', '6.85', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (170, '山东', '5.09', '5.48', '5.88', '6.60', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (171, '广西', '5.17', '5.57', '6.02', '6.85', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (172, '山西', '5.15', '5.48', '5.91', '6.61', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (173, '贵州', '5.21', '5.63', '5.95', '6.85', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (174, '陕西', '5.02', '5.41', '5.72', '6.38', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (175, '海南', '5.19', '6.62', '7.02', '7.91', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (176, '四川', '5.21', '5.56', '5.99', '6.52', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (177, '河北', '5.09', '5.49', '5.80', '6.62', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (178, '西藏', '5.67', '6.41', '6.77', '0', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (179, '河南', '5.09', '5.50', '5.88', '6.53', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (180, '新疆', '4.99', '5.38', '5.79', '6.46', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (181, '黑龙江', '4.95', '5.48', '5.88', '6.70', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (182, '吉林', '5.03', '5.47', '5.90', '6.43', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (183, '云南', '5.19', '5.65', '6.06', '6.74', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (184, '湖北', '5.09', '5.51', '5.90', '6.47', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (185, '浙江', '5.09', '5.49', '5.84', '6.39', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (186, '湖南', '5.16', '5.47', '5.82', '6.62', '2020-06-06 00:15:00');
INSERT INTO `oil` VALUES (187, '北京', '5.13', '5.50', '5.86', '6.84', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (188, '上海', '5.08', '5.47', '5.82', '6.52', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (189, '江苏', '5.07', '5.49', '5.84', '6.72', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (190, '天津', '5.09', '5.49', '5.80', '6.72', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (191, '重庆', '5.19', '5.59', '5.91', '6.65', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (192, '江西', '5.14', '5.48', '5.88', '6.88', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (193, '辽宁', '5.03', '5.48', '5.84', '6.36', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (194, '安徽', '5.13', '5.49', '5.91', '6.74', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (195, '内蒙古', '5.01', '5.45', '5.82', '6.39', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (196, '福建', '5.10', '5.49', '5.86', '6.41', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (197, '宁夏', '5.01', '5.43', '5.73', '6.60', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (198, '甘肃', '5.02', '5.41', '5.78', '6.15', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (199, '青海', '5.05', '5.46', '5.85', '0', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (200, '广东', '5.11', '5.53', '5.99', '6.85', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (201, '山东', '5.09', '5.48', '5.88', '6.60', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (202, '广西', '5.17', '5.57', '6.02', '6.85', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (203, '山西', '5.15', '5.48', '5.91', '6.61', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (204, '贵州', '5.21', '5.63', '5.95', '6.85', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (205, '陕西', '5.02', '5.41', '5.72', '6.38', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (206, '海南', '5.19', '6.62', '7.02', '7.91', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (207, '四川', '5.21', '5.56', '5.99', '6.52', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (208, '河北', '5.09', '5.49', '5.80', '6.62', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (209, '西藏', '5.67', '6.41', '6.77', '0', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (210, '河南', '5.09', '5.50', '5.88', '6.53', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (211, '新疆', '4.99', '5.38', '5.79', '6.46', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (212, '黑龙江', '4.95', '5.48', '5.88', '6.70', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (213, '吉林', '5.03', '5.47', '5.90', '6.43', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (214, '云南', '5.19', '5.65', '6.06', '6.74', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (215, '湖北', '5.09', '5.51', '5.90', '6.47', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (216, '浙江', '5.09', '5.49', '5.84', '6.39', '2020-06-07 00:15:00');
INSERT INTO `oil` VALUES (217, '湖南', '5.16', '5.47', '5.82', '6.62', '2020-06-07 00:15:00');

-- ----------------------------
-- Table structure for pan
-- ----------------------------
DROP TABLE IF EXISTS `pan`;
CREATE TABLE `pan`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `size` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createTime` datetime(0) NULL DEFAULT NULL,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userId` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  CONSTRAINT `pan_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 59 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '我的网盘' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pan
-- ----------------------------

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `href` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `iconFont` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `expanded` tinyint(1) NULL DEFAULT NULL,
  `isShow` tinyint(1) NULL DEFAULT NULL,
  `orderIndex` int(11) NULL DEFAULT NULL,
  `parentId` int(11) NULL DEFAULT NULL,
  `createTime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updateTime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (9, '系统管理', '', NULL, NULL, NULL, NULL, 1, NULL, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `permission` VALUES (10, '用户管理', 'views/sys/user/list.jsp', NULL, NULL, NULL, NULL, 1, 9, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `permission` VALUES (13, '新增或修改', 'user/saveUpdate', NULL, NULL, NULL, NULL, 3, 10, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `permission` VALUES (14, '删除', 'user/del', NULL, NULL, NULL, NULL, 2, 10, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `permission` VALUES (15, '查询', 'user/list', NULL, NULL, NULL, NULL, 1, 10, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `permission` VALUES (16, '我的网盘', 'views/pan/list.jsp', NULL, NULL, NULL, NULL, 2, NULL, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `permission` VALUES (17, '上传', 'pan/fileUpload', NULL, NULL, NULL, NULL, 3, 16, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `permission` VALUES (18, '查询', 'pan/list', NULL, NULL, NULL, NULL, 1, 16, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `permission` VALUES (19, '删除', 'pan/del', NULL, NULL, NULL, NULL, 2, 16, '2020-06-06 00:00:00', '2020-06-06 00:00:00');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createTime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updateTime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '管理员', NULL, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `role` VALUES (2, '普通用户', NULL, '2020-06-06 00:00:00', '2020-06-06 00:00:00');

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu`  (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `roleId` int(11) NULL DEFAULT NULL,
  `menuId` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `roleId`(`roleId`) USING BTREE,
  INDEX `menuId`(`menuId`) USING BTREE,
  CONSTRAINT `role_menu_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `role_menu_ibfk_2` FOREIGN KEY (`menuId`) REFERENCES `menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 252 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES (185, 1, 1);
INSERT INTO `role_menu` VALUES (186, 1, 2);
INSERT INTO `role_menu` VALUES (187, 1, 3);
INSERT INTO `role_menu` VALUES (188, 1, 4);
INSERT INTO `role_menu` VALUES (189, 1, 5);
INSERT INTO `role_menu` VALUES (190, 1, 6);
INSERT INTO `role_menu` VALUES (191, 1, 7);
INSERT INTO `role_menu` VALUES (192, 1, 8);
INSERT INTO `role_menu` VALUES (193, 1, 9);
INSERT INTO `role_menu` VALUES (194, 1, 11);
INSERT INTO `role_menu` VALUES (195, 1, 17);
INSERT INTO `role_menu` VALUES (196, 1, 10);
INSERT INTO `role_menu` VALUES (197, 1, 13);
INSERT INTO `role_menu` VALUES (198, 1, 14);
INSERT INTO `role_menu` VALUES (199, 1, 18);
INSERT INTO `role_menu` VALUES (200, 1, 15);
INSERT INTO `role_menu` VALUES (201, 1, 16);
INSERT INTO `role_menu` VALUES (202, 1, 12);
INSERT INTO `role_menu` VALUES (203, 1, 19);
INSERT INTO `role_menu` VALUES (242, 2, 11);
INSERT INTO `role_menu` VALUES (243, 2, 17);
INSERT INTO `role_menu` VALUES (244, 2, 10);
INSERT INTO `role_menu` VALUES (245, 2, 13);
INSERT INTO `role_menu` VALUES (246, 2, 14);
INSERT INTO `role_menu` VALUES (247, 2, 18);
INSERT INTO `role_menu` VALUES (248, 2, 15);
INSERT INTO `role_menu` VALUES (249, 2, 16);
INSERT INTO `role_menu` VALUES (250, 2, 12);
INSERT INTO `role_menu` VALUES (251, 2, 19);

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleId` int(11) NULL DEFAULT NULL,
  `permissionId` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `roleId`(`roleId`) USING BTREE,
  INDEX `permissionId`(`permissionId`) USING BTREE,
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permissionId`) REFERENCES `permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES (42, 1, 9);
INSERT INTO `role_permission` VALUES (43, 1, 10);
INSERT INTO `role_permission` VALUES (44, 1, 15);
INSERT INTO `role_permission` VALUES (45, 1, 14);
INSERT INTO `role_permission` VALUES (46, 1, 13);
INSERT INTO `role_permission` VALUES (47, 1, 16);
INSERT INTO `role_permission` VALUES (48, 1, 18);
INSERT INTO `role_permission` VALUES (49, 1, 17);
INSERT INTO `role_permission` VALUES (50, 1, 19);
INSERT INTO `role_permission` VALUES (51, 2, 16);
INSERT INTO `role_permission` VALUES (52, 2, 18);
INSERT INTO `role_permission` VALUES (53, 2, 19);
INSERT INTO `role_permission` VALUES (54, 2, 17);

-- ----------------------------
-- Table structure for toh
-- ----------------------------
DROP TABLE IF EXISTS `toh`;
CREATE TABLE `toh`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `des` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `year` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `month` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `day` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 162 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '历史上的今天' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of toh
-- ----------------------------
INSERT INTO `toh` VALUES (1, '近代生理科学的奠基者哈维逝世', '在363年前的今天，1657年6月3日 (农历四月廿二)，近代生理科学的奠基者哈维逝世。', '1657', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201006/2/22672010166721.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (2, '林则徐在虎门公开销毁鸦片', '在181年前的今天，1839年6月3日 (农历四月廿二)，林则徐在虎门公开销毁鸦片。', '1839', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201003/21/CC234550116.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (3, '清政府同俄国政府签订《中俄密约》', '在124年前的今天，1896年6月3日 (农历四月廿二)，清政府同俄国政府签订《中俄密约》。', '1896', '6', '3', '', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (4, '奥地利音乐家小约翰施特劳斯逝世', '在121年前的今天，1899年6月3日 (农历四月廿五)，奥地利音乐家小约翰施特劳斯逝世。', '1899', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/3/66222140107.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (5, '张学良诞辰', '在119年前的今天，1901年6月3日 (农历四月十七)，张学良诞辰。', '1901', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201006/2/2264201022817.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (6, '中国工人阶级第一次进行大规模政治罢工', '在101年前的今天，1919年6月3日 (农历五月初六)，中国工人阶级第一次进行大规模政治罢工。', '1919', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/CC164422607.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (7, '中国万吨轮出口美国', '在100年前的今天，1920年6月3日 (农历四月十七)，中国万吨轮出口美国。', '1920', '6', '3', '', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (8, '共产国际派人来华建议及早建党', '在99年前的今天，1921年6月3日 (农历四月廿七)，共产国际派人来华建议及早建党。', '1921', '6', '3', '', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (9, '李大钊、马叙伦等师生请愿遭打', '在99年前的今天，1921年6月3日 (农历四月廿七)，李大钊、马叙伦等师生请愿遭打。', '1921', '6', '3', '', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (10, '小说家卡夫卡去世', '在96年前的今天，1924年6月3日 (农历五月初二)，小说家卡夫卡去世。', '1924', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/93164342860.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (11, '原中华民国大总统黎元洪病死', '在92年前的今天，1928年6月3日 (农历四月十六)，原中华民国大总统黎元洪病死。', '1928', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/20164252330.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (12, '豪华客轮诺曼底号创造横越大西洋速度纪录', '在85年前的今天，1935年6月3日 (农历五月初三)，豪华客轮诺曼底号创造横越大西洋速度纪录。', '1935', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/7416417809.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (13, '斯诺到达陕北', '在84年前的今天，1936年6月3日 (农历四月十四)，斯诺到达陕北。', '1936', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/4A164052142.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (14, '温莎公爵结婚', '在83年前的今天，1937年6月3日 (农历四月廿五)，温莎公爵结婚。', '1937', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/AE164044910.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (15, '冀中人民对军展开地道战和地雷战', '在79年前的今天，1941年6月3日 (农历五月初九)，冀中人民对军展开地道战和地雷战。', '1941', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/7B163945119.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (16, '自由法国成立临时政府', '在76年前的今天，1944年6月3日 (农历闰四月十三)，自由法国成立临时政府。', '1944', '6', '3', '', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (17, '汉奸陈公博被处决', '在74年前的今天，1946年6月3日 (农历五月初四)，汉奸陈公博被处决。', '1946', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201003/15/233182010155145.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (18, '蒙巴顿方案公布', '在73年前的今天，1947年6月3日 (农历四月十五)，蒙巴顿方案公布。', '1947', '6', '3', '', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (19, '中国佛教协会成立', '1953年6月3日 (农历四月廿二)，中国佛教协会成立。', '1953', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201006/2/0B215810364.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (20, '南朝鲜六三运动发生', '1964年6月3日 (农历四月廿三)，南朝鲜六三运动发生。', '1964', '6', '3', '', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (21, '美国人怀特创造太空行走时间纪录', '1965年6月3日 (农历五月初四)，美国人怀特创造太空行走时间纪录。', '1965', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/9A16361915.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (22, '中国人民解放军十大将之一许光达逝世', '1969年6月3日 (农历四月十九)，中国人民解放军十大将之一许光达逝世。', '1969', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201006/2/C1221030370.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (23, '伊扎克·拉宾成为以色列新总理', '1974年6月3日 (农历闰四月十三)，伊扎克·拉宾成为以色列新总理。', '1974', '6', '3', '', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (24, '“四人帮”再次受到批评', '1975年6月3日 (农历四月廿四)，“四人帮”再次受到批评。', '1975', '6', '3', '', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (25, '伊朗宗教领袖霍梅尼病逝', '1989年6月3日 (农历四月三十)，伊朗宗教领袖霍梅尼病逝。', '1989', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/CA163041647.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (26, '“15国集团”首脑会议闭幕', '1990年6月3日 (农历五月十一)，“15国集团”首脑会议闭幕。', '1990', '6', '3', '', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (27, '西哈努克宣布成立柬民族政府', '1993年6月3日 (农历四月十四)，西哈努克宣布成立柬民族政府。', '1993', '6', '3', '', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (28, '中国工程院产生首批院士', '1994年6月3日 (农历四月廿四)，中国工程院产生首批院士。', '1994', '6', '3', '', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (29, '杰出的社会活动家安子介在香港逝世', '2000年6月3日 (农历五月初二)，杰出的社会活动家安子介在香港逝世。', '2000', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200406/3/54131830703.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (30, '黑山共和国正式宣布独立', '2006年6月3日 (农历五月初八)，黑山共和国正式宣布独立。', '2006', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/3/CE215833625.jpg', '2020-06-03 00:15:00');
INSERT INTO `toh` VALUES (31, '朱温篡唐，唐朝灭亡，后梁建立，五代十国时代开始', '在1113年前的今天，0907年6月3日 (农历四月二十)，朱温篡唐，唐朝灭亡，后梁建立，五代十国时代开始。', '907', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/3/F8134057161.jpg', '2020-06-03 02:40:35');
INSERT INTO `toh` VALUES (32, '宋太宗灭北汉，结束五代十国分裂局面', '在1041年前的今天，0979年6月3日 (农历五月初六)，宋太宗灭北汉，结束五代十国分裂局面。', '979', '6', '3', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201206/3/E8161920750.jpg', '2020-06-03 02:40:35');
INSERT INTO `toh` VALUES (33, '亨利三世成为德意志皇帝', '在981年前的今天，1039年6月4日 (农历五月初十)，亨利三世成为德意志皇帝。', '1039', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/3/0A233647195.jpg', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (34, '北宋皇帝宋徽宗赵佶逝世', '在885年前的今天，1135年6月4日 (农历四月廿一)，北宋皇帝宋徽宗赵佶逝世。', '1135', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/11/0D05714317.jpg', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (35, '红楼梦作者曹雪芹出生', '在305年前的今天，1715年6月4日 (农历五月初三)，红楼梦作者曹雪芹出生。', '1715', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/4/E3183926441.jpg', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (36, '德国西里西亚纺织工人起义', '在176年前的今天，1844年6月4日 (农历四月十九)，德国西里西亚纺织工人起义。', '1844', '6', '4', '', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (37, '日本第29任首相犬养毅出生', '在165年前的今天，1855年6月4日 (农历四月二十)，日本第29任首相犬养毅出生。', '1855', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/4/FA233052503.jpg', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (38, '太平天国将领陈玉成就义于河南延津', '在158年前的今天，1862年6月4日 (农历五月初八)，太平天国将领陈玉成就义于河南延津。', '1862', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201006/4/2A81920321.jpg', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (39, '邓肯式的舞蹈风靡欧美', '在98年前的今天，1982年6月4日 (农历五月初九)，邓肯式的舞蹈风靡欧美。', '1922', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/B4164357615.jpg', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (40, '广州发生滇桂军叛乱', '在95年前的今天，1925年6月4日 (农历闰四月十四)，广州发生滇桂军叛乱。', '1925', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/1B164332587.jpg', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (41, '张作霖在皇姑屯被炸身亡', '在92年前的今天，1928年6月4日 (农历四月十七)，张作霖在皇姑屯被炸身亡。', '1928', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/2E164249352.jpg', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (42, '金日成夜袭日本根据点普天堡，史称普天堡战役', '在83年前的今天，1937年6月4日 (农历四月廿六)，金日成夜袭日本根据点普天堡，史称普天堡战役。', '1937', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/4/FF223827777.jpg', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (43, '英法军队敦刻尔克大撤退结束', '在80年前的今天，1940年6月4日 (农历四月廿九)，英法军队敦刻尔克大撤退结束。', '1940', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/FA164015431.jpg', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (44, '中途岛海战 日军惨败', '在78年前的今天，1942年6月4日 (农历四月廿一)，中途岛海战 日军惨败。', '1942', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/8B163942760.jpg', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (45, '中共中央发布《关于领导方法的决定》', '在77年前的今天，1943年6月4日 (农历五月初二)，中共中央发布《关于领导方法的决定》。', '1943', '6', '4', '', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (46, '盟军攻克罗马', '在76年前的今天，1944年6月4日 (农历闰四月十四)，盟军攻克罗马。', '1944', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/46163915361.jpg', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (47, '庇隆当选阿根廷总统', '在74年前的今天，1946年6月4日 (农历五月初五)，庇隆当选阿根廷总统。', '1946', '6', '4', '', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (48, '台湾实行公地放领', '1951年6月4日 (农历四月三十)，台湾实行公地放领。', '1951', '6', '4', '', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (49, '被英国侵占的片马归还我国', '1961年6月4日 (农历四月廿一)，被英国侵占的片马归还我国。', '1961', '6', '4', '', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (50, '太平洋岛国汤加独立', '1970年6月4日 (农历五月初一)，太平洋岛国汤加独立。', '1970', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/4/55225637224.jpg', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (51, '中国加入世界知识产权组织', '1980年6月4日 (农历四月廿二)，中国加入世界知识产权组织。', '1980', '6', '4', '', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (52, '全国政社分开建立乡政府的工作结束', '1985年6月4日 (农历四月十六)，全国政社分开建立乡政府的工作结束。', '1985', '6', '4', '', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (53, '邓小平宣布我国政府裁军100万', '1985年6月4日 (农历四月十六)，邓小平宣布我国政府裁军100万。', '1985', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200906/6/9A12544558.jpg', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (54, '美国首次实行安乐死', '1990年6月4日 (农历五月十二)，美国首次实行安乐死。', '1990', '6', '4', '', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (55, '阿尔巴尼亚政府更迭', '1991年6月4日 (农历四月廿二)，阿尔巴尼亚政府更迭。', '1991', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201206/4/F081538819.gif', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (56, '中国发表 《中国的环境保护》白皮书', '1996年6月4日 (农历四月十九)，中国发表 《中国的环境保护》白皮书。', '1996', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201206/4/CC910708.jpg', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (57, '我国互联网用户突破一百万', '1998年6月4日 (农历五月初十)，我国互联网用户突破一百万。', '1998', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201206/4/E982148387.jpg', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (58, '《中国应对气候变化国家方案》正式颁布', '2007年6月4日 (农历四月十九)，《中国应对气候变化国家方案》正式颁布。', '2007', '6', '4', '', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (59, '菅直人当选日本第94任首相', '2010年6月4日 (农历四月廿二)，菅直人当选日本第94任首相。', '2010', '6', '4', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201111/16/7C14458283.jpg', '2020-06-04 00:15:01');
INSERT INTO `toh` VALUES (60, '意大利著名诗人但丁诞生', '在755年前的今天，1265年6月5日 (农历五月二十)，意大利著名诗人但丁诞生。', '1265', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/5/67133646264.jpg', '2020-06-05 00:15:00');
INSERT INTO `toh` VALUES (61, '明末《聊斋志异》作者蒲松龄诞辰', '在380年前的今天，1640年6月5日 (农历四月十六)，明末《聊斋志异》作者蒲松龄诞辰。', '1640', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201205/25/A2173258782.jpg', '2020-06-05 00:15:00');
INSERT INTO `toh` VALUES (62, '英国经济学家亚当·斯密诞辰', '在297年前的今天，1723年6月5日 (农历五月初三)，英国经济学家亚当·斯密诞辰。', '1723', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201206/5/13647201200809.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (63, '英国经济学家凯因斯诞辰', '在137年前的今天，1883年6月5日 (农历五月初一)，英国经济学家凯因斯诞辰。', '1883', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200406/5/F5132035336.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (64, '印尼总统苏加诺诞生', '在119年前的今天，1901年6月5日 (农历四月十九)，印尼总统苏加诺诞生。', '1901', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201006/10/1222339565.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (65, '短篇小说大师欧·亨利去世', '在110年前的今天，1910年6月5日 (农历四月廿八)，短篇小说大师欧·亨利去世。', '1910', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201303/10/9C224215812.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (66, '女飞行员布罗姆韦尔殁于空难', '在99年前的今天，1921年6月5日 (农历四月廿九)，女飞行员布罗姆韦尔殁于空难。', '1921', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/A816444528.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (67, '叶挺独立团攻克湖南攸县', '在94年前的今天，1926年6月5日 (农历四月廿五)，叶挺独立团攻克湖南攸县。', '1926', '6', '5', '', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (68, '宋子文清理广东财政', '在91年前的今天，1929年6月5日 (农历四月廿八)，宋子文清理广东财政。', '1929', '6', '5', '', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (69, '中共中央对第四次反围剿作出部署', '在88年前的今天，1932年6月5日 (农历五月初二)，中共中央对第四次反围剿作出部署。', '1932', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/54164142280.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (70, '日军狂轰滥炸古城开封', '在82年前的今天，1938年6月5日 (农历五月初八)，日军狂轰滥炸古城开封。', '1938', '6', '5', '', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (71, '原中华民国总统徐世昌病逝', '在81年前的今天，1939年6月5日 (农历四月十八)，原中华民国总统徐世昌病逝。', '1939', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/B1164031153.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (72, '重庆防空隧道发生窒息惨案', '在79年前的今天，1941年6月5日 (农历五月十一)，重庆防空隧道发生窒息惨案。', '1941', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/6E163943993.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (73, '诺曼底登陆', '在76年前的今天，1944年6月5日 (农历闰四月十五)，诺曼底登陆。', '1944', '6', '5', '', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (74, '德国被分割为4个占领区', '在75年前的今天，1945年6月5日 (农历四月廿五)，德国被分割为4个占领区。', '1945', '6', '5', '', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (75, '马歇尔计划提出', '在73年前的今天，1947年6月5日 (农历四月十七)，马歇尔计划提出。', '1947', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/DE163815806.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (76, '英国色情间谍事件', '1963年6月5日 (农历闰四月十四)，英国色情间谍事件。', '1963', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/F1163620835.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (77, '京剧现代戏观摩演出', '1964年6月5日 (农历四月廿五)，京剧现代戏观摩演出。', '1964', '6', '5', '', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (78, '第三次中东战争爆发', '1967年6月5日 (农历四月廿八)，第三次中东战争爆发。', '1967', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/28163547378.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (79, '肯尼迪遇刺身亡', '1968年6月5日 (农历五月初十)，肯尼迪遇刺身亡。', '1968', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/A9163522957.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (80, '我国与希腊建立外交关系', '1972年6月5日 (农历四月廿四)，我国与希腊建立外交关系。', '1972', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200406/5/6F132210265.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (81, '世界环境日', '1972年6月5日 (农历四月廿四)，世界环境日。', '1972', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/00163446296.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (82, '关闭8年后的苏伊士运河重新开放', '1975年6月5日 (农历四月廿六)，关闭8年后的苏伊士运河重新开放。', '1975', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/EF163418782.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (83, '科威特缺席判处前傀儡政权总理死刑', '1993年6月5日 (农历四月十六)，科威特缺席判处前傀儡政权总理死刑。', '1993', '6', '5', '', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (84, '20世纪华人音乐经典系列活动开幕', '1993年6月5日 (农历四月十六)，20世纪华人音乐经典系列活动开幕。', '1993', '6', '5', '', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (85, '叶乔波告别冰坛', '1994年6月5日 (农历四月廿六)，叶乔波告别冰坛。', '1994', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/8A162811200.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (86, '啄木鸟使发现号发射推迟', '1995年6月5日 (农历五月初八)，啄木鸟使发现号发射推迟。', '1995', '6', '5', '', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (87, '澳大利亚科学家发明微型诊断仪', '1997年6月5日 (农历五月初一)，澳大利亚科学家发明微型诊断仪。', '1997', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/D516276196.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (88, '《纽约时报》执行总编和总编因为假新闻丑闻辞职', '2003年6月5日 (农历五月初六)，《纽约时报》执行总编和总编因为假新闻丑闻辞职。', '2003', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200406/5/E4132227518.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (89, '我国高等教育招生、考试和录取实行重大改革', '2003年6月5日 (农历五月初六)，我国高等教育招生、考试和录取实行重大改革。', '2003', '6', '5', '', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (90, '美国第40任总统罗纳德·威尔逊·里根逝世', '2004年6月5日 (农历四月十八)，美国第40任总统罗纳德·威尔逊·里根逝世。', '2004', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201006/6/3204313859.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (91, '香港科技大学颁授四位在不同界别的杰出人士荣誉大学院士', '2008年6月5日 (农历五月初二)，香港科技大学颁授四位在不同界别的杰出人士荣誉大学院士。', '2008', '6', '5', '', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (92, '央视《新闻联播》主播罗京逝世', '2009年6月5日 (农历五月十三)，央视《新闻联播》主播罗京逝世。', '2009', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200906/29/E913057308.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (93, '全球首个艾滋病治愈病例　患者奇迹重生', '2011年6月5日 (农历五月初四)，全球首个艾滋病治愈病例　患者奇迹重生。', '2011', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/5/2A124823260.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (94, '黄池会盟，吴王夫差与晋争霸', '在2502年前的今天，前482年6月5日 (农历六月廿五)，黄池会盟，吴王夫差与晋争霸。', '-482', '6', '5', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/5/06135519259.jpg', '2020-06-05 00:15:01');
INSERT INTO `toh` VALUES (95, '南宋文天祥诞生', '在784年前的今天，1236年6月6日 (农历五月初二)，南宋文天祥诞生。', '1236', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/6/F622839109.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (96, '西班牙画家蒂埃哥·委拉士开兹出生', '在421年前的今天，1599年6月6日 (农历闰四月十四)，西班牙画家蒂埃哥·委拉士开兹出生。', '1599', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/6/CC221544255.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (97, '清朝八旗军在睿亲王多尔衮的统领下到达北京', '在376年前的今天，1644年6月6日 (农历五月初二)，清朝八旗军在睿亲王多尔衮的统领下到达北京。', '1644', '6', '6', '', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (98, '俄国诗人普希金诞辰', '在221年前的今天，1799年6月6日 (农历五月初四)，俄国诗人普希金诞辰。', '1799', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201312/26/9521569753.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (99, '德国作家托马斯·曼诞辰', '在145年前的今天，1875年6月6日 (农历五月初三)，德国作家托马斯·曼诞辰。', '1875', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200406/6/4A132335504.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (100, '《礼拜六》周刊创刊', '在106年前的今天，1914年6月6日 (农历五月十三)，《礼拜六》周刊创刊。', '1914', '6', '6', '', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (101, '中国第一家证券交易所开业', '在102年前的今天，1918年6月6日 (农历四月廿八)，中国第一家证券交易所开业。', '1918', '6', '6', '', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (102, '克莱斯勒建立汽车公司', '在95年前的今天，1925年6月6日 (农历闰四月十六)，克莱斯勒建立汽车公司。', '1925', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/B7164330950.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (103, '陈独秀次子陈乔年遇害', '在92年前的今天，1928年6月6日 (农历四月十九)，陈独秀次子陈乔年遇害。', '1928', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/60164248563.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (104, '各界呼吁国共停止内战', '在88年前的今天，1932年6月6日 (农历五月初三)，各界呼吁国共停止内战。', '1932', '6', '6', '', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (105, '苏区作出扩大红军百万决议', '在87年前的今天，1933年6月6日 (农历五月十四)，苏区作出扩大红军百万决议。', '1933', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/7A164126170.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (106, '张国焘取消“第二中央”', '在84年前的今天，1936年6月6日 (农历四月十七)，张国焘取消“第二中央”。', '1936', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200406/6/97132418165.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (107, '日军攻占汕头', '在81年前的今天，1939年6月6日 (农历四月十九)，日军攻占汕头。', '1939', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/12164029180.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (108, '盟军在诺曼底登陆', '在76年前的今天，1944年6月6日 (农历闰四月十六)，盟军在诺曼底登陆。', '1944', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/8D163913455.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (109, 'NBA前身BAA正式成立', '在74年前的今天，1946年6月6日 (农历五月初七)，NBA前身BAA正式成立。', '1946', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/6/216332011344993.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (110, '司徒雷登与中共再次接触', '1949年6月6日 (农历五月初十)，司徒雷登与中共再次接触。', '1949', '6', '6', '', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (111, '日本赤色整肃开始', '1950年6月6日 (农历四月廿一)，日本赤色整肃开始。', '1950', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201206/6/D1172132681.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (112, '毛泽东提出“不要四面出击”方针', '1950年6月6日 (农历四月廿一)，毛泽东提出“不要四面出击”方针。', '1950', '6', '6', '', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (113, '邓小平要求克服西南区党内的不良倾向', '1950年6月6日 (农历四月廿一)，邓小平要求克服西南区党内的不良倾向。', '1950', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200406/6/9A132427716.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (114, '中共中央发出《关于加紧进行整风的指示》', '1957年6月6日 (农历五月初九)，中共中央发出《关于加紧进行整风的指示》。', '1957', '6', '6', '', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (115, '精神病学先驱卡尔·吉斯塔夫·荣格去世', '1961年6月6日 (农历四月廿三)，精神病学先驱卡尔·吉斯塔夫·荣格去世。', '1961', '6', '6', '', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (116, '霍梅尼在伊朗暴乱中被捕', '1963年6月6日 (农历闰四月十五)，霍梅尼在伊朗暴乱中被捕。', '1963', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201206/6/F5171841856.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (117, '无人宇宙飞船拍下月球表面照片', '1966年6月6日 (农历四月十八)，无人宇宙飞船拍下月球表面照片。', '1966', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/9F163550517.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (118, '梅雷迪斯在人权游行中遭枪击', '1966年6月6日 (农历四月十八)，梅雷迪斯在人权游行中遭枪击。', '1966', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/B7163549568.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (119, '越南南方共和临时革命政府成立', '1969年6月6日 (农历四月廿二)，越南南方共和临时革命政府成立。', '1969', '6', '6', '', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (120, '非洲、加勒比和太平洋地区国家集团', '1975年6月6日 (农历四月廿七)，非洲、加勒比和太平洋地区国家集团。', '1975', '6', '6', '', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (121, '石油大王保罗·盖蒂去世', '1976年6月6日 (农历五月初九)，石油大王保罗·盖蒂去世。', '1976', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/2316340889.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (122, '国务院正式承认基诺族为我国单一的少数民族', '1979年6月6日 (农历五月十二)，国务院正式承认基诺族为我国单一的少数民族。', '1979', '6', '6', '', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (123, '袁隆平荣获我国第一个特等发明奖', '1981年6月6日 (农历五月初五)，袁隆平荣获我国第一个特等发明奖。', '1981', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201006/6/6405732724.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (124, '以色列对黎巴嫩发动全面入侵 第五次中东战争爆发', '1982年6月6日 (农历闰四月十五)，以色列对黎巴嫩发动全面入侵 第五次中东战争爆发。', '1982', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/4D163243644.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (125, '同盟国首脑纪念诺曼底登陆', '1984年6月6日 (农历五月初七)，同盟国首脑纪念诺曼底登陆。', '1984', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/C5163154800.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (126, '“网上最红女模”张筱雨出生', '在35年前的今天，1985年6月6日 (农历四月十八)，“网上最红女模”张筱雨出生。', '1985', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/6/1F224036291.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (127, '官渡之战', '在1821年前的今天，0199年6月6日 (农历四月廿五)，官渡之战。', '199', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/5/F514342407.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (128, '西北航空公司一客机失事 160人遇难', '1994年6月6日 (农历四月廿七)，西北航空公司一客机失事 160人遇难。', '1994', '6', '6', '', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (129, '“高考最牛钉子户”粮实第15次赴考', '2011年6月6日 (农历五月初五)，“高考最牛钉子户”粮实第15次赴考。', '2011', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/6/87201223291.jpg', '2020-06-06 00:15:00');
INSERT INTO `toh` VALUES (130, '晋楚鄢陵之战', '在2595年前的今天，前575年6月6日 (农历六月十九)，晋楚鄢陵之战。', '-575', '6', '6', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/5/4D142253756.jpg', '2020-06-06 00:15:01');
INSERT INTO `toh` VALUES (131, '俄国文学评论家别林斯基逝世', '在172年前的今天，1848年6月7日 (农历五月初七)，俄国文学评论家别林斯基逝世。', '1848', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201206/7/38122251187.jpg', '2020-06-07 00:15:00');
INSERT INTO `toh` VALUES (132, '俄国著名植物学家米丘林诞辰', '在165年前的今天，1855年6月7日 (农历四月廿三)，俄国著名植物学家米丘林诞辰。', '1855', '6', '7', '', '2020-06-07 00:15:00');
INSERT INTO `toh` VALUES (133, '捷克斯洛伐克著名科学家伦纳德诞辰', '在158年前的今天，1862年6月7日 (农历五月十一)，捷克斯洛伐克著名科学家伦纳德诞辰。', '1862', '6', '7', '', '2020-06-07 00:15:00');
INSERT INTO `toh` VALUES (134, '四十五个州县城镇被停科考五年', '在119年前的今天，1901年6月7日 (农历四月廿一)，四十五个州县城镇被停科考五年。', '1901', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/AB164543441.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (135, '梁启超《立宪法议》发表', '在119年前的今天，1901年6月7日 (农历四月廿一)，梁启超《立宪法议》发表。', '1901', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201206/7/CA122341779.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (136, '山西设立大学堂', '在118年前的今天，1902年6月7日 (农历五月初二)，山西设立大学堂。', '1902', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200406/7/4C132643869.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (137, '第一艘货船通过巴拿马运河', '在106年前的今天，1914年6月7日 (农历五月十四)，第一艘货船通过巴拿马运河。', '1914', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/4C164453306.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (138, '中俄蒙签订协约', '在105年前的今天，1915年6月7日 (农历四月廿五)，中俄蒙签订协约。', '1915', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200406/7/12132649868.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (139, '巡洋舰沉没基钦纳勋爵遇难', '在104年前的今天，1916年6月7日 (农历五月初七)，巡洋舰沉没基钦纳勋爵遇难。', '1916', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/71164438265.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (140, '黎元洪继任大总统', '在104年前的今天，1916年6月7日 (农历五月初七)，黎元洪继任大总统。', '1916', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/A1164440628.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (141, '独立各省取消独立，服从中央命令', '在104年前的今天，1916年6月7日 (农历五月初七)，独立各省取消独立，服从中央命令。', '1916', '6', '7', '', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (142, '第一家国人创办的交易所开业', '在102年前的今天，1918年6月7日 (农历四月廿九)，第一家国人创办的交易所开业。', '1918', '6', '7', '', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (143, '孙殿英夜盗东陵', '在92年前的今天，1928年6月7日 (农历四月二十)，孙殿英夜盗东陵。', '1928', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/32164244353.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (144, '关于德国赔款问题的杨格计划提出', '在91年前的今天，1929年6月7日 (农历五月初一)，关于德国赔款问题的杨格计划提出。', '1929', '6', '7', '', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (145, '张国焘连杀红四方面军高级领导人', '在87年前的今天，1933年6月7日 (农历五月十五)，张国焘连杀红四方面军高级领导人。', '1933', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/A7164124653.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (146, '苏联农业科学家米丘林逝世', '在85年前的今天，1935年6月7日 (农历五月初七)，苏联农业科学家米丘林逝世。', '1935', '6', '7', '', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (147, '晋西北反“扫荡”开始', '在80年前的今天，1940年6月7日 (农历五月初二)，晋西北反“扫荡”开始。', '1940', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201206/7/B2125216304.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (148, '敦煌文物研究所受嘉奖', '1951年6月7日 (农历五月初三)，敦煌文物研究所受嘉奖。', '1951', '6', '7', '', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (149, '两名英国失踪外交官被认为是间谍', '1951年6月7日 (农历五月初三)，两名英国失踪外交官被认为是间谍。', '1951', '6', '7', '', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (150, '陈镜开打破世界纪录', '1956年6月7日 (农历四月廿九)，陈镜开打破世界纪录。', '1956', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/F816378615.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (151, '举重运动员陈镜开第一次打破世界纪录', '1956年6月7日 (农历四月廿九)，举重运动员陈镜开第一次打破世界纪录。', '1956', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201206/7/1D121655290.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (152, '英国作家爱德华·福斯特去世', '1970年6月7日 (农历五月初四)，英国作家爱德华·福斯特去世。', '1970', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/7116358753.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (153, '《孙子兵法》和《孙膑兵法》出土', '1974年6月7日 (农历闰四月十七)，《孙子兵法》和《孙膑兵法》出土。', '1974', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201106/21/D904251255.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (154, '以色列轰炸伊拉克核设施', '1981年6月7日 (农历五月初六)，以色列轰炸伊拉克核设施。', '1981', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/201306/8/47121841757.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (155, '美国防部研制镓芯片32位微处理机', '1985年6月7日 (农历四月十九)，美国防部研制镓芯片32位微处理机。', '1985', '6', '7', '', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (156, '台湾新一代导演崛起', '1985年6月7日 (农历四月十九)，台湾新一代导演崛起。', '1985', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/C0163126565.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (157, '戏剧家阳翰笙逝世', '1993年6月7日 (农历四月十八)，戏剧家阳翰笙逝世。', '1993', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/0A162837935.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (158, '中央军委举行晋升上将军官军衔仪式', '1993年6月7日 (农历四月十八)，中央军委举行晋升上将军官军衔仪式。', '1993', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200406/7/CB132743656.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (159, '动画片《花木兰》风靡美国', '1998年6月7日 (农历五月十三)，动画片《花木兰》风靡美国。', '1998', '6', '7', 'http://juheimg.oss-cn-hangzhou.aliyuncs.com/toh/200905/17/8C162536989.jpg', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (160, '湛江特大走私受贿案主犯被处决', '1999年6月7日 (农历四月廿四)，湛江特大走私受贿案主犯被处决。', '1999', '6', '7', '', '2020-06-07 00:15:01');
INSERT INTO `toh` VALUES (161, '全国农村税费改革试点工作会议在北京结束', '2005年6月7日 (农历五月初一)，全国农村税费改革试点工作会议在北京结束。', '2005', '6', '7', '', '2020-06-07 00:15:01');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `realname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mailVerified` tinyint(1) NULL DEFAULT NULL COMMENT '邮箱是否被验证',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `locked` tinyint(1) NULL DEFAULT 0 COMMENT '帐号是否被锁定',
  `panSize` double(255, 0) NULL DEFAULT 100 COMMENT '用户总网盘容量',
  `usablePanSize` double(11, 0) NULL DEFAULT 100 COMMENT '用户可用网盘容量',
  `createTime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `updateTime` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '7ffb9dc532fbd051990f9befa23d848d', '哈萨ki', '李杨帆', '', '男', '18072861727', '704799339@qq.com', 1, '杭州', '开发者', 0, 20480, 20480, '2020-06-06 00:00:00', '2020-06-06 00:00:00');
INSERT INTO `user` VALUES (17, 'test1', '5a105e8b9d40e1329780d62ea2265d8a', '测试用户1', '无名氏', 'userPic/我_20200607013324.jpg', '男', '12345678910', '', NULL, '', '', 0, 100, 100, '2020-06-06 00:00:00', '2020-06-06 00:00:00');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NULL DEFAULT NULL,
  `roleId` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  INDEX `roleId`(`roleId`) USING BTREE,
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (18, 1, 1);
INSERT INTO `user_role` VALUES (32, 17, 2);

SET FOREIGN_KEY_CHECKS = 1;
