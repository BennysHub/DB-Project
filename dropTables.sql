-- dropTables.sql

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `teaching`;
DROP TABLE IF EXISTS `advising`;
DROP TABLE IF EXISTS `lecturer_in_department`;
DROP TABLE IF EXISTS `lectures`;
DROP TABLE IF EXISTS `assingments`;
DROP TABLE IF EXISTS `departments`;
DROP TABLE IF EXISTS `lecturer`;
DROP TABLE IF EXISTS `student`;
DROP TABLE IF EXISTS `course`;
DROP TABLE IF EXISTS `room`;
DROP TABLE IF EXISTS `building`;
DROP TABLE IF EXISTS `person`;

SET FOREIGN_KEY_CHECKS = 1;
