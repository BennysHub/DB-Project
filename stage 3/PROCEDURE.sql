DELIMITER $$
CREATE OR REPLACE DEFINER=`root`@`localhost` PROCEDURE `CheckStudentsWeeklyHours`()
    MODIFIES SQL DATA
BEGIN
	DECLARE done BOOL DEFAULT false;
	DECLARE student_id VARCHAR(9);
    DECLARE weekly_hours DECIMAL(10,2);
    DECLARE max_hours_per_week DECIMAL(10,2) DEFAULT 45;
    DECLARE cur1 CURSOR FOR SELECT ID FROM students;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND 
    	SET done = true;
        
    
    OPEN  cur1;
    process_students:WHILE NOT done DO

        FETCH cur1 INTO student_id;
        START TRANSACTION;
        SELECT GetStudentHoursSum(student_id) INTO weekly_hours;
        IF weekly_hours > max_hours_per_week THEN
 			SELECT * FROM person WHERE person.ID = student_id;
    		SELECT 'befor deletion', weekly_hours;
    		CALL GetStudentsCourses(student_id);
            WHILE weekly_hours > max_hours_per_week DO              
                CALL DeleteRandomStudentCourse(student_id);
                SELECT GetStudentHoursSum(student_id) INTO weekly_hours;
        	END WHILE;
            SELECT 'after deletion';
            CALL GetStudentsCourses(student_id);
            SELECT weekly_hours AS "total weekly hours after deletion";
            ROLLBACK;
            SELECT GetStudentHoursSum(student_id) INTO weekly_hours;
            SELECT 'after rollback';
            SELECT weekly_hours AS "total weekly hours after rollback";
            CALL GetStudentsCourses(student_id);
            
		END IF;	
	END WHILE;
   
	CLOSE cur1;
    -- ROLLBACK;
    -- SELECT 'after main rollback';
    -- CALL GetStudentsCourses(student_id);
    
END$$
DELIMITER ;

DELIMITER $$
CREATE  OR REPLACE PROCEDURE `DeleteRandomStudentCourse`(IN `student_id` VARCHAR(9))
    MODIFIES SQL DATA
BEGIN

    DECLARE studentNumOfGroups INT;
    DECLARE myRandomValue int;
    DECLARE studentsGroupToDelete int;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    -- Check if the Student ID exists
    IF NOT EXISTS (SELECT 1 FROM students WHERE students.ID = student_id) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Student ID not found';
    END IF;

   
    SET studentNumOfGroups = 
    (
        SELECT count(DISTINCT sig.GROUP_ID) 
        FROM students s, students_in_groups sig 
        where s.ID = sig.STUDENT_ID
    );
    
    SET myRandomValue = (FLOOR(RAND() * 10) + 1)%studentNumOfGroups;
    
    SET studentsGroupToDelete = 
    	(SELECT group_id FROM (
    		SELECT *, ROW_NUMBER() OVER () AS row_num
    		FROM students_in_groups 
            WHERE students_in_groups.STUDENT_ID = student_id ) AS numbered_rows
    	WHERE row_num = myRandomValue);
        	
    SELECT c.COURSE_NUMBER, c.NAME, c.CREDITS FROM courses c, groups 
    WHERE c.COURSE_NUMBER = groups.COURSE_NUMBER
    AND groups.GROUP_ID = studentsGroupToDelete;
    
    
    -- SELECT 'befor deletion';
    -- CALL GetStudentsCourses(student_id);
    
    -- START TRANSACTION;
    
    DELETE FROM students_in_groups 
    WHERE students_in_groups.STUDENT_ID = student_id 
    and students_in_groups.GROUP_ID = studentsGroupToDelete;
    SELECT ROW_COUNT() AS affected_rows;
    -- SELECT 'after deletion';
    -- CALL GetStudentsCourses(student_id);
    
    -- ROLLBACK; 
    -- SELECT 'after rollback';
    -- CALL GetStudentsCourses(student_id);
    
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStudentsCourses`(IN `student_id` VARCHAR(9))
    DETERMINISTIC
BEGIN
    SELECT c.course_number, c.name
    FROM courses c
    INNER JOIN groups g 
    on g.COURSE_NUMBER = c.COURSE_NUMBER
    INNER JOIN students_in_groups sig 
    on sig.GROUP_ID = g.GROUP_ID
    INNER JOIN students s 
    on s.ID = sig.STUDENT_ID
    WHERE s.id = student_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `GetStudentHoursSum`(student_id VARCHAR(9)) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE TotalHours DECIMAL(10, 2) DEFAULT 0.00;
    
    -- Check if the Student ID exists
    IF NOT EXISTS (SELECT 1 FROM students WHERE students.ID = student_id) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Student ID not found';
    END IF;
    
    SELECT SUM(c.WEEKLY_HOURS) INTO TotalHours
    FROM students s
    JOIN students_in_groups sig ON s.ID = sig.STUDENT_ID
    JOIN groups g ON sig.GROUP_ID = g.GROUP_ID
    JOIN courses c ON g.COURSE_NUMBER = c.COURSE_NUMBER
    WHERE s.ID = student_id;
    
	RETURN (TotalHours);
END$$
DELIMITER ;