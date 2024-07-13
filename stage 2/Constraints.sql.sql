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