-- #######################################################################
-- ###                Human Resources Database        ###
-- ###                  University Project            ###
-- ###    			 by BARGAN DIANA GEORGIANA        ###
-- #######################################################################
-- ###                    SQL queries   ### 
-- #######################################################################

SELECT * from employees
SELECT * from departments
SELECT * from positions
SELECT * from contracts
SELECT * from contributions
SELECT * from contribution_details
SELECT * from allowances
SELECT * from allowance_details
SELECT * from leaves
SELECT * from leave_details
SELECT * from deductions
SELECT * from deduction_details
SELECT * from timesheets

-- 1. Display all employees and the positions, respectively departments  they belong to . 
    -- (Afisati toti angajatii si functiile respectiv departamentele din care fac parte.)
SELECT 
    e.employee_code, e.first_name || ' ' || e.last_name AS employee_name,
    p.position_name,
    d.department_name
FROM employees e
JOIN positions p 
    ON e.employee_code = p.employee_code
JOIN departments d 
    ON p.department_code = d.department_code;
	
-- 2. What is the GROSS salary of each active employee for the current month, sorted in descending order ?
 -- (Care este salariul BRUT al fiecarui angajat activ pentru luna curenta, sortat descrescator ?)
 
SELECT 
    e.employee_code,
    e.first_name || ' ' || e.last_name AS employee_name,
    p.position_name,
    c.salary AS base_salary,
    COALESCE(SUM(ad.value), 0) AS total_allowances,
    (c.salary + COALESCE(SUM(ad.value), 0)) AS gross_salary
FROM employees e
JOIN positions p 
    ON e.employee_code = p.employee_code
JOIN contracts c
    ON e.employee_code = c.employee_code
   AND c.start_date <= CURRENT_DATE
   AND (c.end_date IS NULL OR c.end_date >= CURRENT_DATE)
LEFT JOIN allowance_details ad 
    ON e.employee_code = ad.employee_code
   AND ad.record_date = DATE_TRUNC('month', CURRENT_DATE)::date
GROUP BY e.employee_code, e.first_name, e.last_name, p.position_name, c.salary
ORDER BY gross_salary DESC;


-- 3. What is the NET salary of each active employee for the current month, sorted in descending order?
 --  Net Salary = Gross Salary − Total Contributions − Total Deductions
--(Care este salariul NET al fiecarui angajat activ pentru luna curenta, sortat descrescator ?)

WITH gross_salary AS (
	SELECT 
    e.employee_code,
    e.first_name || ' ' || e.last_name AS employee_name,
    p.position_name,
    c.salary AS base_salary,
    COALESCE(SUM(ad.value), 0) AS total_allowances,
    (c.salary + COALESCE(SUM(ad.value), 0)) AS gross_salary  --- gross salary = base salary + bonuses.
FROM employees e
JOIN positions p 
    ON e.employee_code = p.employee_code
JOIN contracts c
    ON e.employee_code = c.employee_code
   AND c.start_date <= CURRENT_DATE
   AND (c.end_date IS NULL OR c.end_date >= CURRENT_DATE)
LEFT JOIN allowance_details ad 
    ON e.employee_code = ad.employee_code
   AND ad.record_date = DATE_TRUNC('month', CURRENT_DATE)::date
GROUP BY e.employee_code, e.first_name, e.last_name, p.position_name, c.salary
),
-- we calculate the contributions for the current month
total_contributions AS (
    SELECT 
        cd.employee_code,
        COALESCE(SUM(cd.value), 0) AS total_contributions
    FROM contribution_details cd
    WHERE DATE_TRUNC('month', cd.record_date)::date = DATE_TRUNC('month', CURRENT_DATE)::date
    GROUP BY cd.employee_code
),
-- we calculate all deductions (penalties, debts, etc.)
total_deductions AS (
    SELECT 
        dd.employee_code,
        COALESCE(SUM(dd.value), 0) AS total_deductions
    FROM deduction_details dd
    WHERE DATE_TRUNC('month', dd.record_date)::date = DATE_TRUNC('month', CURRENT_DATE)::date
    GROUP BY dd.employee_code
)
SELECT 
    gs.employee_code, gs.employee_name,
    gs.position_name, gs.base_salary,
    gs.total_allowances, gs.gross_salary,
    COALESCE(tc.total_contributions, 0) AS total_contributions,
    COALESCE(td.total_deductions, 0) AS total_deductions,
    (gs.gross_salary - COALESCE(tc.total_contributions, 0) - COALESCE(td.total_deductions, 0)) AS net_salary
FROM gross_salary gs
LEFT JOIN total_contributions tc
    ON gs.employee_code = tc.employee_code
LEFT JOIN total_deductions td
    ON gs.employee_code = td.employee_code
ORDER BY net_salary DESC;


--4. Display the list of employees whose contract expired in 2025 
 -- (Afisati lista angajaților al căror contract a expirat in anul 2025. )
SELECT 
    e.employee_code,
    e.first_name || ' ' || e.last_name AS employee_name,
	c.contract_date, c.end_date
