------------------------------------------------------------------------------------
המספר הכולל של הרצאות המתקיימות בכל חודש עבור מרצה ספציפי שמספר תעות הזהות שלו היא :026892330
------------------------------------------------------------------------------------
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
    l.ID = '026892330'
    AND le.START_TIME >= '1980-01-01'
GROUP BY
    l.ID,
    p.FIRST_NAME,
    p.LAST_NAME,
    YEAR(le.START_TIME),
    MONTH(le.START_TIME)
ORDER BY
    YEAR(le.START_TIME),
    MONTH(le.START_TIME);

------------------------------------------------------------------------------------
סך הכל שעות שבועיות של הרצאות בכל חודש עבור קורס ספציפי שמספרו : 11
------------------------------------------------------------------------------------
SELECT
    c.COURSE_NUMBER,
    c.NAME AS COURSE_NAME,
    YEAR(le.START_TIME) AS YEAR,
    MONTH(le.START_TIME) AS MONTH,
    SUM(TIMESTAMPDIFF(HOUR, le.START_TIME, le.END_TIME)) AS TOTAL_HOURS
FROM
    lectures le
JOIN
    groups g ON le.GROUP_ID = g.GROUP_ID
JOIN
    courses c ON g.COURSE_NUMBER = c.COURSE_NUMBER
WHERE
    c.COURSE_NUMBER = 11
    AND le.START_TIME >= '1980-01-01'
GROUP BY
    c.COURSE_NUMBER,
    c.NAME,
    YEAR(le.START_TIME),
    MONTH(le.START_TIME)
ORDER BY
    YEAR(le.START_TIME),
    MONTH(le.START_TIME);

------------------------------------------------------------------------------------
קבל הרצאות קרובות עבור מרצה ספציפי שמספרו : 026892330
------------------------------------------------------------------------------------
SELECT
    l.START_TIME AS Start_Time,
    l.END_TIME AS End_Time,
    c.NAME AS Course_Name,
    r.ROOM_NUMBER AS Room_Number,
    b.NAME AS Building_Name
FROM
    lectures l
JOIN
    groups g ON l.GROUP_ID = g.GROUP_ID
JOIN
    courses c ON g.COURSE_NUMBER = c.COURSE_NUMBER
JOIN
    rooms r ON l.BUILDING_ID = r.BUILDING_ID AND l.ROOM_NUMBER = r.ROOM_NUMBER
JOIN
    buildings b ON r.BUILDING_ID = b.ID
WHERE
    g.LECTURER_ID = '026892330'
    AND l.START_TIME > NOW()
ORDER BY
    l.START_TIME;

------------------------------------------------------------------------------------
קבל את כל המטלות שיישלחו ב-30 הימים הבאים עבור קורס ספציפי שמספרו : 11
------------------------------------------------------------------------------------
SELECT
    a.ASSIGNMENT_NAME AS Assignment_Name,
    a.DUE_DATETIME AS Due_Date,
    a.ADDITIONAL_INFO AS Additional_Info
FROM
    assignments a
WHERE
    a.COURSE_NUMBER = 11
    AND a.DUE_DATETIME BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 30 DAY)
ORDER BY
    a.DUE_DATETIME;
------------------------------------------------------------------------------------