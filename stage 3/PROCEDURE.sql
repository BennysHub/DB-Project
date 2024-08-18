DELIMITER $$
CREATE OR REPLACE PROCEDURE CheckStudentsWeeklyHours() NOT DETERMINISTIC MODIFIES SQL DATA SQL SECURITY DEFINER BEGIN
	DECLARE done BOOL DEFAULT false;
	DECLARE student_id VARCHAR(9);
    DECLARE weekly_hours DECIMAL(10,2);
    DECLARE max_hours_per_week DECIMAL(10,2) DEFAULT 45;
    DECLARE cur1 CURSOR FOR SELECT ID FROM students;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND 
    	SET done = true;
    -- SELECT 'start';
    START TRANSACTION;
    OPEN  cur1;
    process_students:WHILE NOT done DO

        FETCH cur1 INTO student_id;
        
        SELECT GetStudentHoursSum(student_id) INTO weekly_hours;
        IF weekly_hours > max_hours_per_week THEN
        
            WHILE weekly_hours > max_hours_per_week DO
                SELECT weekly_hours;
                SELECT GetStudentHoursSum(student_id) INTO weekly_hours;
                CALL DeleteRandomStudentCourse(student_id);
        	END WHILE;
            LEAVE process_students;

		END IF;
      
		
	END WHILE;
   
	CLOSE cur1;
    ROLLBACK;
    SELECT 'after main rollback';
    CALL GetStudentsCourses(student_id);
    
END$$




DELIMITER $$

CREATE OR REPLACE PROCEDURE DeleteRandomStudentCourse(IN `student_id` VARCHAR(9)) NOT DETERMINISTIC MODIFIES SQL DATA SQL SECURITY DEFINER BEGIN

    DECLARE student_courses_number INT;
    DECLARE myRandomValue int;
    DECLARE courseToDelete int;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
        
    SET student_courses_number = (SELECT count(DISTINCT sig.GROUP_ID) FROM students s, students_in_groups sig where s.ID = sig.STUDENT_ID);
    SET myRandomValue = (FLOOR(RAND() * 10) + 1)%student_courses_number;
    
    SET courseToDelete = 
    	(SELECT group_id FROM (
    		SELECT *, ROW_NUMBER() OVER () AS row_num
    		FROM students_in_groups WHERE students_in_groups.STUDENT_ID = student_id ) AS numbered_rows
    	WHERE row_num = myRandomValue);
        	
    SELECT courseToDelete;
    
    
    SELECT 'befor deletion';
    CALL GetStudentsCourses(student_id);
    
    SELECT 'this coures deletion';
    SELECT c.course_number, c.name, s.ID
    FROM courses c
    INNER JOIN groups g 
    on g.COURSE_NUMBER = c.COURSE_NUMBER
    INNER JOIN students_in_groups sig 
    on sig.GROUP_ID = g.GROUP_ID
    INNER JOIN students s 
    on s.ID = sig.STUDENT_ID
    WHERE s.id = student_id
    AND g.GROUP_ID = courseToDelete;
    
    -- START TRANSACTION;
    
    DELETE FROM students_in_groups WHERE students_in_groups.STUDENT_ID = student_id and students_in_groups.GROUP_ID = courseToDelete;
    SELECT ROW_COUNT() AS affected_rows;
    
    SELECT 'after deletion';
    CALL GetStudentsCourses(student_id);
    -- ROLLBACK;
    
    SELECT 'after rollback';
    CALL GetStudentsCourses(student_id);
    
    -- RELEASE SAVEPOINT before_delete;
END$$




DELIMITER $$
CREATE OR REPLACE FUNCTION GetStudentHoursSum(student_id VARCHAR(9)) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE TotalHours DECIMAL(10, 2);
    
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



DELIMITER $$
CREATE OR REPLACE FUNCTION factorial(n INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE result INT DEFAULT 1;
    WHILE n > 1 DO
        SET result = result * n;
        SET n = n - 1;
    END WHILE;
    RETURN result;
END$$
DELIMITER ;




DELIMITER $$
CREATE OR REPLACE PROCEDURE GetStudentsCourses(IN `student_id` VARCHAR(9))
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