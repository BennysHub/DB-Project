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


### Order of Dropping Tables

- `teaching`: Depends on `course`, `lecturer`, and `student`.
- `advising`: Depends on `lecturer` and `student`.
- `lecturer_in_department`: Depends on `departments` and `lecturer`.
- `lectures`: Depends on `lecturer`, `course`, `building`, and `room`.
- `assingments`: Depends on `course`.
- `departments`: Depends on `building` and `person`.
- `lecturer`: Depends on `person`.
- `student`: Depends on `person`.
- `course`: No dependencies.
- `room`: Depends on `building`.
- `building`: No dependencies.
- `person`: No dependencies.

This ensures that the tables are dropped in the correct sequence without violating foreign key constraints.