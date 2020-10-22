# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.5-10.4.13-MariaDB)
# Database: homes
# Generation Time: 2020-07-18 04:57:12 +0000
# ************************************************************

SET NAMES utf8;

CREATE DATABASE test;
CREATE DATABASE homes;

USE homes;

# Dump of table Bank
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Bank`;

CREATE TABLE `Bank` (
  `BankIdx` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `BankName` varchar(50) DEFAULT NULL COMMENT '은행명',
  `Grade` char(1) DEFAULT NULL COMMENT '등급',
  `CreateDate` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '생성일',
  `UpdateDate` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '수정일',
  PRIMARY KEY (`BankIdx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

# Dump of table BankBook
# ------------------------------------------------------------

DROP TABLE IF EXISTS `BankBook`;

CREATE TABLE `BankBook` (
  `BankBookIdx` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `MemberIdx` int(11) DEFAULT NULL COMMENT 'Member FK',
  `HomeIdx` int(11) DEFAULT NULL COMMENT 'Home FK',
  `BankIdx` int(11) DEFAULT NULL COMMENT 'Bank FK',
  `BankBookTypeIdx` int(11) DEFAULT NULL COMMENT '통장 유형 FK',
  `BankBookName` varchar(50) DEFAULT NULL COMMENT '통장 명',
  `AcountNumber` varchar(50) DEFAULT NULL COMMENT '계좌번호',
  `TotalAmount` double DEFAULT 0 COMMENT '총 금액',
  `OpenDate` date DEFAULT NULL COMMENT '개설일자',
  `CloseDate` date DEFAULT NULL COMMENT '만기일',
  `CreateDate` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '생성일',
  `UpdateDate` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '수정일',
  PRIMARY KEY (`BankBookIdx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

# Dump of table BankBookDetail
# ------------------------------------------------------------

DROP TABLE IF EXISTS `BankBookDetail`;

CREATE TABLE `BankBookDetail` (
  `BankBookDetailIdx` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `BankBookIdx` int(11) DEFAULT NULL COMMENT 'BankBook FK',
  `HomeIdx` int(11) DEFAULT NULL COMMENT 'Home FK',
  `Category1Idx` int(11) DEFAULT NULL COMMENT '분류1 FK',
  `Category2Idx` int(11) DEFAULT NULL COMMENT '분류2 FK',
  `Category3Idx` int(11) DEFAULT NULL COMMENT '분류3 FK',
  `Content` varchar(200) DEFAULT NULL COMMENT '상세내역',
  `Amount` double DEFAULT NULL COMMENT '금액',
  `AmountType` char(3) DEFAULT NULL COMMENT '유형 (입금, 출금)',
  `AmountDate` date DEFAULT NULL COMMENT '입출금 일자',
  `CreateDate` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`BankBookDetailIdx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


# Dump of table BankBookMapping
# ------------------------------------------------------------

DROP TABLE IF EXISTS `BankBookMapping`;

CREATE TABLE `BankBookMapping` (
  `BankBookMappingIdx` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `MemberIdx` int(11) DEFAULT NULL COMMENT 'Member FK',
  `BankBookIdx` int(11) DEFAULT NULL COMMENT 'BankBook FK',
  `HomeIdx` int(11) DEFAULT NULL COMMENT 'Home FK',
  PRIMARY KEY (`BankBookMappingIdx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


# Dump of table BankBookStatistics
# ------------------------------------------------------------

DROP TABLE IF EXISTS `BankBookStatistics`;

CREATE TABLE `BankBookStatistics` (
  `StatisticsIdx` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `HomeIdx` int(11) DEFAULT NULL,
  `StatisticsDate` timestamp NULL DEFAULT NULL COMMENT '정산 날짜',
  `StatisticsRealDate` varchar(6) DEFAULT NULL COMMENT '실제 정산 날짜',
  `IncomeAmount` double DEFAULT NULL COMMENT '수입 총 금액',
  `SpendingAmount` double DEFAULT NULL COMMENT '지출 총 금액',
  `RemainingAmount` double DEFAULT NULL COMMENT '남은 총 금액',
  `CreateDate` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`StatisticsIdx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


# Dump of table BankBookStatisticsDetail
# ------------------------------------------------------------

DROP TABLE IF EXISTS `BankBookStatisticsDetail`;

CREATE TABLE `BankBookStatisticsDetail` (
  `StatisticsDetailIdx` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `StatisticsIdx` int(11) DEFAULT NULL COMMENT 'BankBookStatistics FK',
  `CategoryIdx` int(11) DEFAULT NULL COMMENT 'Category FK',
  `AmountType` char(3) DEFAULT NULL COMMENT '금액 유형',
  `Amount` double DEFAULT NULL COMMENT '금액',
  PRIMARY KEY (`StatisticsDetailIdx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


# Dump of table BankBookType
# ------------------------------------------------------------

DROP TABLE IF EXISTS `BankBookType`;

CREATE TABLE `BankBookType` (
  `BankBookTypeIdx` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(50) DEFAULT NULL COMMENT '유형 명',
  `TypeCode` char(2) DEFAULT NULL COMMENT '유형 코드',
  `Remark` varchar(50) DEFAULT NULL COMMENT '비고',
  PRIMARY KEY (`BankBookTypeIdx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


# Dump of table Category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Category`;

CREATE TABLE `Category` (
  `CategoryIdx` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `CategoryName` varchar(50) DEFAULT NULL COMMENT '분류 명',
  `CategoryCode` varchar(20) DEFAULT NULL COMMENT '분류 코드',
  `Level` int(11) DEFAULT NULL COMMENT '레벨',
  `ParentIdx` int(11) DEFAULT NULL COMMENT '부모 PK',
  `CreateDate` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '생성일',
  `UpdateDate` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '수정일',
  PRIMARY KEY (`CategoryIdx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


# Dump of table CheckList
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CheckList`;

CREATE TABLE `CheckList` (
  `CheckListIdx` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `CheckMemoIdx` int(11) DEFAULT NULL COMMENT 'CheckMemo FK',
  `IsChecked` char(1) DEFAULT '0' COMMENT '체크 여부',
  `Title` varchar(200) DEFAULT NULL COMMENT '체크 제목',
  `Content` text DEFAULT NULL COMMENT '체크 상세 내용',
  `CreateDate` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '생성일',
  PRIMARY KEY (`CheckListIdx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


# Dump of table CheckMemo
# ------------------------------------------------------------

DROP TABLE IF EXISTS `CheckMemo`;

CREATE TABLE `CheckMemo` (
  `CheckMemoIdx` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `HomeIdx` int(11) DEFAULT NULL COMMENT 'Home FK',
  `Memo` text DEFAULT NULL COMMENT '비고',
  PRIMARY KEY (`CheckMemoIdx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


# Dump of table Home
# ------------------------------------------------------------

# Error: Incorrect information in file: './homes/home.frm'


# Dump of table Member
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Member`;

CREATE TABLE `Member` (
  `MemberIdx` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `HomeIdx` int(11) DEFAULT NULL COMMENT 'Home FK',
  `MemberName` varchar(10) DEFAULT NULL COMMENT '구성원 이름',
  `MemberId` varchar(50) DEFAULT NULL COMMENT '아이디',
  `Password` varchar(50) DEFAULT NULL COMMENT '비밀번호',
  `CreateDate` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '생성일',
  `UpdateDate` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '수정일',
  PRIMARY KEY (`MemberIdx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

COMMIT;
