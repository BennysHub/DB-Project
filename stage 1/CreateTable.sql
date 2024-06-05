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
-- Table structure for table `buildings`
--

CREATE TABLE `buildings` (
  `ID` int(3) UNSIGNED NOT NULL,
  `NAME` varchar(20) NOT NULL,
  `DESCRIPTION` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Table structure for table `lecturers`
--

CREATE TABLE `lecturers` (
  `ID` int(9) UNSIGNED NOT NULL,
  `FIRST_NAME` varchar(20) NOT NULL,
  `LAST_NAME` varchar(20) NOT NULL,
  `EMAIL` varchar(30) NOT NULL,
  `PHONE_NUMBER` varchar(20) NOT NULL,
  `ADDRESS` text NOT NULL,
  `BIRTH_DATE` date NOT NULL,
  `SALARY` int(11) UNSIGNED NOT NULL,
  `QUALIFICATIONS` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lecturers`
--

INSERT INTO `lecturers` (`ID`, `FIRST_NAME`, `LAST_NAME`, `EMAIL`, `PHONE_NUMBER`, `ADDRESS`, `BIRTH_DATE`, `SALARY`, `QUALIFICATIONS`) VALUES
(123456789, 'John', 'Doe', 'john.doe@example.com', '+972-50-1234567', '123 Main St, City', '1980-01-15', 60000, 'Ph.D. in Computer Science'),
(987654321, 'Jane', 'Smith', 'jane.smith@example.com', '+972-54-9876543', '456 Elm St, Town', '1985-03-20', 55000, 'M.Sc. in Mathematics'),
(987654322, 'Alice', 'Johnson', 'alice.johnson@example.com', '+972-52-5551234', '789 Oak Ave, Village', '1990-07-10', 70000, 'M.A. in Literature'),
(987654323, 'David', 'Brown', 'david.brown@example.com', '+972-58-1112223', '567 Pine Rd, Suburb', '1982-09-05', 48000, 'B.A. in History'),
(987654324, 'Emily', 'Lee', 'emily.lee@example.com', '+972-53-4445556', '890 Cedar Ln, County', '1988-12-03', 42000, 'B.Sc. in Chemistry'),
(987654325, 'Michael', 'Clark', 'michael.clark@example.com', '+972-55-7778889', '234 Maple Ave, Hamlet', '1995-04-18', 38000, 'B.Ed. in Education'),
(987654326, 'Sophia', 'Garcia', 'sophia.garcia@example.com', '+972-51-9990001', '678 Birch Blvd, Village', '1987-11-25', 62000, 'MBA'),
(987654327, 'Daniel', 'Wang', 'daniel.wang@example.com', '+972-56-2223334', '345 Oakwood Dr, Town', '1992-06-12', 54000, 'M.A. in Economics'),
(987654328, 'Olivia', 'Miller', 'olivia.miller@example.com', '+972-57-4445556', '789 Willow Rd, Suburb', '1984-08-30', 59000, 'Ph.D. in Physics'),
(987654329, 'Liam', 'Nguyen', 'liam.nguyen@example.com', '+972-59-6667778', '123 Elmwood Ave, City', '1998-02-22', 40000, 'B.Sc. in Biology'),
(987654330, 'Isabella', 'Chen', 'isabella.chen@example.com', '+972-55-1234567', '456 Oak St, Village', '1983-07-28', 67000, 'M.Sc. in Engineering'),
(987654331, 'Ethan', 'Gupta', 'ethan.gupta@example.com', '+972-53-9876543', '789 Maple Ave, Town', '1989-05-10', 52000, 'B.A. in Sociology'),
(987654332, 'Ava', 'Kumar', 'ava.kumar@example.com', '+972-52-5551234', '234 Elmwood Dr, City', '1994-11-15', 44000, 'B.Ed. in Education'),
(987654333, 'Noah', 'Patel', 'noah.patel@example.com', '+972-54-4445556', '567 Cedar Ln, Suburb', '1986-03-22', 61000, 'M.A. in History'),
(987654334, 'Mia', 'Lee', 'mia.lee@example.com', '+972-50-7778889', '678 Oak Ave, Village', '1991-09-12', 53000, 'B.Sc. in Chemistry'),
(987654335, 'Lucas', 'Wu', 'lucas.wu@example.com', '+972-56-9990001', '890 Birch Blvd, Hamlet', '1987-12-05', 47000, 'B.A. in Literature'),
(987654336, 'Amelia', 'Kim', 'amelia.kim@example.com', '+972-57-2223334', '123 Pine Rd, County', '1993-04-20', 69000, 'M.Sc. in');

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
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `ROOM_NUMBER` int(3) UNSIGNED NOT NULL,
  `BUILDING_ID` int(3) UNSIGNED NOT NULL,
  `DESCRIPTION` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
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
  ADD KEY `DEPARTMENT_HEAD_PERSON_ID` (`DEPARTMENT_HEAD`),
  ADD KEY `DEPARTMENT_BUILDING_ID` (`BUILDING_ID`);

--
-- Indexes for table `lecturers`
--
ALTER TABLE `lecturers`
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
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`ROOM_NUMBER`,`BUILDING_ID`),
  ADD KEY `ROOM_IN_BUILDING` (`BUILDING_ID`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
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
  ADD CONSTRAINT `ADVISING_LECTURER_ID` FOREIGN KEY (`LECTURER_ID`) REFERENCES `lecturers` (`ID`),
  ADD CONSTRAINT `ADVISING_STUDENT_ID` FOREIGN KEY (`STUDENT_ID`) REFERENCES `students` (`ID`);

--
-- Constraints for table `assingments`
--
ALTER TABLE `assingments`
  ADD CONSTRAINT `ASSINGMENT_COURSE_NUMBER` FOREIGN KEY (`COURSE_NUMBER`) REFERENCES `courses` (`COURSE_NUMBER`);

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `DEPARTMENT_BUILDING_ID` FOREIGN KEY (`BUILDING_ID`) REFERENCES `buildings` (`ID`),
  ADD CONSTRAINT `DEPARTMENT_HEAD_PERSON_ID` FOREIGN KEY (`DEPARTMENT_HEAD`) REFERENCES `lecturers` (`ID`);

--
-- Constraints for table `lecturer_in_department`
--
ALTER TABLE `lecturer_in_department`
  ADD CONSTRAINT `lecturer_in_department_ibfk_1` FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `departments` (`DEPARTMENT_ID`),
  ADD CONSTRAINT `lecturer_in_department_ibfk_2` FOREIGN KEY (`LECTURE_ID`) REFERENCES `lecturers` (`ID`);

--
-- Constraints for table `lectures`
--
ALTER TABLE `lectures`
  ADD CONSTRAINT `LECTUR_IS_IN_BUILDING_ID` FOREIGN KEY (`BUILDING_ID`,`ROOM_NUMBER`) REFERENCES `rooms` (`BUILDING_ID`, `ROOM_NUMBER`);

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `ROOM_IN_BUILDING` FOREIGN KEY (`BUILDING_ID`) REFERENCES `buildings` (`ID`);

--
-- Constraints for table `teaching`
--
ALTER TABLE `teaching`
  ADD CONSTRAINT `teaching_ibfk_1` FOREIGN KEY (`COURSE_NUMBER`) REFERENCES `courses` (`COURSE_NUMBER`),
  ADD CONSTRAINT `teaching_ibfk_2` FOREIGN KEY (`LECTURE_ID`) REFERENCES `lecturers` (`ID`),
  ADD CONSTRAINT `teaching_ibfk_3` FOREIGN KEY (`LECTURE_ID`) REFERENCES `students` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
