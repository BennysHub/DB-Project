ALTER TABLE `courses` MODIFY `NAME` varchar(30) NOT NULL;
ALTER TABLE `lecturers` MODIFY `SALARY` int(11) DEFAULT 0;
ALTER TABLE `lecturers` ADD CHECK (salary >= 0);

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
  MODIFY `ADVISING_ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2034;

--
-- AUTO_INCREMENT for table `assignments`
--
ALTER TABLE `assignments`
  MODIFY `ASSINGMENT_ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=993;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `GROUP_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1251;

--
-- AUTO_INCREMENT for table `lectures`
--
ALTER TABLE `lectures`
  MODIFY `LECTURE_ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1001;

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
-- Constraints for table `assignments`
--
ALTER TABLE `assignments`
  ADD CONSTRAINT `ASSINGMENT_COURSE_NUMBER` FOREIGN KEY (`COURSE_NUMBER`) REFERENCES `courses` (`COURSE_NUMBER`);

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `DEPARTMENT_BUILDING_ID` FOREIGN KEY (`BUILDING_ID`) REFERENCES `buildings` (`ID`);

--
-- Constraints for table `groups`
--
ALTER TABLE `groups`
  ADD CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`COURSE_NUMBER`) REFERENCES `courses` (`COURSE_NUMBER`),
  ADD CONSTRAINT `groups_ibfk_2` FOREIGN KEY (`LECTURER_ID`) REFERENCES `lecturers` (`ID`);

--
-- Constraints for table `head_of_department`
--
ALTER TABLE `head_of_department`
  ADD CONSTRAINT `head_of_department_ibfk_1` FOREIGN KEY (`DEPARTMENT_HEAD`) REFERENCES `lecturers` (`ID`),
  ADD CONSTRAINT `head_of_department_ibfk_2` FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `departments` (`DEPARTMENT_ID`);

--
-- Constraints for table `lecturers`
--
ALTER TABLE `lecturers`
  ADD CONSTRAINT `LECTURER_IS_PERSON` FOREIGN KEY (`ID`) REFERENCES `person` (`ID`);

--
-- Constraints for table `lecturer_in_department`
--
ALTER TABLE `lecturer_in_department`
  ADD CONSTRAINT `lecturer_in_department_ibfk_1` FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `departments` (`DEPARTMENT_ID`),
  ADD CONSTRAINT `lecturer_in_department_ibfk_2` FOREIGN KEY (`LECTURER_ID`) REFERENCES `lecturers` (`ID`);

--
-- Constraints for table `lectures`
--
ALTER TABLE `lectures`
  ADD CONSTRAINT `LECTUR_IS_IN_BUILDING_ID` FOREIGN KEY (`BUILDING_ID`,`ROOM_NUMBER`) REFERENCES `rooms` (`BUILDING_ID`, `ROOM_NUMBER`),
  ADD CONSTRAINT `lectures_ibfk_1` FOREIGN KEY (`GROUP_ID`) REFERENCES `groups` (`GROUP_ID`);

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `ROOM_IN_BUILDING` FOREIGN KEY (`BUILDING_ID`) REFERENCES `buildings` (`ID`);

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `STUDENT_IS_PERSON_ID` FOREIGN KEY (`ID`) REFERENCES `person` (`ID`);

--
-- Constraints for table `students_in_groups`
--
ALTER TABLE `students_in_groups`
  ADD CONSTRAINT `students_in_groups_ibfk_1` FOREIGN KEY (`GROUP_ID`) REFERENCES `groups` (`GROUP_ID`),
  ADD CONSTRAINT `students_in_groups_ibfk_2` FOREIGN KEY (`STUDENT_ID`) REFERENCES `students` (`ID`);