FROM employees e
JOIN contracts c
    ON e.employee_code = c.employee_code
WHERE c.end_date IS NOT NULL
  AND EXTRACT(YEAR FROM c.end_date) = 2025;


--5. What is the number of employees for each department?
 --(Care este numărul de angajați pe fiecare departament ?)

SELECT d.department_code, d.department_name,
       COUNT(p.employee_code) AS total_employees
FROM departments d
LEFT JOIN positions p
    ON d.department_code = p.department_code
GROUP BY d.department_code, d.department_code;

--6. How many days of vacation did each employee have between 2021 and 2022?
 --(Cate zile de concediu a avut fiecare angajat între anii 2021 și 2022?)
 
SELECT e.employee_code,
       e.first_name || ' ' || e.last_name AS employee_name,
	   SUM((ld.end_date - ld.start_date + 1)) AS total_leave_days
FROM employees e
JOIN leave_details ld
   ON e.employee_code = ld.employee_code
WHERE ld.start_date BETWEEN '2021-01-01' AND '2022-12-31'
GROUP BY e.employee_code, e.first_name, e.last_name
ORDER BY total_leave_days DESC;

--6b. Display the number of vacation days for each employee for the years 2021 and 2022.
-- (Afisati numărul de zile de concediu al fiecarui angajat pentru anii 2021 și 2022.)
SELECT 
    e.employee_code,
    e.first_name || ' ' || e.last_name AS employee_name,
    SUM(CASE WHEN EXTRACT(YEAR FROM ld.start_date) = 2021 
             THEN (ld.end_date - ld.start_date + 1) 
             ELSE 0 END) AS days_leave_2021,
    SUM(CASE WHEN EXTRACT(YEAR FROM ld.start_date) = 2022 
             THEN (ld.end_date - ld.start_date + 1) 
             ELSE 0 END) AS days_leave_2022
FROM employees e
LEFT JOIN leave_details ld
    ON e.employee_code = ld.employee_code
GROUP BY e.employee_code, e.first_name, e.last_name
ORDER BY employee_name;

--7.
select * from contributions
select * from contribution_details

--7. Display employees whose contributions exceed 2000 LEI.
-- (Afisati angajatii a căror sumă a contribuțiilor depășește 2000 LEI.)

SELECT 
    e.first_name || ' ' || e.last_name AS employee_name,
    SUM(cd.value) AS total_contributions
FROM employees e
JOIN contribution_details cd
    ON e.employee_code = cd.employee_code
GROUP BY e.employee_code, e.first_name, e.last_name
HAVING SUM(cd.value) > 2000
ORDER BY total_contributions DESC;

--8. Show the employees who have less than 1000 lei in CAS contribution.
-- (Afisatii angajatii care au mai putin de 1000 de lei la contribuția CAS.)
SELECT 
    e.first_name || ' ' || e.last_name AS employee_name,
	cd.contribution_code, cd.value
FROM employees e
LEFT JOIN contribution_details cd
   ON e.employee_code = cd.employee_code
WHERE cd.contribution_code = 'CAS' AND cd.value < 1000
ORDER BY cd.value DESC;


--9. Displays monthly report of gross salaries, total deductions and net salaries for all departments.
--Afisati raportul lunar de salarii brute, total deduceri si salarii net pentru toate departamentele.)

SELECT 
    d.department_name,
    TO_CHAR(cd.record_date, 'YYYY-MM') AS salary_month, -- we aggregate data monthly
    SUM(c.salary + COALESCE(a.total_allowances, 0)) AS gross_salary, --we calculate the gross salary
    SUM(cd.value) AS total_deductions, --we calculate total deductions
    SUM((c.salary + COALESCE(a.total_allowances, 0)) - cd.value) AS net_salary 
	-- we calculate the net salary  = the gross salary - deductions
FROM employees e
JOIN positions p 
    ON e.employee_code = p.employee_code
JOIN departments d 
    ON p.department_code = d.department_code
JOIN contracts c 
    ON e.employee_code = c.employee_code
LEFT JOIN (
    SELECT employee_code, SUM(value) AS total_allowances
    FROM allowance_details
    WHERE DATE_TRUNC('month', record_date) = DATE_TRUNC('month', CURRENT_DATE)
    GROUP BY employee_code
) AS a
    ON e.employee_code = a.employee_code
JOIN contribution_details cd
    ON e.employee_code = cd.employee_code
WHERE DATE_TRUNC('month', cd.record_date) = DATE_TRUNC('month', CURRENT_DATE)
GROUP BY d.department_name, TO_CHAR(cd.record_date, 'YYYY-MM')
ORDER BY salary_month DESC, d.department_name;

--10. Top 3 employees with the most overtime hours in 2025.
 --(top 3 angajati cu cele mai multe ore suplimentare)
select * from timesheets
SELECT 
    e.employee_code,
    e.first_name || ' ' || e.last_name AS employee_name,
    SUM(t.overtime_hours) AS total_overtime_hours
FROM employees e
JOIN timesheets t
    ON e.employee_code = t.employee_code
