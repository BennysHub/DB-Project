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