-- selectAll.sql

SELECT * FROM `person`;
SELECT * FROM `student`;
SELECT * FROM `lecturer`;
SELECT * FROM `departments`;
SELECT * FROM `building`;
SELECT * FROM `room`;
SELECT * FROM `course`;
SELECT * FROM `lectures`;
SELECT * FROM `lecturer_in_department`;
SELECT * FROM `teaching`;
SELECT * FROM `advising`;
SELECT * FROM `assingments`;


-- selectAll.sql

SELECT
    p.ID AS person_ID,
    p.FIRST_NAME,
    p.LAST_NAME,
    p.PHONE_NUMBER,
    p.ADDRESS,
    p.BIRTH_DATE,
    s.ID AS student_ID,
    l.ID AS lecturer_ID,
    l.SALARY,
    l.QUALIFICATIONS,
    d.DEPARTMENT_ID,
    d.DEPARTMENT_NAME,
    d.DEPARTMENT_PHONE,
    d.DEPARTMENT_HEAD,
    b.ID AS building_ID,
    b.NAME AS building_NAME,
    b.DESCRIPTION AS building_description,
    r.ROOM_NUMBER,
    r.DESCRIPTION AS room_description,
    c.COURSE_NUMBER,
    c.NAME AS course_name,
    c.CREDITS,
    c.WEEKLY_HOURS,
    lec.LECTURE_ID,
    lec.START_TIME,
    lec.END_TIME,
    lec.BUILDING_ID AS lecture_building_ID,
    lec.ROOM_NUMBER AS lecture_room_number,
    lec.COURSE_NUMBER AS lecture_course_number,
    lad.ADVISING_ID,
    lad.LECTURER_ID AS advising_lecturer_ID,
    lad.STUDENT_ID AS advising_student_ID,
    lad.TIME_START,
    lad.TIME_END,
    lad.ADVISING_NOTES,
    a.ASSINGMENT_ID,
    a.COURSE_NUMBER AS assignment_course_number,
    a.ASSIGMENT_NAME,
    a.DUE_DATETIME,
    a.ADDITIONAL_INFO
FROM
    person p
LEFT JOIN
    student s ON p.ID = s.ID
LEFT JOIN
    lecturer l ON p.ID = l.ID
LEFT JOIN
    departments d ON p.ID = d.DEPARTMENT_HEAD
LEFT JOIN
    building b ON d.BUILDING_ID = b.ID
LEFT JOIN
    room r ON b.ID = r.BUILDING_ID
LEFT JOIN
    course c ON c.COURSE_NUMBER = a.COURSE_NUMBER
LEFT JOIN
    lectures lec ON l.ID = lec.LECTURER_ID
LEFT JOIN
    advising lad ON l.ID = lad.LECTURER_ID
LEFT JOIN
    assingments a ON c.COURSE_NUMBER = a.COURSE_NUMBER
LEFT JOIN
    lecturer_in_department lid ON l.ID = lid.LECTURE_ID
LEFT JOIN
    teaching t ON l.ID = t.LECTURE_ID AND s.ID = t.STUDENT_ID AND c.COURSE_NUMBER = t.COURSE_NUMBER;

############
Joining Tables: The tables are joined based on logical relationships and foreign key references:
student and lecturer are joined with person on ID.
departments is joined with person on DEPARTMENT_HEAD.
building is joined with departments on BUILDING_ID.
room is joined with building on BUILDING_ID.
course and assingments are joined on COURSE_NUMBER.
lectures, advising, lecturer_in_department, and teaching are joined based on their respective foreign keys.