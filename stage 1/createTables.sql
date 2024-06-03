-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 26, 2024 at 01:38 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

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

CREATE TABLE `advising` (
  `ADVISING_ID` int(11) UNSIGNED NOT NULL,
  `LECTURER_ID` int(9) UNSIGNED NOT NULL,
  `STUDENT_ID` int(9) UNSIGNED NOT NULL,
  `TIME_START` datetime NOT NULL,
  `TIME_END` datetime NOT NULL,
  `ADVISING_NOTES` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `assingments`
--

CREATE TABLE `assingments` (
  `ASSINGMENT_ID` int(10) UNSIGNED NOT NULL,
  `COURSE_NUMBER` int(10) UNSIGNED NOT NULL,
  `ASSIGMENT_NAME` varchar(50) NOT NULL,
  `DUE_DATETIME` datetime NOT NULL,
  `ADDITIONAL_INFO` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `building`
--

CREATE TABLE `building` (
  `ID` int(3) UNSIGNED NOT NULL,
  `NAME` varchar(20) NOT NULL,
  `DESCRIPTION` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `COURSE_NUMBER` int(11) UNSIGNED NOT NULL,
  `NAME` varchar(30) NOT NULL,
  `CREDITS` decimal(2,1) UNSIGNED NOT NULL,
  `WEEKLY_HOURS` decimal(2,1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `DEPARTMENT_ID` int(3) UNSIGNED NOT NULL,
  `DEPARTMENT_NAME` varchar(30) NOT NULL,
  `DEPARTMENT_PHONE` varchar(15) NOT NULL,
  `DEPARTMENT_HEAD` int(9) UNSIGNED NOT NULL,
  `BUILDING_ID` int(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lecturer`
--

CREATE TABLE `lecturer` (
  `ID` int(9) UNSIGNED NOT NULL,
  `SALARY` int(11) UNSIGNED NOT NULL,
  `QUALIFICATIONS` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lecturer_in_department`
--

CREATE TABLE `lecturer_in_department` (
  `LECTURE_ID` int(9) UNSIGNED NOT NULL,
  `DEPARTMENT_ID` int(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lectures`
--

CREATE TABLE `lectures` (
  `LECTURE_ID` int(10) UNSIGNED NOT NULL,
  `LECTURER_ID` int(9) UNSIGNED NOT NULL,
  `COURSE_NUMBER` int(10) UNSIGNED NOT NULL,
  `START_TIME` datetime NOT NULL,
  `END_TIME` datetime NOT NULL,
  `BUILDING_ID` int(3) UNSIGNED NOT NULL,
  `ROOM_NUMBER` int(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE `person` (
  `ID` int(9) UNSIGNED NOT NULL,
  `FIRST_NAME` varchar(20) NOT NULL,
  `LAST_NAME` varchar(20) NOT NULL,
  `PHONE_NUMBER` varchar(15) NOT NULL,
  `ADDRESS` text NOT NULL,
  `BIRTH_DATE` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `ROOM_NUMBER` int(3) UNSIGNED NOT NULL,
  `BUILDING_ID` int(3) UNSIGNED NOT NULL,
  `DESCRIPTION` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `ID` int(9) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teaching`
--

CREATE TABLE `teaching` (
  `LECTURE_ID` int(9) UNSIGNED NOT NULL,
  `STUDENT_ID` int(9) UNSIGNED NOT NULL,
  `COURSE_NUMBER` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Indexes for table `assingments`
--
ALTER TABLE `assingments`
  ADD PRIMARY KEY (`ASSINGMENT_ID`),
  ADD UNIQUE KEY `COURSE_NUMBER` (`COURSE_NUMBER`,`ASSIGMENT_NAME`);

--
-- Indexes for table `building`
--
ALTER TABLE `building`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`COURSE_NUMBER`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`DEPARTMENT_ID`),
  ADD KEY `DEPARTMENT_HEAD_PERSON_ID` (`DEPARTMENT_HEAD`),
  ADD KEY `DEPARTMENT_BUILDING_ID` (`BUILDING_ID`);

--
-- Indexes for table `lecturer`
--
ALTER TABLE `lecturer`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `lecturer_in_department`
--
ALTER TABLE `lecturer_in_department`
  ADD PRIMARY KEY (`LECTURE_ID`,`DEPARTMENT_ID`),
  ADD KEY `DEPARTMENT_ID` (`DEPARTMENT_ID`);

--
-- Indexes for table `lectures`
--
ALTER TABLE `lectures`
  ADD PRIMARY KEY (`LECTURE_ID`),
  ADD UNIQUE KEY `LECTURER_ID` (`LECTURER_ID`,`COURSE_NUMBER`,`START_TIME`),
  ADD KEY `LECTUR_IS_IN_ROOM_NUMBER` (`ROOM_NUMBER`),
  ADD KEY `LECTUR_IS_IN_BUILDING_ID` (`BUILDING_ID`,`ROOM_NUMBER`);

--
-- Indexes for table `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`ROOM_NUMBER`,`BUILDING_ID`),
  ADD KEY `ROOM_IN_BUILDING` (`BUILDING_ID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD KEY `STUDENT_IS_PERSON_ID` (`ID`);

--
-- Indexes for table `teaching`
--
ALTER TABLE `teaching`
  ADD PRIMARY KEY (`LECTURE_ID`,`STUDENT_ID`,`COURSE_NUMBER`),
  ADD KEY `COURSE_NUMBER` (`COURSE_NUMBER`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `advising`
--
ALTER TABLE `advising`
  MODIFY `ADVISING_ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assingments`
--
ALTER TABLE `assingments`
  MODIFY `ASSINGMENT_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lectures`
--
ALTER TABLE `lectures`
  MODIFY `LECTURE_ID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `advising`
--
ALTER TABLE `advising`
  ADD CONSTRAINT `ADVISING_LECTURER_ID` FOREIGN KEY (`LECTURER_ID`) REFERENCES `lecturer` (`ID`),
  ADD CONSTRAINT `ADVISING_STUDENT_ID` FOREIGN KEY (`STUDENT_ID`) REFERENCES `student` (`ID`);

--
-- Constraints for table `assingments`
--
ALTER TABLE `assingments`
  ADD CONSTRAINT `ASSINGMENT_COURSE_NUMBER` FOREIGN KEY (`COURSE_NUMBER`) REFERENCES `course` (`COURSE_NUMBER`);

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `DEPARTMENT_BUILDING_ID` FOREIGN KEY (`BUILDING_ID`) REFERENCES `building` (`ID`),
  ADD CONSTRAINT `DEPARTMENT_HEAD_PERSON_ID` FOREIGN KEY (`DEPARTMENT_HEAD`) REFERENCES `person` (`ID`);

--
-- Constraints for table `lecturer`
--
ALTER TABLE `lecturer`
  ADD CONSTRAINT `LECTURER_IS_PERSON_ID` FOREIGN KEY (`ID`) REFERENCES `person` (`ID`);

--
-- Constraints for table `lecturer_in_department`
--
ALTER TABLE `lecturer_in_department`
  ADD CONSTRAINT `lecturer_in_department_ibfk_1` FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `departments` (`DEPARTMENT_ID`),
  ADD CONSTRAINT `lecturer_in_department_ibfk_2` FOREIGN KEY (`LECTURE_ID`) REFERENCES `lecturer` (`ID`);

--
-- Constraints for table `lectures`
--
ALTER TABLE `lectures`
  ADD CONSTRAINT `LECTUR_IS_IN_BUILDING_ID` FOREIGN KEY (`BUILDING_ID`,`ROOM_NUMBER`) REFERENCES `room` (`BUILDING_ID`, `ROOM_NUMBER`);

--
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `ROOM_IN_BUILDING` FOREIGN KEY (`BUILDING_ID`) REFERENCES `building` (`ID`);

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `STUDENT_IS_PERSON_ID` FOREIGN KEY (`ID`) REFERENCES `person` (`ID`);

--
-- Constraints for table `teaching`
--
ALTER TABLE `teaching`
  ADD CONSTRAINT `teaching_ibfk_1` FOREIGN KEY (`COURSE_NUMBER`) REFERENCES `course` (`COURSE_NUMBER`),
  ADD CONSTRAINT `teaching_ibfk_2` FOREIGN KEY (`LECTURE_ID`) REFERENCES `lecturer` (`ID`),
  ADD CONSTRAINT `teaching_ibfk_3` FOREIGN KEY (`LECTURE_ID`) REFERENCES `student` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
