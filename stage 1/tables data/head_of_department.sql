-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 07, 2024 at 07:50 AM
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
-- Table structure for table `head_of_department`
--

CREATE TABLE `head_of_department` (
  `DEPARTMENT_HEAD` varchar(9) NOT NULL,
  `DEPARTMENT_ID` int(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `head_of_department`
--

INSERT INTO `head_of_department` (`DEPARTMENT_HEAD`, `DEPARTMENT_ID`) VALUES
('011817755', 807),
('028018856', 239),
('037150572', 761),
('037480483', 156),
('056381976', 806),
('088546661', 160),
('126711112', 157),
('136466958', 367),
('138015107', 65),
('138015107', 165),
('174093782', 120),
('190651534', 315),
('192317668', 960),
('203948515', 324),
('203948515', 892),
('213985402', 967),
('236673570', 475),
('258982998', 486),
('266135953', 181),
('280082657', 102),
('281438343', 617),
('301966969', 48),
('302197975', 20),
('302197975', 998),
('321439044', 615),
('339682439', 355),
('339682439', 953),
('343361885', 948),
('374116881', 630),
('379922900', 161),
('451946465', 653),
('460719587', 86),
('478576112', 529),
('506053441', 929),
('511583575', 539),
('517658440', 625),
('545889214', 783),
('549879225', 205),
('555928378', 620),
('597217540', 418),
('597489411', 312),
('642600569', 928),
('654665817', 192),
('657260594', 763),
('669205201', 426),
('691068476', 498),
('728147071', 802),
('729398369', 431),
('732037135', 703),
('781077648', 388),
('802798118', 39),
('802846868', 863),
('806468458', 657),
('822436822', 420),
('893298893', 624),
('893298893', 971),
('895961058', 606),
('915903083', 109),
('960318073', 135),
('963289080', 263);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `head_of_department`
--
ALTER TABLE `head_of_department`
  ADD PRIMARY KEY (`DEPARTMENT_HEAD`,`DEPARTMENT_ID`),
  ADD KEY `head_of_department_ibfk_2` (`DEPARTMENT_ID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `head_of_department`
--
ALTER TABLE `head_of_department`
  ADD CONSTRAINT `head_of_department_ibfk_1` FOREIGN KEY (`DEPARTMENT_HEAD`) REFERENCES `lecturers` (`ID`),
  ADD CONSTRAINT `head_of_department_ibfk_2` FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `departments` (`DEPARTMENT_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
