/*
Navicat MySQL Data Transfer

Source Server         : 47.103.35.105
Source Server Version : 50728
Source Host           : 47.103.35.105:3306
Source Database       : web_demo

Target Server Type    : MYSQL
Target Server Version : 50728
File Encoding         : 65001

Date: 2019-12-26 21:59:04
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
