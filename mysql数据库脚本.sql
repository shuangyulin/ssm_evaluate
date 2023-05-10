-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_colleage` (
  `colleageNumber` varchar(50)  NOT NULL COMMENT 'colleageNumber',
  `colleageName` varchar(60)  NOT NULL COMMENT '学院名称',
  PRIMARY KEY (`colleageNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_classInfo` (
  `classNumber` varchar(50)  NOT NULL COMMENT 'classNumber',
  `className` varchar(100)  NOT NULL COMMENT '班级名称',
  `colleageObj` varchar(50)  NOT NULL COMMENT '所在学院',
  `banzhuren` varchar(30)  NULL COMMENT '班主任',
  `startDate` varchar(20)  NULL COMMENT '开办日期',
  PRIMARY KEY (`classNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_student` (
  `studentNumber` varchar(40)  NOT NULL COMMENT 'studentNumber',
  `password` varchar(50)  NOT NULL COMMENT '登录密码',
  `classObj` varchar(50)  NOT NULL COMMENT '所在班级',
  `studentName` varchar(40)  NOT NULL COMMENT '姓名',
  `sex` varchar(4)  NOT NULL COMMENT '性别',
  `birthday` varchar(20)  NULL COMMENT '出生日期',
  `studentPhoto` varchar(60)  NOT NULL COMMENT '学生照片',
  `telephone` varchar(20)  NULL COMMENT '联系电话',
  `email` varchar(50)  NULL COMMENT '邮箱',
  PRIMARY KEY (`studentNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_course` (
  `courseNo` varchar(20)  NOT NULL COMMENT 'courseNo',
  `courseName` varchar(50)  NOT NULL COMMENT '课程名称',
  `courseType` varchar(20)  NOT NULL COMMENT '课程类型',
  `courseScore` float NOT NULL COMMENT '课程学分',
  `teacherName` varchar(20)  NOT NULL COMMENT '上课老师',
  `courseHour` int(11) NOT NULL COMMENT '课程总学时',
  PRIMARY KEY (`courseNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_courseScore` (
  `scoreId` int(11) NOT NULL AUTO_INCREMENT COMMENT '成绩id',
  `studentObj` varchar(40)  NOT NULL COMMENT '学生',
  `courseObj` varchar(20)  NOT NULL COMMENT '课程',
  `score` float NOT NULL COMMENT '成绩',
  PRIMARY KEY (`scoreId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_addScoreItem` (
  `itemId` int(11) NOT NULL AUTO_INCREMENT COMMENT '加分项目id',
  `itemName` varchar(20)  NOT NULL COMMENT '加分项目名称',
  `itemScore` float NOT NULL COMMENT '加分项目分数',
  PRIMARY KEY (`itemId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_studentAddScore` (
  `addScoreId` int(11) NOT NULL AUTO_INCREMENT COMMENT '加分id',
  `studenObj` varchar(40)  NOT NULL COMMENT '学生',
  `addScoreObj` int(11) NOT NULL COMMENT '加分项目',
  `proof` varchar(60)  NOT NULL COMMENT '证明材料',
  `shengQingShiJian` varchar(20)  NULL COMMENT '申请时间',
  `shenHeState` varchar(20)  NOT NULL COMMENT '审核状态',
  `shenHeTime` varchar(20)  NULL COMMENT '审核时间',
  PRIMARY KEY (`addScoreId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_finalScore` (
  `scoreId` int(11) NOT NULL AUTO_INCREMENT COMMENT '成绩id',
  `studentObj` varchar(40)  NOT NULL COMMENT '学生',
  `colleageObj` varchar(50)  NOT NULL COMMENT '学院',
  `classObj` varchar(50)  NOT NULL COMMENT '班级',
  `courseFinalScore` float NOT NULL COMMENT '科目成绩折算分',
  `finalAddScore` float NOT NULL COMMENT '各项目加分数',
  `finalScore` float NOT NULL COMMENT '总分',
  PRIMARY KEY (`scoreId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_teacher` (
  `teacherUserName` varchar(20)  NOT NULL COMMENT 'teacherUserName',
  `password` varchar(20)  NULL COMMENT '登录密码',
  `teacherName` varchar(20)  NOT NULL COMMENT '姓名',
  `sex` varchar(4)  NOT NULL COMMENT '性别',
  `birthday` varchar(20)  NULL COMMENT '出生日期',
  `telephone` varchar(20)  NULL COMMENT '联系电话',
  PRIMARY KEY (`teacherUserName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE t_classInfo ADD CONSTRAINT FOREIGN KEY (colleageObj) REFERENCES t_colleage(colleageNumber);
ALTER TABLE t_student ADD CONSTRAINT FOREIGN KEY (classObj) REFERENCES t_classInfo(classNumber);
ALTER TABLE t_courseScore ADD CONSTRAINT FOREIGN KEY (studentObj) REFERENCES t_student(studentNumber);
ALTER TABLE t_courseScore ADD CONSTRAINT FOREIGN KEY (courseObj) REFERENCES t_course(courseNo);
ALTER TABLE t_studentAddScore ADD CONSTRAINT FOREIGN KEY (studenObj) REFERENCES t_student(studentNumber);
ALTER TABLE t_studentAddScore ADD CONSTRAINT FOREIGN KEY (addScoreObj) REFERENCES t_addScoreItem(itemId);
ALTER TABLE t_finalScore ADD CONSTRAINT FOREIGN KEY (studentObj) REFERENCES t_student(studentNumber);
ALTER TABLE t_finalScore ADD CONSTRAINT FOREIGN KEY (colleageObj) REFERENCES t_colleage(colleageNumber);
ALTER TABLE t_finalScore ADD CONSTRAINT FOREIGN KEY (classObj) REFERENCES t_classInfo(classNumber);


