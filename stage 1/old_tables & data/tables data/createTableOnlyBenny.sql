-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 05, 2024 at 03:36 PM
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
-- Table structure for table `lecturers`
--

CREATE TABLE `Person` (
  `ID` varchar(9) NOT NULL,
  `FIRST_NAME` varchar(20) NOT NULL,
  `LAST_NAME` varchar(20) NOT NULL,
  `EMAIL` varchar(35) NOT NULL,
  `PHONE_NUMBER` varchar(20) NOT NULL,
  `ADDRESS` text NOT NULL,
  `BIRTH_DATE` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for table `lecturers`
--
ALTER TABLE `Person`
  ADD PRIMARY KEY (`ID`);
-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `ID` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `students`
  ADD PRIMARY KEY (`ID`),
  ADD CONSTRAINT `STUDENT_IS_PERSON_ID` FOREIGN KEY (`ID`) REFERENCES `Person` (`ID`);


-- --------------------------------------------------------

--
-- Table structure for table `lecturers`
--

CREATE TABLE `lecturers` (
  `ID` varchar(9) NOT NULL,
  `SALARY` int(11) UNSIGNED NOT NULL,
  `HIRE_DATE` date NOT NULL,
  `QUALIFICATIONS` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for table `lecturers`
--
ALTER TABLE `lecturers`
  ADD PRIMARY KEY (`ID`),
  ADD CONSTRAINT `LECTURER_IS_PERSON` FOREIGN KEY (`ID`) REFERENCES `Person` (`ID`);

-- --------------------------------------------------------

--
-- Table structure for table `buildings`
--

CREATE TABLE `buildings` (
  `ID` int(3) UNSIGNED NOT NULL,
  `NAME` varchar(20) NOT NULL,
  `DESCRIPTION` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for table `buildings`
--
ALTER TABLE `buildings`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `BUILDING_ID` (`ID`);
-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `ROOM_NUMBER` int(3) UNSIGNED NOT NULL,
  `BUILDING_ID` int(3) UNSIGNED NOT NULL,
  `DESCRIPTION` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`ROOM_NUMBER`,`BUILDING_ID`),
  ADD CONSTRAINT `ROOM_IN_BUILDING` FOREIGN KEY (`BUILDING_ID`) REFERENCES `buildings` (`ID`);

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `DEPARTMENT_ID` int(3) UNSIGNED NOT NULL,
  `DEPARTMENT_NAME` varchar(30) NOT NULL,
  `DEPARTMENT_PHONE` varchar(15) NOT NULL,
  `DEPARTMENT_HEAD` varchar(9) NOT NULL,
  `BUILDING_ID` int(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`DEPARTMENT_ID`),
  ADD CONSTRAINT `DEPARTMENT_BUILDING_ID` FOREIGN KEY (`BUILDING_ID`) REFERENCES `buildings` (`ID`),
  ADD CONSTRAINT `DEPARTMENT_HEAD_PERSON_ID` FOREIGN KEY (`DEPARTMENT_HEAD`) REFERENCES `person` (`ID`);

-- --------------------------------------------------------

--
-- Table structure for table `lecturer_in_department`
--

CREATE TABLE `lecturer_in_department` (
  `LECTURER_ID` VARCHAR(9) NOT NULL,
  `DEPARTMENT_ID` int(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for table `lecturer_in_department`
--
ALTER TABLE `lecturer_in_department`
  ADD PRIMARY KEY (`LECTURER_ID`,`DEPARTMENT_ID`),
  ADD CONSTRAINT `lecturer_in_department_ibfk_1` FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `departments` (`DEPARTMENT_ID`),
  ADD CONSTRAINT `lecturer_in_department_ibfk_2` FOREIGN KEY (`LECTURER_ID`) REFERENCES `lecturers` (`ID`);

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `COURSE_NUMBER` int(11) UNSIGNED NOT NULL,
  `NAME` varchar(30) NOT NULL,
  `CREDITS` decimal(2,1) UNSIGNED NOT NULL,
  `WEEKLY_HOURS` decimal(2,1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`COURSE_NUMBER`);

-- --------------------------------------------------------

--
-- Table structure for table `advising`
--

CREATE TABLE `advising` (
  `ADVISING_ID` int(11) UNSIGNED NOT NULL,
  `LECTURER_ID` VARCHAR(9) NOT NULL,
  `STUDENT_ID` VARCHAR(9) NOT NULL,
  `TIME_START` datetime NOT NULL,
  `TIME_END` datetime NOT NULL,
  `ADVISING_NOTES` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Indexes for table `advising`
--
ALTER TABLE `advising`
  ADD PRIMARY KEY (`ADVISING_ID`),
  ADD UNIQUE KEY `LECTURER_ID` (`LECTURER_ID`,`STUDENT_ID`,`TIME_START`),
  ADD CONSTRAINT `ADVISING_LECTURER_ID` FOREIGN KEY (`LECTURER_ID`) REFERENCES `lecturers` (`ID`),
  ADD CONSTRAINT `ADVISING_STUDENT_ID` FOREIGN KEY (`STUDENT_ID`) REFERENCES `students` (`ID`),
  MODIFY `ADVISING_ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

-- --------------------------------------------------------

--
-- Table structure for table `assingments`
--

CREATE TABLE `assingments` (
  `ASSINGMENT_ID` int(11) UNSIGNED NOT NULL,
  `COURSE_NUMBER` int(11) UNSIGNED NOT NULL,
  `ASSIGMENT_NAME` varchar(50) NOT NULL,
  `DUE_DATETIME` datetime NOT NULL,
  `ADDITIONAL_INFO` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Indexes for table `assingments`
--
ALTER TABLE `assingments`
  ADD PRIMARY KEY (`ASSINGMENT_ID`),
  ADD UNIQUE KEY `COURSE_NUMBER` (`COURSE_NUMBER`,`ASSIGMENT_NAME`),
  ADD CONSTRAINT `ASSINGMENT_COURSE_NUMBER` FOREIGN KEY (`COURSE_NUMBER`) REFERENCES `courses` (`COURSE_NUMBER`),
  MODIFY `ASSINGMENT_ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

-- --------------------------------------------------------

--
-- Table structure for table `lectures`
--

CREATE TABLE `lectures` (
  `LECTURE_ID` INT(11) UNSIGNED NOT NULL,
  `LECTURER_ID` VARCHAR(9) NOT NULL,
  `COURSE_NUMBER` int(11) UNSIGNED NOT NULL,
  `START_TIME` datetime NOT NULL,
  `END_TIME` datetime NOT NULL,
  `BUILDING_ID` int(3) UNSIGNED NOT NULL,
  `ROOM_NUMBER` int(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for table `lectures`
--
ALTER TABLE `lectures`
  ADD PRIMARY KEY (`LECTURE_ID`),
  ADD UNIQUE KEY `LECTURER_ID` (`LECTURER_ID`,`COURSE_NUMBER`,`START_TIME`),
  ADD CONSTRAINT `LECTUR_IS_IN_BUILDING_ID` FOREIGN KEY (`BUILDING_ID`,`ROOM_NUMBER`) REFERENCES `rooms` (`BUILDING_ID`, `ROOM_NUMBER`),
  MODIFY `LECTURE_ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;


-- --------------------------------------------------------

--
-- Table structure for table `teaching`
--

CREATE TABLE `teaching` (
  `LECTURE_ID` varchar(9) NOT NULL,
  `STUDENT_ID` varchar(9) NOT NULL,
  `COURSE_NUMBER` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for table `teaching`
--
ALTER TABLE `teaching`
  ADD PRIMARY KEY (`LECTURE_ID`,`STUDENT_ID`,`COURSE_NUMBER`),
  ADD CONSTRAINT `COURSE_TAUGHT` FOREIGN KEY (`COURSE_NUMBER`) REFERENCES `courses` (`COURSE_NUMBER`),
  ADD CONSTRAINT `LECTURER_TEACHING` FOREIGN KEY (`LECTURE_ID`) REFERENCES `lecturers` (`ID`),
  ADD CONSTRAINT `STUDENTS_STUDY` FOREIGN KEY (`LECTURE_ID`) REFERENCES `students` (`ID`);

-- --------------------------------------------------------

--
-- Indexes for dumped tables
-- AUTO_INCREMENT for dumped tables
-- Constraints for dumped tables
--

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
