-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 17, 2024 at 02:48 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET FOREIGN_KEY_CHECKS=1;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `advising`
--

DROP TABLE IF EXISTS `advising`;
CREATE TABLE `advising` (
  `ADVISING_ID` int(11) UNSIGNED NOT NULL,
  `LECTURER_ID` varchar(9) NOT NULL,
  `STUDENT_ID` varchar(9) NOT NULL,
  `TIME_START` datetime NOT NULL,
  `TIME_END` datetime NOT NULL,
  `ADVISING_NOTES` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `advising`:
--   `LECTURER_ID`
--       `lecturers` -> `ID`
--   `STUDENT_ID`
--       `students` -> `ID`
--

-- --------------------------------------------------------

--
-- Table structure for table `assignments`
--

DROP TABLE IF EXISTS `assignments`;
CREATE TABLE `assignments` (
  `ASSINGMENT_ID` int(11) UNSIGNED NOT NULL,
  `COURSE_NUMBER` int(11) UNSIGNED NOT NULL,
  `ASSIGNMENT_NAME` varchar(50) NOT NULL,
  `DUE_DATETIME` datetime NOT NULL,
  `ADDITIONAL_INFO` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `assignments`:
--   `COURSE_NUMBER`
--       `courses` -> `COURSE_NUMBER`
--

-- --------------------------------------------------------

--
-- Table structure for table `buildings`
--

DROP TABLE IF EXISTS `buildings`;
CREATE TABLE `buildings` (
  `ID` int(3) UNSIGNED NOT NULL,
  `NAME` varchar(35) NOT NULL,
  `DESCRIPTION` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `buildings`:
--

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `COURSE_NUMBER` int(11) UNSIGNED NOT NULL,
  `NAME` varchar(30) NOT NULL,
  `CREDITS` decimal(2,1) UNSIGNED NOT NULL,
  `WEEKLY_HOURS` decimal(2,1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `courses`:
--

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments` (
  `DEPARTMENT_ID` int(3) UNSIGNED NOT NULL,
  `DEPARTMENT_NAME` varchar(30) NOT NULL,
  `DEPARTMENT_PHONE` varchar(15) NOT NULL,
  `BUILDING_ID` int(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `departments`:
--   `BUILDING_ID`
--       `buildings` -> `ID`
--

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `GROUP_ID` int(11) NOT NULL,
  `LECTURER_ID` varchar(9) NOT NULL,
  `COURSE_NUMBER` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `groups`:
--   `COURSE_NUMBER`
--       `courses` -> `COURSE_NUMBER`
--   `LECTURER_ID`
--       `lecturers` -> `ID`
--

-- --------------------------------------------------------

--
-- Table structure for table `head_of_department`
--

DROP TABLE IF EXISTS `head_of_department`;
CREATE TABLE `head_of_department` (
  `DEPARTMENT_HEAD` varchar(9) NOT NULL,
  `DEPARTMENT_ID` int(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `head_of_department`:
--   `DEPARTMENT_HEAD`
--       `lecturers` -> `ID`
--   `DEPARTMENT_ID`
--       `departments` -> `DEPARTMENT_ID`
--

-- --------------------------------------------------------

--
-- Table structure for table `lecturers`
--

DROP TABLE IF EXISTS `lecturers`;
CREATE TABLE `lecturers` (
  `ID` varchar(9) NOT NULL,
  `SALARY` int(11) DEFAULT 0,
  `HIRE_DATE` date NOT NULL,
  `QUALIFICATIONS` text NOT NULL
) ;

--
-- RELATIONSHIPS FOR TABLE `lecturers`:
--   `ID`
--       `person` -> `ID`
--

-- --------------------------------------------------------

--
-- Table structure for table `lecturer_in_department`
--

DROP TABLE IF EXISTS `lecturer_in_department`;
CREATE TABLE `lecturer_in_department` (
  `LECTURER_ID` varchar(9) NOT NULL,
  `DEPARTMENT_ID` int(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `lecturer_in_department`:
--   `DEPARTMENT_ID`
--       `departments` -> `DEPARTMENT_ID`
--   `LECTURER_ID`
--       `lecturers` -> `ID`
--

-- --------------------------------------------------------

--
-- Table structure for table `lectures`
--

DROP TABLE IF EXISTS `lectures`;
CREATE TABLE `lectures` (
  `LECTURE_ID` int(11) UNSIGNED NOT NULL,
  `GROUP_ID` int(11) NOT NULL,
  `START_TIME` datetime NOT NULL,
  `END_TIME` datetime NOT NULL,
  `BUILDING_ID` int(3) UNSIGNED NOT NULL,
  `ROOM_NUMBER` int(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `lectures`:
--   `BUILDING_ID`
--       `rooms` -> `BUILDING_ID`
--   `ROOM_NUMBER`
--       `rooms` -> `ROOM_NUMBER`
--   `GROUP_ID`
--       `groups` -> `GROUP_ID`
--

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
  `ID` varchar(9) NOT NULL,
  `FIRST_NAME` varchar(20) NOT NULL,
  `LAST_NAME` varchar(20) NOT NULL,
  `EMAIL` varchar(35) NOT NULL,
  `PHONE_NUMBER` varchar(20) NOT NULL,
  `ADDRESS` text NOT NULL,
  `BIRTH_DATE` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `person`:
--

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
CREATE TABLE `rooms` (
  `ROOM_NUMBER` int(3) UNSIGNED NOT NULL,
  `BUILDING_ID` int(3) UNSIGNED NOT NULL,
  `DESCRIPTION` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `rooms`:
--   `BUILDING_ID`
--       `buildings` -> `ID`
--

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
CREATE TABLE `students` (
  `ID` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `students`:
--   `ID`
--       `person` -> `ID`
--

-- --------------------------------------------------------

--
-- Table structure for table `students_in_groups`
--

DROP TABLE IF EXISTS `students_in_groups`;
CREATE TABLE `students_in_groups` (
  `GROUP_ID` int(11) NOT NULL,
  `STUDENT_ID` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- RELATIONSHIPS FOR TABLE `students_in_groups`:
--   `GROUP_ID`
--       `groups` -> `GROUP_ID`
--   `STUDENT_ID`
--       `students` -> `ID`
--

--
-- Indexes for dumped tables
--

--
-- Indexes for table `advising`
--
ALTER TABLE `advising`
  ADD PRIMARY KEY (`ADVISING_ID`),
  ADD UNIQUE KEY `LECTURER_ID` (`LECTURER_ID`,`STUDENT_ID`,`TIME_START`),
  ADD KEY `ADVISING_STUDENT_ID` (`STUDENT_ID`);

--
-- Indexes for table `assignments`
--
ALTER TABLE `assignments`
  ADD PRIMARY KEY (`ASSINGMENT_ID`),
  ADD UNIQUE KEY `COURSE_NUMBER` (`COURSE_NUMBER`,`ASSIGNMENT_NAME`);

--
-- Indexes for table `buildings`
--
ALTER TABLE `buildings`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`COURSE_NUMBER`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`DEPARTMENT_ID`),
  ADD KEY `DEPARTMENT_BUILDING_ID` (`BUILDING_ID`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`GROUP_ID`),
  ADD KEY `COURSE_NUMBER` (`COURSE_NUMBER`),
  ADD KEY `LECTURER_ID` (`LECTURER_ID`);

--
-- Indexes for table `head_of_department`
--
ALTER TABLE `head_of_department`
  ADD PRIMARY KEY (`DEPARTMENT_HEAD`,`DEPARTMENT_ID`),
  ADD KEY `head_of_department_ibfk_2` (`DEPARTMENT_ID`);

--
-- Indexes for table `lecturers`
--
ALTER TABLE `lecturers`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `lecturer_in_department`
--
ALTER TABLE `lecturer_in_department`
  ADD PRIMARY KEY (`LECTURER_ID`,`DEPARTMENT_ID`),
  ADD KEY `lecturer_in_department_ibfk_1` (`DEPARTMENT_ID`);

--
-- Indexes for table `lectures`
--
ALTER TABLE `lectures`
  ADD PRIMARY KEY (`LECTURE_ID`),
  ADD KEY `LECTUR_IS_IN_BUILDING_ID` (`BUILDING_ID`,`ROOM_NUMBER`),
  ADD KEY `GROUP_ID` (`GROUP_ID`);

--
-- Indexes for table `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`ROOM_NUMBER`,`BUILDING_ID`),
  ADD KEY `ROOM_IN_BUILDING` (`BUILDING_ID`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `students_in_groups`
--
ALTER TABLE `students_in_groups`
  ADD PRIMARY KEY (`GROUP_ID`,`STUDENT_ID`),
  ADD KEY `STUDENT_ID` (`STUDENT_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `advising`
--
ALTER TABLE `advising`
  MODIFY `ADVISING_ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assignments`
--
ALTER TABLE `assignments`
  MODIFY `ASSINGMENT_ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `GROUP_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lectures`
--
ALTER TABLE `lectures`
  MODIFY `LECTURE_ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

-- Constraints for table `advising`
--
ALTER TABLE `advising`
  ADD CONSTRAINT `fk_advising_lecturer` FOREIGN KEY (`LECTURER_ID`) REFERENCES `lecturers` (`ID`),
  ADD CONSTRAINT `fk_advising_student` FOREIGN KEY (`STUDENT_ID`) REFERENCES `students` (`ID`),
  ADD CONSTRAINT `chk_advising_time` CHECK (TIME_END > TIME_START);

-- Constraints for table `assignments`
--
ALTER TABLE `assignments`
  ADD CONSTRAINT `fk_assignment_course` FOREIGN KEY (`COURSE_NUMBER`) REFERENCES `courses` (`COURSE_NUMBER`);

-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `fk_department_building` FOREIGN KEY (`BUILDING_ID`) REFERENCES `buildings` (`ID`),
  ADD CONSTRAINT `chk_department_phone` CHECK (DEPARTMENT_PHONE REGEXP '^[0-9]{3}-[0-9]{3}-[0-9]{4}$');

-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `fk_group_course` FOREIGN KEY (`COURSE_NUMBER`) REFERENCES `courses` (`COURSE_NUMBER`),
  ADD CONSTRAINT `fk_group_lecturer` FOREIGN KEY (`LECTURER_ID`) REFERENCES `lecturers` (`ID`);

-- Constraints for table `head_of_department`
--
ALTER TABLE `head_of_department`
  ADD CONSTRAINT `fk_head_of_department_lecturer` FOREIGN KEY (`DEPARTMENT_HEAD`) REFERENCES `lecturers` (`ID`),
  ADD CONSTRAINT `fk_head_of_department_department` FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `departments` (`DEPARTMENT_ID`);

-- Constraints for table `lecturers`
--
ALTER TABLE `lecturers`
  ADD CONSTRAINT `fk_lecturer_person` FOREIGN KEY (`ID`) REFERENCES `person` (`ID`),
  ADD CONSTRAINT `chk_lecturer_salary` CHECK (SALARY >= 0);

-- Constraints for table `lecturer_in_department`
--
ALTER TABLE `lecturer_in_department`
  ADD CONSTRAINT `fk_lecturer_in_department_department` FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `departments` (`DEPARTMENT_ID`),
  ADD CONSTRAINT `fk_lecturer_in_department_lecturer` FOREIGN KEY (`LECTURER_ID`) REFERENCES `lecturers` (`ID`);

-- Constraints for table `lectures`
--
ALTER TABLE `lectures`
  ADD CONSTRAINT `fk_lecture_building_room` FOREIGN KEY (`BUILDING_ID`,`ROOM_NUMBER`) REFERENCES `rooms` (`BUILDING_ID`, `ROOM_NUMBER`),
  ADD CONSTRAINT `fk_lecture_group` FOREIGN KEY (`GROUP_ID`) REFERENCES `groups` (`GROUP_ID`),
  ADD CONSTRAINT `chk_lecture_time` CHECK (END_TIME > START_TIME);

-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `fk_room_building` FOREIGN KEY (`BUILDING_ID`) REFERENCES `buildings` (`ID`),
  ADD CONSTRAINT `chk_room_number` CHECK (ROOM_NUMBER > 0);

-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `fk_student_person` FOREIGN KEY (`ID`) REFERENCES `person` (`ID`);

-- Constraints for table `students_in_groups`
--
ALTER TABLE `students_in_groups`
  ADD CONSTRAINT `fk_students_in_groups_group` FOREIGN KEY (`GROUP_ID`) REFERENCES `groups` (`GROUP_ID`),
  ADD CONSTRAINT `fk_students_in_groups_student` FOREIGN KEY (`STUDENT_ID`) REFERENCES `students` (`ID`);

-- Additional Constraints for table `person`
--
ALTER TABLE `person`
  ADD CONSTRAINT `chk_person_email` CHECK (EMAIL REGEXP '^[^@\\s]+@[^@\\s]+(\\.[^@\\s]+)+$'),
  ADD CONSTRAINT `chk_person_phone` CHECK (PHONE_NUMBER REGEXP '^[0-9]{3}-[0-9]{3}-[0-9]{4}$');

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
