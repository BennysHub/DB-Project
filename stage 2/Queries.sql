שליפה של כל המרצים שיש להם יותר משלושה סטודנטים בקורס ונותנת את כל הקורסים של אותו מרצה
-------------------------------------------------------------------------------------------
SELECT p.FIRST_NAME, p.LAST_NAME, p.ID, g.GROUP_ID, g.COURSE_NUMBER, c.NAME, d.DEPARTMENT_NAME, count(s.STUDENT_ID) as "number of students:" 
FROM person p, lecturers l, groups g, students_in_groups s, courses c, departments d, lecturer_in_department lid 
where p.ID = l.ID 
and g.LECTURER_ID = l.ID 
and lid.LECTURER_ID = l.ID 
and d.DEPARTMENT_ID = lid.DEPARTMENT_ID 
and s.GROUP_ID = g.GROUP_ID and c.COURSE_NUMBER = g.COURSE_NUMBER 
and d.DEPARTMENT_NAME LIKE "D%"
group by p.FIRST_NAME, p.LAST_NAME, p.ID, g.GROUP_ID, g.COURSE_NUMBER, c.NAME, d.DEPARTMENT_NAME
HAVING count(s.STUDENT_ID) >3
order by d.DEPARTMENT_NAME ASC;

-------------------------------------------------------------------
המספר הכולל של הרצאות המתקיימות בכל חודש עבור כל מרצה משנת 2000 ואילך
-------------------------------------------------------------------
SELECT
    l.ID AS LECTURER_ID,
    p.FIRST_NAME,
    p.LAST_NAME,
    YEAR(le.START_TIME) AS YEAR,
    MONTH(le.START_TIME) AS MONTH,
    COUNT(*) AS LECTURE_COUNT
FROM
    lectures le
JOIN
    groups g ON le.GROUP_ID = g.GROUP_ID
JOIN
    lecturers l ON g.LECTURER_ID = l.ID
JOIN
    person p ON l.ID = p.ID
WHERE
    le.START_TIME >= '2000-01-01'
GROUP BY
    l.ID,
    p.FIRST_NAME,
    p.LAST_NAME,
    YEAR(le.START_TIME),
    MONTH(le.START_TIME)
ORDER BY
    l.ID,
    YEAR(le.START_TIME),
    MONTH(le.START_TIME);
-------------------------------------------------------------------
שליפה למצוא את כל השיעורים שיש למרצה ללמד וגם באיזה כיתה נמצא השיעור
-------------------------------------------------------------------
SELECT 
    l.ID AS LECTURER_ID,
    p.FIRST_NAME,
    p.LAST_NAME,
    c.COURSE_NUMBER,
    c.NAME AS COURSE_NAME,
    le.START_TIME,
    le.END_TIME,
    b.NAME AS BUILDING_NAME,
    r.ROOM_NUMBER
FROM
    lecturers l
JOIN
    person p ON l.ID = p.ID
JOIN
    groups g ON l.ID = g.LECTURER_ID
JOIN
    courses c ON g.COURSE_NUMBER = c.COURSE_NUMBER
JOIN
    lectures le ON g.GROUP_ID = le.GROUP_ID
JOIN
    rooms r ON le.BUILDING_ID = r.BUILDING_ID AND le.ROOM_NUMBER = r.ROOM_NUMBER
JOIN
    buildings b ON r.BUILDING_ID = b.ID
ORDER BY
    l.ID, le.START_TIME;
	
-------------------------------------------------------------------------
רשימה של כל הסטודנטים שיש לאותו מרצה בקורס שלו
-------------------------------------------------------------------------
SELECT 
    l.ID AS LECTURER_ID,
    p.FIRST_NAME AS LECTURER_FIRST_NAME,
    p.LAST_NAME AS LECTURER_LAST_NAME,
    c.COURSE_NUMBER,
    c.NAME AS COURSE_NAME,
    g.GROUP_ID,
    s.ID AS STUDENT_ID,
    sp.FIRST_NAME AS STUDENT_FIRST_NAME,
    sp.LAST_NAME AS STUDENT_LAST_NAME
FROM
    lecturers l
JOIN
    person p ON l.ID = p.ID
JOIN
    groups g ON l.ID = g.LECTURER_ID
JOIN
    courses c ON g.COURSE_NUMBER = c.COURSE_NUMBER
JOIN
    students_in_groups sig ON g.GROUP_ID = sig.GROUP_ID
JOIN
    students s ON sig.STUDENT_ID = s.ID
JOIN
    person sp ON s.ID = sp.ID
ORDER BY
    l.ID, c.COURSE_NUMBER, g.GROUP_ID, s.ID;


-------------------------------------------------------------------------
שאילתה שמספקת את לוח הזמנים של הפגישות שיש לכל מרצה עם הסטודנטים
-------------------------------------------------------------------------
SELECT 
    l.ID AS LECTURER_ID,
    p.FIRST_NAME AS LECTURER_FIRST_NAME,
    p.LAST_NAME AS LECTURER_LAST_NAME,
    a.ADVISING_ID,
    a.TIME_START,
    a.TIME_END,
    sp.FIRST_NAME AS STUDENT_FIRST_NAME,
    sp.LAST_NAME AS STUDENT_LAST_NAME,
    a.ADVISING_NOTES
FROM
    lecturers l
JOIN
    person p ON l.ID = p.ID
JOIN
    advising a ON l.ID = a.LECTURER_ID
JOIN
    students s ON a.STUDENT_ID = s.ID
JOIN
    person sp ON s.ID = sp.ID
ORDER BY
    l.ID, a.TIME_START;

-------------------------------------------------------------------------
select s.GROUP_ID, COUNT(*) FROM students_in_groups s GROUp by GROUP_ID order by count(*);
-------------------------------------------------------------------------

-------------------------------------------------------------------------
למחוק את כל הקבוצות שאין בהם סטודנטים
-------------------------------------------------------------------------
DELETE * FROM groups
WHERE
    GROUP_ID IN(
    SELECT
        COUNT(*)
    FROM
        groups g
    WHERE
        g.GROUP_ID NOT IN(
        SELECT
            GROUP_ID
        FROM
            students_in_groups
    )
);
-------------------------------------------------------------------------
מחיקת מרצים שהם לא באף מחלקה
-------------------------------------------------------------------------
DELETE FROM lecturers
WHERE ID IN (
    SELECT l.ID
    FROM lecturers l
    LEFT JOIN lecturer_in_department lid ON l.ID = lid.LECTURER_ID
    WHERE lid.LECTURER_ID IS NULL
);

-------------------------------------------------------------------------
שאילתה שמעדכנת את השכר של כל המרצים שמלמדים יותר מ3 קורסים
-------------------------------------------------------------------------

UPDATE
    lecturers l
SET
    l.SALARY = l.SALARY * 1.12
WHERE
    l.ID IN(
    SELECT
        g.LECTURER_ID
    FROM
        groups g
    HAVING
        COUNT(DISTINCT g.COURSE_NUMBER) >= 3
);
-------------------------------------------------------------------------
שאילתה שמעדכנת את הערך של התיאור של כל החדרים לערך דיפולתי
-------------------------------------------------------------------------
UPDATE rooms r
SET r.DESCRIPTION = 'Standard Room'
WHERE r.BUILDING_ID IN (
    SELECT b.ID
    FROM buildings b
    WHERE b.NAME = 'Engineering Building'
) AND r.DESCRIPTION IS NULL;
