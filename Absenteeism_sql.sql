use sql_tableau;

-- Joining our 3 tables: Absenteeism_at_work, compensation, Reasons
SELECT
    Absenteeism_at_work.ID,
    Reasons.Reason,
    Absenteeism_at_work.Month_of_absence,
    Absenteeism_at_work.Body_mass_index,
    CASE
        WHEN Absenteeism_at_work.Body_mass_index < 18.5 THEN 'Underweight'
        WHEN Absenteeism_at_work.Body_mass_index BETWEEN 18.5 AND 25 THEN 'Healthy'
        WHEN Absenteeism_at_work.Body_mass_index BETWEEN 25 AND 30 THEN 'Overweight'
        WHEN Absenteeism_at_work.Body_mass_index > 30 THEN 'Obese'
        ELSE 'Unknown'
    END AS BMI_Category,
    CASE
        WHEN Absenteeism_at_work.Month_of_absence IN (12, 1, 2) THEN 'Winter'
        WHEN Absenteeism_at_work.Month_of_absence IN (3, 4, 5) THEN 'Spring'
        WHEN Absenteeism_at_work.Month_of_absence IN (6, 7, 8) THEN 'Summer'
        WHEN Absenteeism_at_work.Month_of_absence IN (9, 10, 11) THEN 'Fall'
        ELSE 'Unknown'
    END AS Season,
	Seasons, Month_of_absence, Day_of_the_week, Transportation_expense, Education, Son, Social_drinker, Social_smoker, Pet,
	Disciplinary_failure, Age, Work_load_Average_day, Absenteeism_time_in_hours 
FROM
    Absenteeism_at_work
LEFT JOIN
    compensation ON Absenteeism_at_work.ID = compensation.ID
LEFT JOIN
    Reasons ON Absenteeism_at_work.Reason_for_absence = Reasons.Number;

-- Healthy Employees
Select * from Absenteeism_at_work
where Social_drinker = 0 and Social_smoker = 0 and Body_mass_index < 25 
and Absenteeism_time_in_hours < (Select AVG(Absenteeism_time_in_hours) from Absenteeism_at_work)

