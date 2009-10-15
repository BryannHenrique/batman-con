/*
SQLyog Community Edition- MySQL GUI v8.12 
MySQL - 5.0.75-0ubuntu10.2 : Database - springbatch
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`springbatch` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `springbatch`;

/*Table structure for table `BATCH_JOB_EXECUTION` */

DROP TABLE IF EXISTS `BATCH_JOB_EXECUTION`;

CREATE TABLE `BATCH_JOB_EXECUTION` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) default NULL,
  `JOB_INSTANCE_ID` bigint(20) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `START_TIME` datetime default NULL,
  `END_TIME` datetime default NULL,
  `STATUS` varchar(10) default NULL,
  `EXIT_CODE` varchar(20) default NULL,
  `EXIT_MESSAGE` varchar(2500) default NULL,
  `LAST_UPDATED` datetime default NULL,
  PRIMARY KEY  (`JOB_EXECUTION_ID`),
  KEY `JOB_INST_EXEC_FK` (`JOB_INSTANCE_ID`),
  CONSTRAINT `JOB_INST_EXEC_FK` FOREIGN KEY (`JOB_INSTANCE_ID`) REFERENCES `BATCH_JOB_INSTANCE` (`JOB_INSTANCE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `BATCH_JOB_EXECUTION` */

insert  into `BATCH_JOB_EXECUTION`(`JOB_EXECUTION_ID`,`VERSION`,`JOB_INSTANCE_ID`,`CREATE_TIME`,`START_TIME`,`END_TIME`,`STATUS`,`EXIT_CODE`,`EXIT_MESSAGE`,`LAST_UPDATED`) values (43,1,39,'2009-10-04 18:37:52','2009-10-04 18:37:52','2009-10-04 18:37:52','STARTING','UNKNOWN','','2009-10-04 18:37:52'),(44,0,39,'2009-10-04 15:37:52','2009-10-04 16:37:52',NULL,'STARTING','UNKNOWN','','2009-10-04 18:37:52');

/*Table structure for table `BATCH_JOB_EXECUTION_CONTEXT` */

DROP TABLE IF EXISTS `BATCH_JOB_EXECUTION_CONTEXT`;

CREATE TABLE `BATCH_JOB_EXECUTION_CONTEXT` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `SHORT_CONTEXT` varchar(2500) NOT NULL,
  `SERIALIZED_CONTEXT` text,
  PRIMARY KEY  (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_CTX_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `BATCH_JOB_EXECUTION` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `BATCH_JOB_EXECUTION_CONTEXT` */

insert  into `BATCH_JOB_EXECUTION_CONTEXT`(`JOB_EXECUTION_ID`,`SHORT_CONTEXT`,`SERIALIZED_CONTEXT`) values (43,'{\"map\":\"\"}',NULL),(44,'{\"map\":\"\"}',NULL);

/*Table structure for table `BATCH_JOB_EXECUTION_SEQ` */

DROP TABLE IF EXISTS `BATCH_JOB_EXECUTION_SEQ`;

CREATE TABLE `BATCH_JOB_EXECUTION_SEQ` (
  `ID` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `BATCH_JOB_EXECUTION_SEQ` */

insert  into `BATCH_JOB_EXECUTION_SEQ`(`ID`) values (44);

/*Table structure for table `BATCH_JOB_INSTANCE` */

DROP TABLE IF EXISTS `BATCH_JOB_INSTANCE`;

CREATE TABLE `BATCH_JOB_INSTANCE` (
  `JOB_INSTANCE_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) default NULL,
  `JOB_NAME` varchar(100) NOT NULL,
  `JOB_KEY` varchar(32) NOT NULL,
  PRIMARY KEY  (`JOB_INSTANCE_ID`),
  UNIQUE KEY `JOB_INST_UN` (`JOB_NAME`,`JOB_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `BATCH_JOB_INSTANCE` */

insert  into `BATCH_JOB_INSTANCE`(`JOB_INSTANCE_ID`,`VERSION`,`JOB_NAME`,`JOB_KEY`) values (39,0,'spam','d41d8cd98f00b204e9800998ecf8427e');

/*Table structure for table `BATCH_JOB_PARAMS` */

DROP TABLE IF EXISTS `BATCH_JOB_PARAMS`;

CREATE TABLE `BATCH_JOB_PARAMS` (
  `JOB_INSTANCE_ID` bigint(20) NOT NULL,
  `TYPE_CD` varchar(6) NOT NULL,
  `KEY_NAME` varchar(100) NOT NULL,
  `STRING_VAL` varchar(250) default NULL,
  `DATE_VAL` datetime default NULL,
  `LONG_VAL` bigint(20) default NULL,
  `DOUBLE_VAL` double default NULL,
  KEY `JOB_INST_PARAMS_FK` (`JOB_INSTANCE_ID`),
  CONSTRAINT `JOB_INST_PARAMS_FK` FOREIGN KEY (`JOB_INSTANCE_ID`) REFERENCES `BATCH_JOB_INSTANCE` (`JOB_INSTANCE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `BATCH_JOB_PARAMS` */

insert  into `BATCH_JOB_PARAMS`(`JOB_INSTANCE_ID`,`TYPE_CD`,`KEY_NAME`,`STRING_VAL`,`DATE_VAL`,`LONG_VAL`,`DOUBLE_VAL`) values (39,'STRING','prefix','TS',NULL,NULL,NULL),(39,'DATE','rundate',NULL,'2009-10-05 14:30:08',NULL,NULL);

/*Table structure for table `BATCH_JOB_SEQ` */

DROP TABLE IF EXISTS `BATCH_JOB_SEQ`;

CREATE TABLE `BATCH_JOB_SEQ` (
  `ID` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `BATCH_JOB_SEQ` */

insert  into `BATCH_JOB_SEQ`(`ID`) values (39);

/*Table structure for table `BATCH_STAGING` */

DROP TABLE IF EXISTS `BATCH_STAGING`;

CREATE TABLE `BATCH_STAGING` (
  `ID` bigint(20) NOT NULL,
  `JOB_ID` bigint(20) NOT NULL,
  `VALUE` blob NOT NULL,
  `PROCESSED` char(1) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `BATCH_STAGING` */

/*Table structure for table `BATCH_STAGING_SEQ` */

DROP TABLE IF EXISTS `BATCH_STAGING_SEQ`;

CREATE TABLE `BATCH_STAGING_SEQ` (
  `ID` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `BATCH_STAGING_SEQ` */

insert  into `BATCH_STAGING_SEQ`(`ID`) values (18);

/*Table structure for table `BATCH_STEP_EXECUTION` */

DROP TABLE IF EXISTS `BATCH_STEP_EXECUTION`;

CREATE TABLE `BATCH_STEP_EXECUTION` (
  `STEP_EXECUTION_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) NOT NULL,
  `STEP_NAME` varchar(100) NOT NULL,
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `START_TIME` datetime NOT NULL,
  `END_TIME` datetime default NULL,
  `STATUS` varchar(10) default NULL,
  `COMMIT_COUNT` bigint(20) default NULL,
  `READ_COUNT` bigint(20) default NULL,
  `FILTER_COUNT` bigint(20) default NULL,
  `WRITE_COUNT` bigint(20) default NULL,
  `READ_SKIP_COUNT` bigint(20) default NULL,
  `WRITE_SKIP_COUNT` bigint(20) default NULL,
  `PROCESS_SKIP_COUNT` bigint(20) default NULL,
  `ROLLBACK_COUNT` bigint(20) default NULL,
  `EXIT_CODE` varchar(20) default NULL,
  `EXIT_MESSAGE` varchar(2500) default NULL,
  `LAST_UPDATED` datetime default NULL,
  PRIMARY KEY  (`STEP_EXECUTION_ID`),
  KEY `JOB_EXEC_STEP_FK` (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_STEP_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `BATCH_JOB_EXECUTION` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `BATCH_STEP_EXECUTION` */

insert  into `BATCH_STEP_EXECUTION`(`STEP_EXECUTION_ID`,`VERSION`,`STEP_NAME`,`JOB_EXECUTION_ID`,`START_TIME`,`END_TIME`,`STATUS`,`COMMIT_COUNT`,`READ_COUNT`,`FILTER_COUNT`,`WRITE_COUNT`,`READ_SKIP_COUNT`,`WRITE_SKIP_COUNT`,`PROCESS_SKIP_COUNT`,`ROLLBACK_COUNT`,`EXIT_CODE`,`EXIT_MESSAGE`,`LAST_UPDATED`) values (1,0,'STEP1',44,'2009-10-01 00:00:00','2009-10-01 00:00:00','STARTING',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-10-01 00:00:00'),(2,0,'STEP1',43,'2009-10-02 00:00:00',NULL,'STARTING',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-10-01 00:00:00'),(3,0,'STEP2',44,'2009-10-01 00:00:00',NULL,'STARTING',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2009-10-01 00:00:00');

/*Table structure for table `BATCH_STEP_EXECUTION_CONTEXT` */

DROP TABLE IF EXISTS `BATCH_STEP_EXECUTION_CONTEXT`;

CREATE TABLE `BATCH_STEP_EXECUTION_CONTEXT` (
  `STEP_EXECUTION_ID` bigint(20) NOT NULL,
  `SHORT_CONTEXT` varchar(2500) NOT NULL,
  `SERIALIZED_CONTEXT` text,
  PRIMARY KEY  (`STEP_EXECUTION_ID`),
  CONSTRAINT `STEP_EXEC_CTX_FK` FOREIGN KEY (`STEP_EXECUTION_ID`) REFERENCES `BATCH_STEP_EXECUTION` (`STEP_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `BATCH_STEP_EXECUTION_CONTEXT` */

/*Table structure for table `BATCH_STEP_EXECUTION_SEQ` */

DROP TABLE IF EXISTS `BATCH_STEP_EXECUTION_SEQ`;

CREATE TABLE `BATCH_STEP_EXECUTION_SEQ` (
  `ID` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `BATCH_STEP_EXECUTION_SEQ` */

insert  into `BATCH_STEP_EXECUTION_SEQ`(`ID`) values (53);

/*Table structure for table `CUSTOMER` */

DROP TABLE IF EXISTS `CUSTOMER`;

CREATE TABLE `CUSTOMER` (
  `ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) default NULL,
  `NAME` varchar(45) default NULL,
  `CREDIT` decimal(8,2) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `CUSTOMER` */

insert  into `CUSTOMER`(`ID`,`VERSION`,`NAME`,`CREDIT`) values (1,0,'customer1','100000.00'),(2,0,'customer2','100000.00'),(3,0,'customer3','100000.00'),(4,0,'customer4','100000.00'),(5,0,'customer5','100000.00'),(6,0,'customer6','100000.00'),(7,0,'customer7','100000.00'),(8,0,'customer8','100000.00'),(9,0,'customer9','100000.00');

/*Table structure for table `CUSTOMER_SEQ` */

DROP TABLE IF EXISTS `CUSTOMER_SEQ`;

CREATE TABLE `CUSTOMER_SEQ` (
  `ID` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `CUSTOMER_SEQ` */

insert  into `CUSTOMER_SEQ`(`ID`) values (0);

/*Table structure for table `ERROR_LOG` */

DROP TABLE IF EXISTS `ERROR_LOG`;

CREATE TABLE `ERROR_LOG` (
  `JOB_NAME` char(20) default NULL,
  `STEP_NAME` char(20) default NULL,
  `MESSAGE` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ERROR_LOG` */

/*Table structure for table `GAMES` */

DROP TABLE IF EXISTS `GAMES`;

CREATE TABLE `GAMES` (
  `PLAYER_ID` char(8) NOT NULL,
  `YEAR_NO` bigint(20) NOT NULL,
  `TEAM` char(3) NOT NULL,
  `WEEK` bigint(20) NOT NULL,
  `OPPONENT` char(3) default NULL,
  `COMPLETES` bigint(20) default NULL,
  `ATTEMPTS` bigint(20) default NULL,
  `PASSING_YARDS` bigint(20) default NULL,
  `PASSING_TD` bigint(20) default NULL,
  `INTERCEPTIONS` bigint(20) default NULL,
  `RUSHES` bigint(20) default NULL,
  `RUSH_YARDS` bigint(20) default NULL,
  `RECEPTIONS` bigint(20) default NULL,
  `RECEPTIONS_YARDS` bigint(20) default NULL,
  `TOTAL_TD` bigint(20) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `GAMES` */

/*Table structure for table `PLAYERS` */

DROP TABLE IF EXISTS `PLAYERS`;

CREATE TABLE `PLAYERS` (
  `PLAYER_ID` char(8) NOT NULL,
  `LAST_NAME` varchar(35) NOT NULL,
  `FIRST_NAME` varchar(25) NOT NULL,
  `POS` varchar(10) default NULL,
  `YEAR_OF_BIRTH` bigint(20) NOT NULL,
  `YEAR_DRAFTED` bigint(20) NOT NULL,
  PRIMARY KEY  (`PLAYER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `PLAYERS` */

/*Table structure for table `PLAYER_SUMMARY` */

DROP TABLE IF EXISTS `PLAYER_SUMMARY`;

CREATE TABLE `PLAYER_SUMMARY` (
  `ID` char(8) NOT NULL,
  `YEAR_NO` bigint(20) NOT NULL,
  `COMPLETES` bigint(20) NOT NULL,
  `ATTEMPTS` bigint(20) NOT NULL,
  `PASSING_YARDS` bigint(20) NOT NULL,
  `PASSING_TD` bigint(20) NOT NULL,
  `INTERCEPTIONS` bigint(20) NOT NULL,
  `RUSHES` bigint(20) NOT NULL,
  `RUSH_YARDS` bigint(20) NOT NULL,
  `RECEPTIONS` bigint(20) NOT NULL,
  `RECEPTIONS_YARDS` bigint(20) NOT NULL,
  `TOTAL_TD` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `PLAYER_SUMMARY` */

/*Table structure for table `TRADE` */

DROP TABLE IF EXISTS `TRADE`;

CREATE TABLE `TRADE` (
  `ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) default NULL,
  `ISIN` varchar(45) NOT NULL,
  `QUANTITY` bigint(20) default NULL,
  `PRICE` decimal(8,2) default NULL,
  `CUSTOMER` varchar(45) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `TRADE` */

/*Table structure for table `TRADE_SEQ` */

DROP TABLE IF EXISTS `TRADE_SEQ`;

CREATE TABLE `TRADE_SEQ` (
  `ID` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `TRADE_SEQ` */

insert  into `TRADE_SEQ`(`ID`) values (10);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