WHERE EXTRACT(YEAR FROM t.work_date) = 2025
GROUP BY e.employee_code
ORDER BY total_overtime_hours DESC
LIMIT 3;


--11. Who are the employees who earn over 4.000 lei net salary?
 -- Net salary = base salary + bonuses − contributions
SELECT 
    e.first_name || ' ' || e.last_name AS employee_name,
	p.position_name,
    (c.salary + COALESCE(a.total_allowances, 0)) - COALESCE(cd.total_contributions, 0) AS net_salary
FROM employees e
JOIN positions p ON e.employee_code = p.employee_code
JOIN contracts c ON e.employee_code = c.employee_code
LEFT JOIN (
  SELECT employee_code, SUM(value) AS total_allowances
  FROM allowance_details
  GROUP BY employee_code
) a ON e.employee_code = a.employee_code
LEFT JOIN (
	SELECT employee_code, SUM(value) AS total_contributions
	FROM contribution_details
	GROUP BY employee_code
) cd ON e.employee_code = cd.employee_code
WHERE ((c.salary + COALESCE(a.total_allowances, 0)) - COALESCE(cd.total_contributions, 0)) > 4000
ORDER BY net_salary DESC;

--12. Estimate the total salary cost per department if a 5% increase is applied to each salary.
--solution 1
SELECT d.department_name,
       SUM(c.salary) AS total_current_salary,
	   SUM(ROUND(c.salary * 1.05, 2)) AS estimated_nextmonth_salary
FROM employees e
INNER JOIN positions p 
    ON e.employee_code = p.employee_code
INNER JOIN departments d 
    ON p.department_code = d.department_code
INNER JOIN contracts c 
    ON e.employee_code = c.employee_code
GROUP BY d.department_name;

--solution 2 
SELECT d.department_name,
       SUM(e.salary) AS total_current_salary,
	   SUM(ROUND(e.salary * 1.05, 2)) AS estimated_nextmonth_salary
FROM (
    SELECT e.employee_code, MAX(c.salary) AS salary
    FROM employees e
    JOIN contracts c ON e.employee_code = c.employee_code
    GROUP BY e.employee_code
) e
JOIN positions p ON e.employee_code = p.employee_code
JOIN departments d ON p.department_code = d.department_code
GROUP BY d.department_name;

--13. Estimated the total paid leave cost per department by calculating total leave days and 
-- average daily salary, highlighting the overall impact of leave on departmental payroll costs.

SELECT d.department_name,
       SUM(ld.end_date - ld.start_date + 1) AS total_leave_days, --per departament
       ROUND(AVG(c.salary / 21), 2) AS avg_daily_salary, --estimated average daily wage for employees
       ROUND(SUM(c.salary / 21 * (ld.end_date - ld.start_date + 1)), 2) AS estimated_leave_cost
FROM leave_details ld
INNER JOIN employees e
    ON ld.employee_code = e.employee_code
INNER JOIN positions p
    ON e.employee_code = p.employee_code
INNER JOIN departments d
    ON p.department_code = d.department_code
INNER JOIN contracts c
    ON e.employee_code = c.employee_code
GROUP BY d.department_name;


--14. Post-calculation of average cost per department

SELECT d.department_name,
       ROUND(AVG(c.salary), 2) AS avg_salary,
       ROUND(AVG(ad.value), 2) AS avg_allowances, -- average allowances or bonuses
       ROUND(AVG(c.salary + COALESCE(ad.value,0)), 2) AS avg_total_cost  -- average total cost per employee, including salary and bonuses.
FROM employees e
INNER JOIN positions p 
    ON e.employee_code = p.employee_code
INNER JOIN departments d 
    ON p.department_code = d.department_code
INNER JOIN contracts c 
    ON e.employee_code = c.employee_code
LEFT JOIN allowance_details ad
    ON e.employee_code = ad.employee_code
GROUP BY d.department_name;

--15. Calculate the average cost per employee per department, including salary, allowances, 
-- contributions, and deductions, to support post-calculation and cost estimation.

SELECT d.department_name,
       ROUND(AVG(c.salary), 2) AS avg_salary,
       ROUND(AVG(COALESCE(ad.value,0)), 2) AS avg_allowances,
       ROUND(AVG(COALESCE(cd.value,0)), 2) AS avg_contributions,
       ROUND(AVG(COALESCE(dd.value,0)), 2) AS avg_deductions,
       ROUND(AVG(c.salary 
                 + COALESCE(ad.value,0) 
                 + COALESCE(cd.value,0) 
                 - COALESCE(dd.value,0)), 2) AS avg_total_cost
FROM employees e
INNER JOIN positions p 
    ON e.employee_code = p.employee_code
INNER JOIN departments d 
    ON p.department_code = d.department_code
INNER JOIN contracts c 
    ON e.employee_code = c.employee_code
LEFT JOIN allowance_details ad
    ON e.employee_code = ad.employee_code
LEFT JOIN contribution_details cd
    ON e.employee_code = cd.employee_code
LEFT JOIN deduction_details dd
    ON e.employee_code = dd.employee_code
GROUP BY d.department_name;

