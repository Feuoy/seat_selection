/*
Navicat MySQL Data Transfer

Source Server         : 47.103.35.105
Source Server Version : 50728
Source Host           : 47.103.35.105:3306
Source Database       : web_demo

Target Server Type    : MYSQL
Target Server Version : 50728
File Encoding         : 65001

Date: 2019-12-26 21:55:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for r_lecture_seat
-- ----------------------------
DROP TABLE IF EXISTS `r_lecture_seat`;
CREATE TABLE `r_lecture_seat` (
  `lecture_seat_id` int(11) NOT NULL AUTO_INCREMENT,
  `lecture_id` int(11) NOT NULL,
  `seat_type` int(11) NOT NULL COMMENT '1：座位，2：过道',
  `seat_x` varchar(255) NOT NULL,
  `seat_y` varchar(255) NOT NULL,
  `is_show` int(11) NOT NULL,
  `is_selected` int(11) NOT NULL,
  PRIMARY KEY (`lecture_seat_id`),
  KEY `lectureId` (`lecture_id`),
  KEY `seat_type` (`seat_type`),
  CONSTRAINT `lectureId` FOREIGN KEY (`lecture_id`) REFERENCES `t_lecture_info` (`lecture_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `seat_type` FOREIGN KEY (`seat_type`) REFERENCES `t_seat_type` (`seat_type`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3916 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of r_lecture_seat
-- ----------------------------
INSERT INTO `r_lecture_seat` VALUES ('812', '2', '1', '1', '1', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('813', '2', '1', '1', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('814', '2', '1', '1', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('815', '2', '1', '1', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('816', '2', '1', '1', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('817', '2', '1', '1', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('818', '2', '1', '1', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('819', '2', '1', '1', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('820', '2', '1', '1', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('821', '2', '1', '1', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('822', '2', '1', '2', '1', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('823', '2', '1', '2', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('824', '2', '1', '2', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('825', '2', '1', '2', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('826', '2', '1', '2', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('827', '2', '1', '2', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('828', '2', '1', '2', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('829', '2', '1', '2', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('830', '2', '1', '2', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('831', '2', '1', '2', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('832', '2', '1', '3', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('833', '2', '1', '3', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('834', '2', '1', '3', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('835', '2', '1', '3', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('836', '2', '1', '3', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('837', '2', '1', '3', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('838', '2', '1', '3', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('839', '2', '1', '3', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('840', '2', '1', '3', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('841', '2', '1', '3', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('842', '2', '1', '4', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('843', '2', '1', '4', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('844', '2', '1', '4', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('845', '2', '1', '4', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('846', '2', '1', '4', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('847', '2', '1', '4', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('848', '2', '1', '4', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('849', '2', '1', '4', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('850', '2', '1', '4', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('851', '2', '1', '4', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('852', '2', '1', '5', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('853', '2', '1', '5', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('854', '2', '1', '5', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('855', '2', '1', '5', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('856', '2', '1', '5', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('857', '2', '1', '5', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('858', '2', '1', '5', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('859', '2', '1', '5', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('860', '2', '1', '5', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('861', '2', '1', '5', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('862', '2', '1', '6', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('863', '2', '1', '6', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('864', '2', '1', '6', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('865', '2', '1', '6', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('866', '2', '1', '6', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('867', '2', '1', '6', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('868', '2', '1', '6', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('869', '2', '1', '6', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('870', '2', '1', '6', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('871', '2', '1', '6', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('872', '2', '1', '7', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('873', '2', '1', '7', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('874', '2', '1', '7', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('875', '2', '1', '7', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('876', '2', '1', '7', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('877', '2', '1', '7', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('878', '2', '1', '7', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('879', '2', '1', '7', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('880', '2', '1', '7', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('881', '2', '1', '7', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('882', '2', '1', '8', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('883', '2', '1', '8', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('884', '2', '1', '8', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('885', '2', '1', '8', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('886', '2', '1', '8', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('887', '2', '1', '8', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('888', '2', '1', '8', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('889', '2', '1', '8', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('890', '2', '1', '8', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('891', '2', '1', '8', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('892', '2', '1', '9', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('893', '2', '1', '9', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('894', '2', '1', '9', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('895', '2', '1', '9', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('896', '2', '1', '9', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('897', '2', '1', '9', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('898', '2', '1', '9', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('899', '2', '1', '9', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('900', '2', '1', '9', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('901', '2', '1', '9', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('902', '2', '1', '10', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('903', '2', '1', '10', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('904', '2', '1', '10', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('905', '2', '1', '10', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('906', '2', '1', '10', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('907', '2', '1', '10', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('908', '2', '1', '10', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('909', '2', '1', '10', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('910', '2', '1', '10', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('911', '2', '1', '10', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1012', '15', '1', '1', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1013', '15', '1', '1', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1014', '15', '1', '1', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1015', '15', '1', '1', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1016', '15', '1', '1', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1017', '15', '1', '1', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1018', '15', '1', '1', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1019', '15', '2', '1', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1020', '15', '2', '1', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1021', '15', '2', '1', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1022', '15', '1', '2', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1023', '15', '1', '2', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1024', '15', '1', '2', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1025', '15', '1', '2', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1026', '15', '1', '2', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1027', '15', '1', '2', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1028', '15', '1', '2', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1029', '15', '2', '2', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1030', '15', '2', '2', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1031', '15', '2', '2', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1032', '15', '1', '3', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1033', '15', '1', '3', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1034', '15', '1', '3', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1035', '15', '1', '3', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1036', '15', '1', '3', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1037', '15', '1', '3', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1038', '15', '1', '3', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1039', '15', '2', '3', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1040', '15', '2', '3', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1041', '15', '2', '3', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1042', '15', '1', '4', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1043', '15', '1', '4', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1044', '15', '1', '4', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1045', '15', '1', '4', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1046', '15', '1', '4', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1047', '15', '1', '4', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1048', '15', '1', '4', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1049', '15', '2', '4', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1050', '15', '2', '4', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1051', '15', '2', '4', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1052', '15', '1', '5', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1053', '15', '1', '5', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1054', '15', '1', '5', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1055', '15', '1', '5', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1056', '15', '1', '5', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1057', '15', '1', '5', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1058', '15', '1', '5', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1059', '15', '2', '5', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1060', '15', '2', '5', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1061', '15', '2', '5', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1062', '15', '1', '6', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1063', '15', '1', '6', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1064', '15', '1', '6', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1065', '15', '1', '6', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1066', '15', '1', '6', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1067', '15', '1', '6', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1068', '15', '1', '6', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1069', '15', '2', '6', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1070', '15', '2', '6', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1071', '15', '2', '6', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1072', '15', '1', '7', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1073', '15', '1', '7', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1074', '15', '1', '7', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1075', '15', '1', '7', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1076', '15', '1', '7', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1077', '15', '1', '7', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1078', '15', '1', '7', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1079', '15', '2', '7', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1080', '15', '2', '7', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1081', '15', '2', '7', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1082', '15', '1', '8', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1083', '15', '1', '8', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1084', '15', '1', '8', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1085', '15', '1', '8', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1086', '15', '1', '8', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1087', '15', '1', '8', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1088', '15', '1', '8', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1089', '15', '2', '8', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1090', '15', '2', '8', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1091', '15', '2', '8', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1092', '15', '1', '9', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1093', '15', '1', '9', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1094', '15', '1', '9', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1095', '15', '1', '9', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1096', '15', '1', '9', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1097', '15', '1', '9', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1098', '15', '1', '9', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1099', '15', '2', '9', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1100', '15', '2', '9', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1101', '15', '2', '9', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1102', '15', '1', '10', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1103', '15', '1', '10', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1104', '15', '1', '10', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1105', '15', '1', '10', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1106', '15', '1', '10', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1107', '15', '1', '10', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1108', '15', '1', '10', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1109', '15', '2', '10', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1110', '15', '2', '10', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1111', '15', '2', '10', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1922', '19', '1', '1', '1', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('1923', '19', '1', '1', '2', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('1924', '19', '1', '1', '3', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('1925', '19', '1', '1', '4', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('1926', '19', '1', '1', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1927', '19', '1', '1', '6', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('1928', '19', '1', '1', '7', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('1929', '19', '1', '1', '8', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('1930', '19', '1', '1', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1931', '19', '1', '1', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1932', '19', '1', '1', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1933', '19', '1', '1', '12', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('1934', '19', '1', '1', '13', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('1935', '19', '1', '1', '14', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('1936', '19', '2', '1', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1937', '19', '1', '2', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1938', '19', '1', '2', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1939', '19', '1', '2', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1940', '19', '1', '2', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1941', '19', '1', '2', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1942', '19', '1', '2', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1943', '19', '1', '2', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1944', '19', '1', '2', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1945', '19', '1', '2', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1946', '19', '1', '2', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1947', '19', '1', '2', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1948', '19', '1', '2', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1949', '19', '1', '2', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1950', '19', '1', '2', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1951', '19', '2', '2', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1952', '19', '1', '3', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1953', '19', '1', '3', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1954', '19', '1', '3', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1955', '19', '1', '3', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1956', '19', '1', '3', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1957', '19', '1', '3', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1958', '19', '1', '3', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1959', '19', '1', '3', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1960', '19', '1', '3', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1961', '19', '1', '3', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1962', '19', '1', '3', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1963', '19', '1', '3', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1964', '19', '1', '3', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1965', '19', '1', '3', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1966', '19', '2', '3', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1967', '19', '1', '4', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1968', '19', '1', '4', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1969', '19', '1', '4', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1970', '19', '1', '4', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1971', '19', '1', '4', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1972', '19', '1', '4', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1973', '19', '1', '4', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1974', '19', '1', '4', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1975', '19', '1', '4', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1976', '19', '1', '4', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1977', '19', '1', '4', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1978', '19', '1', '4', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1979', '19', '1', '4', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1980', '19', '1', '4', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1981', '19', '2', '4', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1982', '19', '1', '5', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1983', '19', '1', '5', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1984', '19', '1', '5', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1985', '19', '1', '5', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1986', '19', '1', '5', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1987', '19', '1', '5', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1988', '19', '1', '5', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1989', '19', '1', '5', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1990', '19', '1', '5', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1991', '19', '1', '5', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1992', '19', '1', '5', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1993', '19', '1', '5', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1994', '19', '1', '5', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1995', '19', '1', '5', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1996', '19', '2', '5', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1997', '19', '1', '6', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1998', '19', '1', '6', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('1999', '19', '1', '6', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2000', '19', '1', '6', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2001', '19', '1', '6', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2002', '19', '1', '6', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2003', '19', '1', '6', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2004', '19', '1', '6', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2005', '19', '1', '6', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2006', '19', '1', '6', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2007', '19', '1', '6', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2008', '19', '1', '6', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2009', '19', '1', '6', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2010', '19', '1', '6', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2011', '19', '2', '6', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2012', '19', '1', '7', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2013', '19', '1', '7', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2014', '19', '1', '7', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2015', '19', '1', '7', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2016', '19', '1', '7', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2017', '19', '1', '7', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2018', '19', '1', '7', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2019', '19', '1', '7', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2020', '19', '1', '7', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2021', '19', '1', '7', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2022', '19', '1', '7', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2023', '19', '1', '7', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2024', '19', '1', '7', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2025', '19', '1', '7', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2026', '19', '2', '7', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2027', '19', '1', '8', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2028', '19', '1', '8', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2029', '19', '1', '8', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2030', '19', '1', '8', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2031', '19', '1', '8', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2032', '19', '1', '8', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2033', '19', '1', '8', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2034', '19', '1', '8', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2035', '19', '1', '8', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2036', '19', '1', '8', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2037', '19', '1', '8', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2038', '19', '1', '8', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2039', '19', '1', '8', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2040', '19', '1', '8', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2041', '19', '2', '8', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2042', '19', '1', '9', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2043', '19', '1', '9', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2044', '19', '1', '9', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2045', '19', '1', '9', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2046', '19', '1', '9', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2047', '19', '1', '9', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2048', '19', '1', '9', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2049', '19', '1', '9', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2050', '19', '1', '9', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2051', '19', '1', '9', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2052', '19', '1', '9', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2053', '19', '1', '9', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2054', '19', '1', '9', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2055', '19', '1', '9', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2056', '19', '2', '9', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2057', '19', '1', '10', '1', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2058', '19', '1', '10', '2', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2059', '19', '1', '10', '3', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2060', '19', '1', '10', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2061', '19', '1', '10', '5', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2062', '19', '1', '10', '6', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2063', '19', '1', '10', '7', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2064', '19', '1', '10', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2065', '19', '1', '10', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2066', '19', '1', '10', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2067', '19', '1', '10', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2068', '19', '1', '10', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2069', '19', '1', '10', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2070', '19', '1', '10', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2071', '19', '2', '10', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2072', '3', '1', '1', '1', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2073', '3', '1', '1', '2', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2074', '3', '1', '1', '3', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2075', '3', '1', '1', '4', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2076', '3', '1', '1', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2077', '3', '2', '1', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2078', '3', '1', '2', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2079', '3', '1', '2', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2080', '3', '1', '2', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2081', '3', '1', '2', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2082', '3', '1', '2', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2083', '3', '2', '2', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2084', '3', '1', '3', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2085', '3', '1', '3', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2086', '3', '1', '3', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2087', '3', '1', '3', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2088', '3', '1', '3', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2089', '3', '2', '3', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2090', '3', '1', '4', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2091', '3', '1', '4', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2092', '3', '1', '4', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2093', '3', '1', '4', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2094', '3', '1', '4', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2095', '3', '2', '4', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2096', '3', '1', '5', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2097', '3', '1', '5', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2098', '3', '1', '5', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2099', '3', '1', '5', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2100', '3', '1', '5', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2101', '3', '2', '5', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2102', '3', '1', '6', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2103', '3', '1', '6', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2104', '3', '1', '6', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2105', '3', '1', '6', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2106', '3', '1', '6', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2107', '3', '2', '6', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2108', '3', '1', '7', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2109', '3', '1', '7', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2110', '3', '1', '7', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2111', '3', '1', '7', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2112', '3', '1', '7', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2113', '3', '2', '7', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2114', '3', '1', '8', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2115', '3', '1', '8', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2116', '3', '1', '8', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2117', '3', '1', '8', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2118', '3', '1', '8', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2119', '3', '2', '8', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2120', '3', '1', '9', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2121', '3', '1', '9', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2122', '3', '1', '9', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2123', '3', '1', '9', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2124', '3', '1', '9', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2125', '3', '2', '9', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2126', '3', '1', '10', '1', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2127', '3', '1', '10', '2', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2128', '3', '1', '10', '3', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2129', '3', '1', '10', '4', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2130', '3', '1', '10', '5', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2131', '3', '2', '10', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2132', '20', '2', '1', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2133', '20', '1', '1', '2', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2134', '20', '1', '1', '3', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2135', '20', '1', '1', '4', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2136', '20', '1', '1', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2137', '20', '1', '1', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2138', '20', '1', '1', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2139', '20', '1', '1', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2140', '20', '2', '2', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2141', '20', '1', '2', '2', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2142', '20', '1', '2', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2143', '20', '1', '2', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2144', '20', '1', '2', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2145', '20', '1', '2', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2146', '20', '1', '2', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2147', '20', '1', '2', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2148', '20', '2', '3', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2149', '20', '1', '3', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2150', '20', '1', '3', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2151', '20', '1', '3', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2152', '20', '1', '3', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2153', '20', '1', '3', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2154', '20', '1', '3', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2155', '20', '1', '3', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2156', '20', '2', '4', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2157', '20', '1', '4', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2158', '20', '1', '4', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2159', '20', '1', '4', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2160', '20', '1', '4', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2161', '20', '1', '4', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2162', '20', '1', '4', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2163', '20', '1', '4', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2164', '20', '2', '5', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2165', '20', '1', '5', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2166', '20', '1', '5', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2167', '20', '1', '5', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2168', '20', '1', '5', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2169', '20', '1', '5', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2170', '20', '1', '5', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2171', '20', '1', '5', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2172', '20', '2', '6', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2173', '20', '1', '6', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2174', '20', '1', '6', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2175', '20', '1', '6', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2176', '20', '1', '6', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2177', '20', '1', '6', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2178', '20', '1', '6', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2179', '20', '1', '6', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2180', '20', '2', '7', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2181', '20', '1', '7', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2182', '20', '1', '7', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2183', '20', '1', '7', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2184', '20', '1', '7', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2185', '20', '1', '7', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2186', '20', '1', '7', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2187', '20', '1', '7', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2188', '20', '2', '8', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2189', '20', '1', '8', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2190', '20', '1', '8', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2191', '20', '1', '8', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2192', '20', '1', '8', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2193', '20', '1', '8', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2194', '20', '1', '8', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2195', '20', '1', '8', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2196', '21', '2', '1', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2197', '21', '2', '1', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2198', '21', '1', '1', '3', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2199', '21', '1', '1', '4', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2200', '21', '1', '1', '5', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2201', '21', '1', '1', '6', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2202', '21', '1', '1', '7', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2203', '21', '1', '1', '8', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2204', '21', '1', '1', '9', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2205', '21', '1', '1', '10', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2206', '21', '1', '1', '11', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2207', '21', '1', '1', '12', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2208', '21', '1', '1', '13', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2209', '21', '1', '1', '14', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2210', '21', '1', '1', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2211', '21', '2', '2', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2212', '21', '2', '2', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2213', '21', '1', '2', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2214', '21', '1', '2', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2215', '21', '1', '2', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2216', '21', '1', '2', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2217', '21', '1', '2', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2218', '21', '1', '2', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2219', '21', '1', '2', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2220', '21', '1', '2', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2221', '21', '1', '2', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2222', '21', '1', '2', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2223', '21', '1', '2', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2224', '21', '1', '2', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2225', '21', '1', '2', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2226', '21', '2', '3', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2227', '21', '2', '3', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2228', '21', '1', '3', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2229', '21', '1', '3', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2230', '21', '1', '3', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2231', '21', '1', '3', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2232', '21', '1', '3', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2233', '21', '1', '3', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2234', '21', '1', '3', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2235', '21', '1', '3', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2236', '21', '1', '3', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2237', '21', '1', '3', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2238', '21', '1', '3', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2239', '21', '1', '3', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2240', '21', '1', '3', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2241', '21', '2', '4', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2242', '21', '2', '4', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2243', '21', '1', '4', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2244', '21', '1', '4', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2245', '21', '1', '4', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2246', '21', '1', '4', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2247', '21', '1', '4', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2248', '21', '1', '4', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2249', '21', '1', '4', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2250', '21', '1', '4', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2251', '21', '1', '4', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2252', '21', '1', '4', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2253', '21', '1', '4', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2254', '21', '1', '4', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2255', '21', '1', '4', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2256', '21', '2', '5', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2257', '21', '2', '5', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2258', '21', '1', '5', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2259', '21', '1', '5', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2260', '21', '1', '5', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2261', '21', '1', '5', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2262', '21', '1', '5', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2263', '21', '1', '5', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2264', '21', '1', '5', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2265', '21', '1', '5', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2266', '21', '1', '5', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2267', '21', '1', '5', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2268', '21', '1', '5', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2269', '21', '1', '5', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2270', '21', '1', '5', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2271', '21', '2', '6', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2272', '21', '2', '6', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2273', '21', '1', '6', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2274', '21', '1', '6', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2275', '21', '1', '6', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2276', '21', '1', '6', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2277', '21', '1', '6', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2278', '21', '1', '6', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2279', '21', '1', '6', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2280', '21', '1', '6', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2281', '21', '1', '6', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2282', '21', '1', '6', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2283', '21', '1', '6', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2284', '21', '1', '6', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2285', '21', '1', '6', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2286', '21', '2', '7', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2287', '21', '2', '7', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2288', '21', '1', '7', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2289', '21', '1', '7', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2290', '21', '1', '7', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2291', '21', '1', '7', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2292', '21', '1', '7', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2293', '21', '1', '7', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2294', '21', '1', '7', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2295', '21', '1', '7', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2296', '21', '1', '7', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2297', '21', '1', '7', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2298', '21', '1', '7', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2299', '21', '1', '7', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2300', '21', '1', '7', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2301', '21', '2', '8', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2302', '21', '2', '8', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2303', '21', '1', '8', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2304', '21', '1', '8', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2305', '21', '1', '8', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2306', '21', '1', '8', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2307', '21', '1', '8', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2308', '21', '1', '8', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2309', '21', '1', '8', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2310', '21', '1', '8', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2311', '21', '1', '8', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2312', '21', '1', '8', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2313', '21', '1', '8', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2314', '21', '1', '8', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2315', '21', '1', '8', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2316', '21', '2', '9', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2317', '21', '2', '9', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2318', '21', '1', '9', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2319', '21', '1', '9', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2320', '21', '1', '9', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2321', '21', '1', '9', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2322', '21', '1', '9', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2323', '21', '1', '9', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2324', '21', '1', '9', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2325', '21', '1', '9', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2326', '21', '1', '9', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2327', '21', '1', '9', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2328', '21', '1', '9', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2329', '21', '1', '9', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2330', '21', '1', '9', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2331', '21', '2', '10', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2332', '21', '2', '10', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2333', '21', '1', '10', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2334', '21', '1', '10', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2335', '21', '1', '10', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2336', '21', '1', '10', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2337', '21', '1', '10', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2338', '21', '1', '10', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2339', '21', '1', '10', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2340', '21', '1', '10', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2341', '21', '1', '10', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2342', '21', '1', '10', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2343', '21', '1', '10', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2344', '21', '1', '10', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2345', '21', '1', '10', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2346', '22', '2', '1', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2347', '22', '1', '1', '2', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2348', '22', '1', '1', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2349', '22', '1', '1', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2350', '22', '1', '1', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2351', '22', '1', '1', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2352', '22', '1', '1', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2353', '22', '1', '1', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2354', '22', '1', '1', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2355', '22', '1', '1', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2356', '22', '1', '1', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2357', '22', '1', '1', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2358', '22', '1', '1', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2359', '22', '1', '1', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2360', '22', '1', '1', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2361', '22', '2', '2', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2362', '22', '1', '2', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2363', '22', '1', '2', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2364', '22', '1', '2', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2365', '22', '1', '2', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2366', '22', '1', '2', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2367', '22', '1', '2', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2368', '22', '1', '2', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2369', '22', '1', '2', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2370', '22', '1', '2', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2371', '22', '1', '2', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2372', '22', '1', '2', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2373', '22', '1', '2', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2374', '22', '1', '2', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2375', '22', '1', '2', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2376', '22', '2', '3', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2377', '22', '1', '3', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2378', '22', '1', '3', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2379', '22', '1', '3', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2380', '22', '1', '3', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2381', '22', '1', '3', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2382', '22', '1', '3', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2383', '22', '1', '3', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2384', '22', '1', '3', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2385', '22', '1', '3', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2386', '22', '1', '3', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2387', '22', '1', '3', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2388', '22', '1', '3', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2389', '22', '1', '3', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2390', '22', '1', '3', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2391', '22', '2', '4', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2392', '22', '1', '4', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2393', '22', '1', '4', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2394', '22', '1', '4', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2395', '22', '1', '4', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2396', '22', '1', '4', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2397', '22', '1', '4', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2398', '22', '1', '4', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2399', '22', '1', '4', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2400', '22', '1', '4', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2401', '22', '1', '4', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2402', '22', '1', '4', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2403', '22', '1', '4', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2404', '22', '1', '4', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2405', '22', '1', '4', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2406', '22', '2', '5', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2407', '22', '1', '5', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2408', '22', '1', '5', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2409', '22', '1', '5', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2410', '22', '1', '5', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2411', '22', '1', '5', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2412', '22', '1', '5', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2413', '22', '1', '5', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2414', '22', '1', '5', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2415', '22', '1', '5', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2416', '22', '1', '5', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2417', '22', '1', '5', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2418', '22', '1', '5', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2419', '22', '1', '5', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2420', '22', '1', '5', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2421', '22', '2', '6', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2422', '22', '1', '6', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2423', '22', '1', '6', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2424', '22', '1', '6', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2425', '22', '1', '6', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2426', '22', '1', '6', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2427', '22', '1', '6', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2428', '22', '1', '6', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2429', '22', '1', '6', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2430', '22', '1', '6', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2431', '22', '1', '6', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2432', '22', '1', '6', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2433', '22', '1', '6', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2434', '22', '1', '6', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2435', '22', '1', '6', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2436', '22', '2', '7', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2437', '22', '1', '7', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2438', '22', '1', '7', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2439', '22', '1', '7', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2440', '22', '1', '7', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2441', '22', '1', '7', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2442', '22', '1', '7', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2443', '22', '1', '7', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2444', '22', '1', '7', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2445', '22', '1', '7', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2446', '22', '1', '7', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2447', '22', '1', '7', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2448', '22', '1', '7', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2449', '22', '1', '7', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2450', '22', '1', '7', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2451', '22', '2', '8', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2452', '22', '1', '8', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2453', '22', '1', '8', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2454', '22', '1', '8', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2455', '22', '1', '8', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2456', '22', '1', '8', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2457', '22', '1', '8', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2458', '22', '1', '8', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2459', '22', '1', '8', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2460', '22', '1', '8', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2461', '22', '1', '8', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2462', '22', '1', '8', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2463', '22', '1', '8', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2464', '22', '1', '8', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2465', '22', '1', '8', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2466', '22', '2', '9', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2467', '22', '1', '9', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2468', '22', '1', '9', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2469', '22', '1', '9', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2470', '22', '1', '9', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2471', '22', '1', '9', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2472', '22', '1', '9', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2473', '22', '1', '9', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2474', '22', '1', '9', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2475', '22', '1', '9', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2476', '22', '1', '9', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2477', '22', '1', '9', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2478', '22', '1', '9', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2479', '22', '1', '9', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2480', '22', '1', '9', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2481', '22', '2', '10', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2482', '22', '1', '10', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2483', '22', '1', '10', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2484', '22', '1', '10', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2485', '22', '1', '10', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2486', '22', '1', '10', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2487', '22', '1', '10', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2488', '22', '1', '10', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2489', '22', '1', '10', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2490', '22', '1', '10', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2491', '22', '1', '10', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2492', '22', '1', '10', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2493', '22', '1', '10', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2494', '22', '1', '10', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2495', '22', '1', '10', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2656', '25', '2', '1', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2657', '25', '1', '1', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2658', '25', '1', '1', '3', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2659', '25', '1', '1', '4', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2660', '25', '1', '1', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2661', '25', '1', '1', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2662', '25', '1', '1', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2663', '25', '1', '1', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2664', '25', '1', '1', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2665', '25', '1', '1', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2666', '25', '1', '1', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2667', '25', '1', '1', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2668', '25', '1', '1', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2669', '25', '1', '1', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2670', '25', '1', '1', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2671', '25', '2', '2', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2672', '25', '1', '2', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2673', '25', '1', '2', '3', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2674', '25', '1', '2', '4', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2675', '25', '1', '2', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2676', '25', '1', '2', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2677', '25', '1', '2', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2678', '25', '1', '2', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2679', '25', '1', '2', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2680', '25', '1', '2', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2681', '25', '1', '2', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2682', '25', '1', '2', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2683', '25', '1', '2', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2684', '25', '1', '2', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2685', '25', '1', '2', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2686', '25', '2', '3', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2687', '25', '1', '3', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2688', '25', '1', '3', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2689', '25', '1', '3', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2690', '25', '1', '3', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2691', '25', '1', '3', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2692', '25', '1', '3', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2693', '25', '1', '3', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2694', '25', '1', '3', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2695', '25', '1', '3', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2696', '25', '1', '3', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2697', '25', '1', '3', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2698', '25', '1', '3', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2699', '25', '1', '3', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2700', '25', '1', '3', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2701', '25', '2', '4', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2702', '25', '1', '4', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2703', '25', '1', '4', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2704', '25', '1', '4', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2705', '25', '1', '4', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2706', '25', '1', '4', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2707', '25', '1', '4', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2708', '25', '1', '4', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2709', '25', '1', '4', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2710', '25', '1', '4', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2711', '25', '1', '4', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2712', '25', '1', '4', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2713', '25', '1', '4', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2714', '25', '1', '4', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2715', '25', '1', '4', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2716', '25', '2', '5', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2717', '25', '1', '5', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2718', '25', '1', '5', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2719', '25', '1', '5', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2720', '25', '1', '5', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2721', '25', '1', '5', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2722', '25', '1', '5', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2723', '25', '1', '5', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2724', '25', '1', '5', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2725', '25', '1', '5', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2726', '25', '1', '5', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2727', '25', '1', '5', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2728', '25', '1', '5', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2729', '25', '1', '5', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2730', '25', '1', '5', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2731', '25', '2', '6', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2732', '25', '1', '6', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2733', '25', '1', '6', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2734', '25', '1', '6', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2735', '25', '1', '6', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2736', '25', '1', '6', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2737', '25', '1', '6', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2738', '25', '1', '6', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2739', '25', '1', '6', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2740', '25', '1', '6', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2741', '25', '1', '6', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2742', '25', '1', '6', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2743', '25', '1', '6', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2744', '25', '1', '6', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2745', '25', '1', '6', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2746', '25', '2', '7', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2747', '25', '1', '7', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2748', '25', '1', '7', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2749', '25', '1', '7', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2750', '25', '1', '7', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2751', '25', '1', '7', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2752', '25', '1', '7', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2753', '25', '1', '7', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2754', '25', '1', '7', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2755', '25', '1', '7', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2756', '25', '1', '7', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2757', '25', '1', '7', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2758', '25', '1', '7', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2759', '25', '1', '7', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2760', '25', '1', '7', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2761', '25', '2', '8', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2762', '25', '1', '8', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2763', '25', '1', '8', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2764', '25', '1', '8', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2765', '25', '1', '8', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2766', '25', '1', '8', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2767', '25', '1', '8', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2768', '25', '1', '8', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2769', '25', '1', '8', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2770', '25', '1', '8', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2771', '25', '1', '8', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2772', '25', '1', '8', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2773', '25', '1', '8', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2774', '25', '1', '8', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2775', '25', '1', '8', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2776', '25', '2', '9', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2777', '25', '1', '9', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2778', '25', '1', '9', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2779', '25', '1', '9', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2780', '25', '1', '9', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2781', '25', '1', '9', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2782', '25', '1', '9', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2783', '25', '1', '9', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2784', '25', '1', '9', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2785', '25', '1', '9', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2786', '25', '1', '9', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2787', '25', '1', '9', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2788', '25', '1', '9', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2789', '25', '1', '9', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2790', '25', '1', '9', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2791', '25', '2', '10', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2792', '25', '1', '10', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2793', '25', '1', '10', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2794', '25', '1', '10', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2795', '25', '1', '10', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2796', '25', '1', '10', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2797', '25', '1', '10', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2798', '25', '1', '10', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2799', '25', '1', '10', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2800', '25', '1', '10', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2801', '25', '1', '10', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2802', '25', '1', '10', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2803', '25', '1', '10', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2804', '25', '1', '10', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2805', '25', '1', '10', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2866', '27', '2', '1', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2867', '27', '1', '1', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2868', '27', '1', '1', '3', '1', '1');
INSERT INTO `r_lecture_seat` VALUES ('2869', '27', '1', '1', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2870', '27', '1', '1', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2871', '27', '1', '1', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2872', '27', '1', '1', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2873', '27', '1', '1', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2874', '27', '1', '1', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2875', '27', '1', '1', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2876', '27', '1', '1', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2877', '27', '1', '1', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2878', '27', '1', '1', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2879', '27', '1', '1', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2880', '27', '1', '1', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2881', '27', '2', '2', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2882', '27', '1', '2', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2883', '27', '1', '2', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2884', '27', '1', '2', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2885', '27', '1', '2', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2886', '27', '1', '2', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2887', '27', '1', '2', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2888', '27', '1', '2', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2889', '27', '1', '2', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2890', '27', '1', '2', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2891', '27', '1', '2', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2892', '27', '1', '2', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2893', '27', '1', '2', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2894', '27', '1', '2', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2895', '27', '1', '2', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2896', '27', '2', '3', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2897', '27', '1', '3', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2898', '27', '1', '3', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2899', '27', '1', '3', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2900', '27', '1', '3', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2901', '27', '1', '3', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2902', '27', '1', '3', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2903', '27', '1', '3', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2904', '27', '1', '3', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2905', '27', '1', '3', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2906', '27', '1', '3', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2907', '27', '1', '3', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2908', '27', '1', '3', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2909', '27', '1', '3', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2910', '27', '1', '3', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2911', '27', '2', '4', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2912', '27', '1', '4', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2913', '27', '1', '4', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2914', '27', '1', '4', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2915', '27', '1', '4', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2916', '27', '1', '4', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2917', '27', '1', '4', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2918', '27', '1', '4', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2919', '27', '1', '4', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2920', '27', '1', '4', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2921', '27', '1', '4', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2922', '27', '1', '4', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2923', '27', '1', '4', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2924', '27', '1', '4', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2925', '27', '1', '4', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2926', '27', '2', '5', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2927', '27', '1', '5', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2928', '27', '1', '5', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2929', '27', '1', '5', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2930', '27', '1', '5', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2931', '27', '1', '5', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2932', '27', '1', '5', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2933', '27', '1', '5', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2934', '27', '1', '5', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2935', '27', '1', '5', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2936', '27', '1', '5', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2937', '27', '1', '5', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2938', '27', '1', '5', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2939', '27', '1', '5', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2940', '27', '1', '5', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2941', '27', '2', '6', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2942', '27', '1', '6', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2943', '27', '1', '6', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2944', '27', '1', '6', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2945', '27', '1', '6', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2946', '27', '1', '6', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2947', '27', '1', '6', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2948', '27', '1', '6', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2949', '27', '1', '6', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2950', '27', '1', '6', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2951', '27', '1', '6', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2952', '27', '1', '6', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2953', '27', '1', '6', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2954', '27', '1', '6', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2955', '27', '1', '6', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2956', '27', '2', '7', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2957', '27', '1', '7', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2958', '27', '1', '7', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2959', '27', '1', '7', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2960', '27', '1', '7', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2961', '27', '1', '7', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2962', '27', '1', '7', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2963', '27', '1', '7', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2964', '27', '1', '7', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2965', '27', '1', '7', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2966', '27', '1', '7', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2967', '27', '1', '7', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2968', '27', '1', '7', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2969', '27', '1', '7', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2970', '27', '1', '7', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2971', '27', '2', '8', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2972', '27', '1', '8', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2973', '27', '1', '8', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2974', '27', '1', '8', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2975', '27', '1', '8', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2976', '27', '1', '8', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2977', '27', '1', '8', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2978', '27', '1', '8', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2979', '27', '1', '8', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2980', '27', '1', '8', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2981', '27', '1', '8', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2982', '27', '1', '8', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2983', '27', '1', '8', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2984', '27', '1', '8', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2985', '27', '1', '8', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2986', '27', '2', '9', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2987', '27', '1', '9', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2988', '27', '1', '9', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2989', '27', '1', '9', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2990', '27', '1', '9', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2991', '27', '1', '9', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2992', '27', '1', '9', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2993', '27', '1', '9', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2994', '27', '1', '9', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2995', '27', '1', '9', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2996', '27', '1', '9', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2997', '27', '1', '9', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2998', '27', '1', '9', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('2999', '27', '1', '9', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3000', '27', '1', '9', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3001', '27', '2', '10', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3002', '27', '1', '10', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3003', '27', '1', '10', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3004', '27', '1', '10', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3005', '27', '1', '10', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3006', '27', '1', '10', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3007', '27', '1', '10', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3008', '27', '1', '10', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3009', '27', '1', '10', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3010', '27', '1', '10', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3011', '27', '1', '10', '11', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3012', '27', '1', '10', '12', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3013', '27', '1', '10', '13', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3014', '27', '1', '10', '14', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3015', '27', '1', '10', '15', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3816', '26', '1', '1', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3817', '26', '1', '1', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3818', '26', '1', '1', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3819', '26', '1', '1', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3820', '26', '1', '1', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3821', '26', '1', '1', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3822', '26', '1', '1', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3823', '26', '1', '1', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3824', '26', '1', '1', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3825', '26', '1', '1', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3826', '26', '1', '2', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3827', '26', '1', '2', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3828', '26', '1', '2', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3829', '26', '1', '2', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3830', '26', '1', '2', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3831', '26', '1', '2', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3832', '26', '1', '2', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3833', '26', '1', '2', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3834', '26', '1', '2', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3835', '26', '1', '2', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3836', '26', '1', '3', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3837', '26', '1', '3', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3838', '26', '1', '3', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3839', '26', '1', '3', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3840', '26', '1', '3', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3841', '26', '1', '3', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3842', '26', '1', '3', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3843', '26', '1', '3', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3844', '26', '1', '3', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3845', '26', '1', '3', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3846', '26', '1', '4', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3847', '26', '1', '4', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3848', '26', '1', '4', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3849', '26', '1', '4', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3850', '26', '1', '4', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3851', '26', '1', '4', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3852', '26', '1', '4', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3853', '26', '1', '4', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3854', '26', '1', '4', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3855', '26', '1', '4', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3856', '26', '1', '5', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3857', '26', '1', '5', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3858', '26', '1', '5', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3859', '26', '1', '5', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3860', '26', '1', '5', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3861', '26', '1', '5', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3862', '26', '1', '5', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3863', '26', '1', '5', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3864', '26', '1', '5', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3865', '26', '1', '5', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3866', '26', '1', '6', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3867', '26', '1', '6', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3868', '26', '1', '6', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3869', '26', '1', '6', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3870', '26', '1', '6', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3871', '26', '1', '6', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3872', '26', '1', '6', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3873', '26', '1', '6', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3874', '26', '1', '6', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3875', '26', '1', '6', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3876', '26', '1', '7', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3877', '26', '1', '7', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3878', '26', '1', '7', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3879', '26', '1', '7', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3880', '26', '1', '7', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3881', '26', '1', '7', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3882', '26', '1', '7', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3883', '26', '1', '7', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3884', '26', '1', '7', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3885', '26', '1', '7', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3886', '26', '1', '8', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3887', '26', '1', '8', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3888', '26', '1', '8', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3889', '26', '1', '8', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3890', '26', '1', '8', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3891', '26', '1', '8', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3892', '26', '1', '8', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3893', '26', '1', '8', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3894', '26', '1', '8', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3895', '26', '1', '8', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3896', '26', '1', '9', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3897', '26', '1', '9', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3898', '26', '1', '9', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3899', '26', '1', '9', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3900', '26', '1', '9', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3901', '26', '1', '9', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3902', '26', '1', '9', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3903', '26', '1', '9', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3904', '26', '1', '9', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3905', '26', '1', '9', '10', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3906', '26', '1', '10', '1', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3907', '26', '1', '10', '2', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3908', '26', '1', '10', '3', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3909', '26', '1', '10', '4', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3910', '26', '1', '10', '5', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3911', '26', '1', '10', '6', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3912', '26', '1', '10', '7', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3913', '26', '1', '10', '8', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3914', '26', '1', '10', '9', '1', '0');
INSERT INTO `r_lecture_seat` VALUES ('3915', '26', '1', '10', '10', '1', '0');

-- ----------------------------
-- Table structure for r_operation_record
-- ----------------------------
DROP TABLE IF EXISTS `r_operation_record`;
CREATE TABLE `r_operation_record` (
  `record_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `lecture_id` int(11) NOT NULL,
  `operation_time` datetime NOT NULL,
  `operation_type` int(255) NOT NULL,
  `object` int(11) NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `r_operation_record_lecture_id` (`lecture_id`),
  KEY `r_operation_record_student_id` (`student_id`),
  CONSTRAINT `r_operation_record_lecture_id` FOREIGN KEY (`lecture_id`) REFERENCES `t_lecture_info` (`lecture_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `r_operation_record_student_id` FOREIGN KEY (`student_id`) REFERENCES `t_student_info` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of r_operation_record
-- ----------------------------
INSERT INTO `r_operation_record` VALUES ('1', '1', '2', '2019-12-12 13:25:55', '0', '1');
INSERT INTO `r_operation_record` VALUES ('8', '1', '2', '2019-12-12 16:16:26', '0', '1');
INSERT INTO `r_operation_record` VALUES ('9', '2', '19', '2019-12-15 14:03:08', '0', '0');
INSERT INTO `r_operation_record` VALUES ('10', '2', '2', '2019-12-16 16:52:18', '0', '1');
INSERT INTO `r_operation_record` VALUES ('17', '3', '19', '2019-12-17 14:12:25', '0', '0');
INSERT INTO `r_operation_record` VALUES ('18', '1', '19', '2019-12-17 14:12:26', '0', '0');
INSERT INTO `r_operation_record` VALUES ('19', '5', '19', '2019-12-17 14:12:28', '0', '0');
INSERT INTO `r_operation_record` VALUES ('21', '3', '3', '2019-12-17 20:06:52', '0', '0');
INSERT INTO `r_operation_record` VALUES ('22', '3', '3', '2019-12-17 20:10:08', '1', '0');
INSERT INTO `r_operation_record` VALUES ('23', '1', '2', '2019-12-17 23:15:52', '0', '0');
INSERT INTO `r_operation_record` VALUES ('24', '2', '2', '2019-12-17 23:15:53', '0', '0');
INSERT INTO `r_operation_record` VALUES ('25', '3', '3', '2019-12-18 01:30:42', '0', '0');
INSERT INTO `r_operation_record` VALUES ('26', '2', '3', '2019-12-18 01:30:45', '0', '0');
INSERT INTO `r_operation_record` VALUES ('27', '3', '3', '2019-12-18 01:37:51', '0', '0');
INSERT INTO `r_operation_record` VALUES ('28', '2', '3', '2019-12-18 01:37:54', '0', '0');
INSERT INTO `r_operation_record` VALUES ('29', '3', '3', '2019-12-18 01:39:51', '0', '0');
INSERT INTO `r_operation_record` VALUES ('30', '2', '3', '2019-12-18 01:39:53', '0', '0');
INSERT INTO `r_operation_record` VALUES ('31', '3', '3', '2019-12-18 01:43:40', '0', '0');
INSERT INTO `r_operation_record` VALUES ('32', '2', '3', '2019-12-18 01:43:42', '0', '0');
INSERT INTO `r_operation_record` VALUES ('33', '4', '3', '2019-12-18 01:43:45', '0', '0');
INSERT INTO `r_operation_record` VALUES ('34', '3', '20', '2019-12-18 14:11:35', '0', '0');
INSERT INTO `r_operation_record` VALUES ('35', '1', '20', '2019-12-18 14:11:36', '0', '0');
INSERT INTO `r_operation_record` VALUES ('36', '5', '20', '2019-12-18 14:11:37', '0', '0');
INSERT INTO `r_operation_record` VALUES ('37', '3', '20', '2019-12-18 14:11:57', '1', '0');
INSERT INTO `r_operation_record` VALUES ('38', '3', '20', '2019-12-18 14:31:42', '0', '0');
INSERT INTO `r_operation_record` VALUES ('39', '3', '20', '2019-12-18 14:31:54', '1', '0');
INSERT INTO `r_operation_record` VALUES ('40', '3', '21', '2019-12-18 14:38:58', '0', '0');
INSERT INTO `r_operation_record` VALUES ('41', '1', '21', '2019-12-18 14:39:01', '0', '0');
INSERT INTO `r_operation_record` VALUES ('42', '2', '21', '2019-12-18 14:39:03', '0', '0');
INSERT INTO `r_operation_record` VALUES ('43', '3', '20', '2019-12-19 10:14:00', '0', '0');
INSERT INTO `r_operation_record` VALUES ('44', '3', '21', '2019-12-19 10:24:04', '0', '0');
INSERT INTO `r_operation_record` VALUES ('45', '3', '21', '2019-12-19 11:52:59', '0', '0');
INSERT INTO `r_operation_record` VALUES ('46', '5', '21', '2019-12-19 11:53:00', '0', '0');
INSERT INTO `r_operation_record` VALUES ('47', '3', '21', '2019-12-19 13:41:50', '0', '0');
INSERT INTO `r_operation_record` VALUES ('48', '1', '21', '2019-12-19 13:41:51', '0', '0');
INSERT INTO `r_operation_record` VALUES ('49', '2', '21', '2019-12-19 13:41:52', '0', '0');
INSERT INTO `r_operation_record` VALUES ('50', '3', '22', '2019-12-19 14:00:12', '0', '0');
INSERT INTO `r_operation_record` VALUES ('51', '3', '21', '2019-12-19 14:01:42', '0', '0');
INSERT INTO `r_operation_record` VALUES ('52', '5', '21', '2019-12-19 14:01:43', '0', '0');
INSERT INTO `r_operation_record` VALUES ('53', '3', '25', '2019-12-19 14:18:03', '0', '0');
INSERT INTO `r_operation_record` VALUES ('54', '5', '25', '2019-12-19 14:18:04', '0', '0');
INSERT INTO `r_operation_record` VALUES ('55', '2', '25', '2019-12-19 14:18:05', '0', '0');
INSERT INTO `r_operation_record` VALUES ('56', '3', '25', '2019-12-19 14:18:32', '1', '0');
INSERT INTO `r_operation_record` VALUES ('57', '3', '25', '2019-12-19 14:20:00', '0', '0');
INSERT INTO `r_operation_record` VALUES ('58', '1', '25', '2019-12-19 14:20:01', '0', '0');
INSERT INTO `r_operation_record` VALUES ('59', '3', '27', '2019-12-19 14:27:57', '0', '0');
INSERT INTO `r_operation_record` VALUES ('60', '1', '27', '2019-12-19 14:27:58', '0', '0');
INSERT INTO `r_operation_record` VALUES ('61', '3', '27', '2019-12-19 14:28:15', '1', '0');

-- ----------------------------
-- Table structure for r_student_accomplishment
-- ----------------------------
DROP TABLE IF EXISTS `r_student_accomplishment`;
CREATE TABLE `r_student_accomplishment` (
  `student_id` int(11) NOT NULL,
  `lecture_id` int(11) NOT NULL,
  `operate_time` datetime NOT NULL,
  PRIMARY KEY (`student_id`,`lecture_id`),
  KEY `lecture_id` (`lecture_id`),
  CONSTRAINT `lecture_id` FOREIGN KEY (`lecture_id`) REFERENCES `t_lecture_info` (`lecture_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_id` FOREIGN KEY (`student_id`) REFERENCES `t_student_info` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of r_student_accomplishment
-- ----------------------------
INSERT INTO `r_student_accomplishment` VALUES ('1', '2', '2019-12-13 22:14:53');
INSERT INTO `r_student_accomplishment` VALUES ('2', '2', '2019-12-18 15:05:53');
INSERT INTO `r_student_accomplishment` VALUES ('2', '19', '2019-12-17 19:11:56');
INSERT INTO `r_student_accomplishment` VALUES ('3', '19', '2019-12-19 13:53:17');

-- ----------------------------
-- Table structure for r_student_collection
-- ----------------------------
DROP TABLE IF EXISTS `r_student_collection`;
CREATE TABLE `r_student_collection` (
  `student_id` int(11) NOT NULL,
  `lecture_id` int(11) NOT NULL,
  PRIMARY KEY (`student_id`,`lecture_id`),
  KEY `collection_lecture_id` (`lecture_id`),
  CONSTRAINT `collection_lecture_id` FOREIGN KEY (`lecture_id`) REFERENCES `t_lecture_info` (`lecture_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `collection_student_id` FOREIGN KEY (`student_id`) REFERENCES `t_student_info` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of r_student_collection
-- ----------------------------
INSERT INTO `r_student_collection` VALUES ('3', '2');
INSERT INTO `r_student_collection` VALUES ('3', '3');
INSERT INTO `r_student_collection` VALUES ('3', '19');
INSERT INTO `r_student_collection` VALUES ('3', '20');
INSERT INTO `r_student_collection` VALUES ('3', '21');
INSERT INTO `r_student_collection` VALUES ('3', '22');
INSERT INTO `r_student_collection` VALUES ('3', '25');

-- ----------------------------
-- Table structure for r_student_operation
-- ----------------------------
DROP TABLE IF EXISTS `r_student_operation`;
CREATE TABLE `r_student_operation` (
  `operation_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `lecture_id` int(11) NOT NULL,
  `seat_id` int(11) NOT NULL,
  `ticket_code` varchar(255) NOT NULL,
  `operate_time` datetime NOT NULL,
  `is_delete` int(11) NOT NULL COMMENT '0：未取消，1：取消 ',
  PRIMARY KEY (`operation_id`),
  KEY `operation_student_id` (`student_id`),
  KEY `operation_lecture_id` (`lecture_id`),
  KEY `operation_seat_id` (`seat_id`),
  CONSTRAINT `operation_lecture_id` FOREIGN KEY (`lecture_id`) REFERENCES `t_lecture_info` (`lecture_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operation_seat_id` FOREIGN KEY (`seat_id`) REFERENCES `r_lecture_seat` (`lecture_seat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operation_student_id` FOREIGN KEY (`student_id`) REFERENCES `t_student_info` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of r_student_operation
-- ----------------------------
INSERT INTO `r_student_operation` VALUES ('3', '2', '3', '812', '666', '2019-12-12 16:16:26', '0');
INSERT INTO `r_student_operation` VALUES ('4', '2', '2', '813', '888', '2019-12-13 20:41:32', '0');
INSERT INTO `r_student_operation` VALUES ('5', '1', '2', '815', '886', '2019-12-13 20:41:32', '0');
INSERT INTO `r_student_operation` VALUES ('6', '2', '2', '816', '999', '2019-12-16 16:52:18', '1');
INSERT INTO `r_student_operation` VALUES ('14', '3', '19', '2061', '144000', '2019-12-17 14:12:25', '0');
INSERT INTO `r_student_operation` VALUES ('15', '1', '19', '2062', '146000', '2019-12-17 14:12:26', '0');
INSERT INTO `r_student_operation` VALUES ('16', '5', '19', '2063', '147000', '2019-12-17 14:12:28', '0');
INSERT INTO `r_student_operation` VALUES ('21', '3', '3', '2128', '46190', '2019-12-18 01:43:39', '0');
INSERT INTO `r_student_operation` VALUES ('22', '4', '3', '2130', '46240', '2019-12-18 01:43:44', '0');
INSERT INTO `r_student_operation` VALUES ('23', '3', '20', '2133', '494940', '2019-12-18 14:11:35', '0');
INSERT INTO `r_student_operation` VALUES ('24', '1', '20', '2134', '494950', '2019-12-18 14:11:36', '0');
INSERT INTO `r_student_operation` VALUES ('25', '5', '20', '2135', '494960', '2019-12-18 14:11:37', '0');
INSERT INTO `r_student_operation` VALUES ('32', '3', '21', '2205', '734109', '2019-12-19 13:41:50', '0');
INSERT INTO `r_student_operation` VALUES ('33', '1', '21', '2206', '734110', '2019-12-19 13:41:51', '0');
INSERT INTO `r_student_operation` VALUES ('34', '2', '21', '2207', '734111', '2019-12-19 13:41:52', '0');
INSERT INTO `r_student_operation` VALUES ('35', '3', '22', '2347', '735212', '2019-12-19 14:00:12', '0');
INSERT INTO `r_student_operation` VALUES ('36', '5', '21', '2209', '735302', '2019-12-19 14:01:43', '0');
INSERT INTO `r_student_operation` VALUES ('37', '3', '25', '2657', '736282', '2019-12-19 14:18:03', '0');
INSERT INTO `r_student_operation` VALUES ('38', '5', '25', '2658', '736283', '2019-12-19 14:18:04', '0');
INSERT INTO `r_student_operation` VALUES ('39', '2', '25', '2659', '736284', '2019-12-19 14:18:05', '0');
INSERT INTO `r_student_operation` VALUES ('40', '1', '25', '2674', '736401', '2019-12-19 14:20:01', '0');
INSERT INTO `r_student_operation` VALUES ('41', '3', '27', '2867', '736876', '2019-12-19 14:27:57', '1');
INSERT INTO `r_student_operation` VALUES ('42', '1', '27', '2868', '736878', '2019-12-19 14:27:58', '0');

-- ----------------------------
-- Table structure for r_student_relationship
-- ----------------------------
DROP TABLE IF EXISTS `r_student_relationship`;
CREATE TABLE `r_student_relationship` (
  `main_student_id` int(11) NOT NULL,
  `fellow_student_id` int(11) NOT NULL,
  PRIMARY KEY (`main_student_id`,`fellow_student_id`),
  CONSTRAINT `relationship_student_id` FOREIGN KEY (`main_student_id`) REFERENCES `t_student_info` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of r_student_relationship
-- ----------------------------
INSERT INTO `r_student_relationship` VALUES ('1', '2');
INSERT INTO `r_student_relationship` VALUES ('3', '1');
INSERT INTO `r_student_relationship` VALUES ('3', '2');
INSERT INTO `r_student_relationship` VALUES ('3', '5');
INSERT INTO `r_student_relationship` VALUES ('4', '3');
INSERT INTO `r_student_relationship` VALUES ('5', '3');

-- ----------------------------
-- Table structure for t_administrator_info
-- ----------------------------
DROP TABLE IF EXISTS `t_administrator_info`;
CREATE TABLE `t_administrator_info` (
  `administrator_id` int(11) NOT NULL AUTO_INCREMENT,
  `administrator_name` varchar(255) NOT NULL,
  `administrator_password` varchar(255) NOT NULL,
  `administrator_no` varchar(255) NOT NULL,
  `img` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`administrator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_administrator_info
-- ----------------------------
INSERT INTO `t_administrator_info` VALUES ('1', '形政管理员', '123456', '100000', '/images/admin/bnuz.jpg');

-- ----------------------------
-- Table structure for t_classroom_info
-- ----------------------------
DROP TABLE IF EXISTS `t_classroom_info`;
CREATE TABLE `t_classroom_info` (
  `classroom_id` int(11) NOT NULL AUTO_INCREMENT,
  `building` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `row_num` int(11) NOT NULL,
  `column_num` int(11) NOT NULL,
  `capacity` int(11) NOT NULL,
  PRIMARY KEY (`classroom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_classroom_info
-- ----------------------------
INSERT INTO `t_classroom_info` VALUES ('1', '乐育楼', 'A102', '10', '6', '60');
INSERT INTO `t_classroom_info` VALUES ('2', '励耘楼', 'A111', '40', '20', '800');
INSERT INTO `t_classroom_info` VALUES ('5', '丽泽楼', 'C106', '10', '10', '100');
INSERT INTO `t_classroom_info` VALUES ('7', '励教楼', 'c203', '8', '8', '64');
INSERT INTO `t_classroom_info` VALUES ('11', '弘文楼', 'A203', '6', '6', '36');
INSERT INTO `t_classroom_info` VALUES ('12', '丽泽楼', 'A203', '6', '6', '36');
INSERT INTO `t_classroom_info` VALUES ('13', '丽泽楼', 'A206', '6', '6', '36');
INSERT INTO `t_classroom_info` VALUES ('14', '丽泽楼', 'A102', '10', '10', '100');
INSERT INTO `t_classroom_info` VALUES ('15', '丽泽楼', 'C206', '10', '10', '100');
INSERT INTO `t_classroom_info` VALUES ('16', '木铎楼', 'A207', '10', '10', '100');
INSERT INTO `t_classroom_info` VALUES ('17', '图书馆', 'A101', '10', '10', '100');
INSERT INTO `t_classroom_info` VALUES ('18', '图书馆', 'B101', '10', '10', '100');
INSERT INTO `t_classroom_info` VALUES ('19', '南国剧场', 'A101', '10', '10', '100');
INSERT INTO `t_classroom_info` VALUES ('20', '木铎楼', 'C402', '8', '8', '64');
INSERT INTO `t_classroom_info` VALUES ('21', '木铎楼', 'C403', '6', '6', '36');
INSERT INTO `t_classroom_info` VALUES ('22', '乐育楼', 'A101', '10', '10', '100');
INSERT INTO `t_classroom_info` VALUES ('23', '乐育楼', 'C101', '10', '10', '100');
INSERT INTO `t_classroom_info` VALUES ('24', '乐育楼', 'D101', '10', '10', '100');
INSERT INTO `t_classroom_info` VALUES ('25', '乐育楼', 'F101', '10', '10', '100');
INSERT INTO `t_classroom_info` VALUES ('28', '图书馆', 'B505', '10', '15', '150');
INSERT INTO `t_classroom_info` VALUES ('29', '木铎楼', 'C405', '8', '8', '64');
INSERT INTO `t_classroom_info` VALUES ('30', '丽泽楼', 'B202', '10', '10', '100');

-- ----------------------------
-- Table structure for t_lecture_info
-- ----------------------------
DROP TABLE IF EXISTS `t_lecture_info`;
CREATE TABLE `t_lecture_info` (
  `lecture_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `teacher` varchar(255) NOT NULL,
  `introduction` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `classroom_id` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `total_seats_num` int(11) NOT NULL,
  `seats_selected_num` int(11) NOT NULL,
  `application_deadline` datetime NOT NULL,
  PRIMARY KEY (`lecture_id`),
  KEY `lectureInfo_classroom_id` (`classroom_id`),
  CONSTRAINT `lectureInfo_classroom_id` FOREIGN KEY (`classroom_id`) REFERENCES `t_classroom_info` (`classroom_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_lecture_info
-- ----------------------------
INSERT INTO `t_lecture_info` VALUES ('2', '软件测试1', '程努华', 'emmm,一言难尽的讲座', '/images/avatar/admin/postImage/bnuz.jpg', '1', '2019-12-02 09:35:00', '2019-12-02 11:30:00', '100', '2', '2019-12-06 12:32:08');
INSERT INTO `t_lecture_info` VALUES ('3', '中国四大传统节日 · 春节', '撒贝宁', '春节，即农历新年，是一年之岁首、传统意义上的岁节（年节）。', '/images/lecture/chun.jpg', '1', '2019-12-01 19:00:00', '2019-12-01 21:00:00', '60', '19', '2019-12-01 18:00:00');
INSERT INTO `t_lecture_info` VALUES ('15', '安卓讲座', '小勇哥', '究极无聊的讲座', '/images/avatar/admin/postImage/bnuz.jpg', '25', '2019-12-16 19:00:00', '2019-12-16 20:30:00', '100', '10', '2019-12-12 00:00:00');
INSERT INTO `t_lecture_info` VALUES ('19', '一个讲座', '一个教师', '一个介绍', '/images/lecture/chun.jpg', '28', '2019-12-13 19:00:00', '2019-12-13 21:00:00', '100', '26', '2019-12-13 19:00:00');
INSERT INTO `t_lecture_info` VALUES ('20', '前端框架技术讲座', '许跃颖', '无', '/images/avatar/admin/postImage/bnuz.jpg', '29', '2019-12-19 15:35:00', '2019-12-19 17:10:00', '64', '4', '2019-12-19 12:00:00');
INSERT INTO `t_lecture_info` VALUES ('21', '一个个讲座', '一个个老师', '一个一个介绍', '/images/avatar/admin/postImage/bnuz.jpg', '28', '2019-12-20 19:00:00', '2019-12-20 21:00:00', '150', '12', '2019-12-20 18:00:00');
INSERT INTO `t_lecture_info` VALUES ('22', '前端框架技术2', '许跃颖', '一个讲座介绍', '/images/avatar/admin/postImage/bnuz.jpg', '28', '2019-12-20 19:00:00', '2019-12-20 21:00:00', '150', '11', '2019-12-20 18:00:00');
INSERT INTO `t_lecture_info` VALUES ('25', '测试', '四讲武', 'acacia', '/images/avatar/admin/postImage/bnuz.jpg', '28', '2019-12-21 19:00:00', '2019-12-21 21:00:00', '150', '4', '2019-12-21 18:00:00');
INSERT INTO `t_lecture_info` VALUES ('26', 'testLecture', 'testTeacher', 'testInfo', '/images/avatar/admin/postImage/1576737407077.jpg', '5', '2019-12-19 00:00:00', '2019-12-19 00:00:00', '100', '0', '2019-12-19 00:00:00');
INSERT INTO `t_lecture_info` VALUES ('27', '中国四大传统节日 · 春节（二）', '撒贝宁', '春节，即农历新年，是一年之岁首、传统意义上的岁节（年节）。', '/images/avatar/admin/postImage/1576736763330.jpg', '28', '2019-12-21 19:00:00', '2019-12-21 21:00:00', '150', '1', '2019-12-21 18:00:00');

-- ----------------------------
-- Table structure for t_seat_type
-- ----------------------------
DROP TABLE IF EXISTS `t_seat_type`;
CREATE TABLE `t_seat_type` (
  `seat_type` int(11) NOT NULL COMMENT '1：座位，2：过道',
  `type_name` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `is_show` int(11) NOT NULL,
  PRIMARY KEY (`seat_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_seat_type
-- ----------------------------
INSERT INTO `t_seat_type` VALUES ('1', '普通座位', '/images/seat/type/1.png', '1');
INSERT INTO `t_seat_type` VALUES ('2', '预留座位', '/images/', '1');

-- ----------------------------
-- Table structure for t_student_info
-- ----------------------------
DROP TABLE IF EXISTS `t_student_info`;
CREATE TABLE `t_student_info` (
  `student_id` int(11) NOT NULL AUTO_INCREMENT,
  `student_no` int(11) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` int(11) NOT NULL COMMENT '0：女，1：男',
  `grade` int(11) NOT NULL,
  `faculty` varchar(255) NOT NULL,
  `major` varchar(255) NOT NULL,
  `lectures_num` int(11) NOT NULL,
  `id_no` varchar(255) NOT NULL,
  `student_password` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `friend_code` int(11) NOT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_student_info
-- ----------------------------
INSERT INTO `t_student_info` VALUES ('1', '1701030000', '李雷', '1', '2017', '信息技术学院', '软件工程', '1', '440307201911266666', '123456', '/images/avatar/monkey.png', '13531411');
INSERT INTO `t_student_info` VALUES ('2', '1701030006', '韩梅梅', '0', '2017', '信息技术学院', '计算机科学与技术', '2', '440666666666666666', '123456', '/images/avatar/user/1576674297162.jpg', '14152625');
INSERT INTO `t_student_info` VALUES ('3', '1801030009', '陈然', '0', '2018', '信息技术学院', '计算机科学与技术', '1', '440300666688868888', '123', '/images/avatar/user/1576737653832.jpg', '31562122');
INSERT INTO `t_student_info` VALUES ('4', '1701030111', '李白', '1', '2017', '信息技术学院', '软件工程', '1', '440888201911306668', '123456', '/images/avatar/bnuz.jpg', '42144141');
INSERT INTO `t_student_info` VALUES ('5', '1801030119', '孙宇', '1', '2018', '信息技术学院', '数字媒体与技术', '0', '440777777777777777', '123', '/images/avatar/user/1575541602180.jpg', '78434376');
INSERT INTO `t_student_info` VALUES ('7', '1702030666', '余淮', '1', '2017', '信息技术学院', '软件工程', '0', '440666666666666666', '123456', '/images/avatar/bnuz.png', '64654878');

-- ----------------------------
-- Table structure for t_student_protection
-- ----------------------------
DROP TABLE IF EXISTS `t_student_protection`;
CREATE TABLE `t_student_protection` (
  `protection_student_id` int(11) NOT NULL,
  `question_1` varchar(255) NOT NULL,
  `question_2` varchar(255) NOT NULL,
  `question_3` varchar(255) NOT NULL,
  `answer_1` varchar(255) NOT NULL,
  `answer_2` varchar(255) NOT NULL,
  `answer_3` varchar(255) NOT NULL,
  PRIMARY KEY (`protection_student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_student_protection
-- ----------------------------
INSERT INTO `t_student_protection` VALUES ('1', '1', '2', '3', '4', '5', '6');
INSERT INTO `t_student_protection` VALUES ('2', '1', '2', '3', '1', '1', '1');
INSERT INTO `t_student_protection` VALUES ('3', '我的宠物小狗名是？', '我的喵喵名是？', '我的小蛇名是？', '小狗', '小猫', '小蛇');
