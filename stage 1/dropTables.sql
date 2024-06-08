-- dropTables.sql
SET FOREIGN_KEY_CHECKS = 1;
DROP TABLE IF EXISTS `head_of_department`;
DROP TABLE IF EXISTS `teaching`;
DROP TABLE IF EXISTS `advising`;
DROP TABLE IF EXISTS `lecturer_in_department`;
DROP TABLE IF EXISTS `lectures`;
DROP TABLE IF EXISTS `assingments`;
DROP TABLE IF EXISTS `departments`;
DROP TABLE IF EXISTS `courses`;
DROP TABLE IF EXISTS `rooms`;
DROP TABLE IF EXISTS `buildings`;
DROP TABLE IF EXISTS `lecturers`;
DROP TABLE IF EXISTS `students`;
DROP TABLE IF EXISTS `person`;




--### Order of Dropping Tables

-- `teaching`: Depends on `courses`, `lecturers`, and `students`.
-- `advising`: Depends on `lecturers` and `students`.
-- `lecturer_in_department`: Depends on `departments` and `lecturers`.
-- `lectures`: Depends on `lecturers`, `courses`, `buildings`, and `rooms`.
-- `assingments`: Depends on `courses`.
-- `departments`: Depends on `buildings` and `person`.
-- `lecturers`: Depends on `person`.
-- `students`: Depends on `person`.
-- `courses`: No dependencies.
-- `rooms`: Depends on `building`.
-- `buildings`: No dependencies.
-- `person`: No dependencies.

--###This ensures that the tables are dropped in the correct sequence without violating foreign key constraints.