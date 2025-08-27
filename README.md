# Project-SQL: Employee Payroll and Human Resources Management Database 

This database was designed to manage employee information, payroll, attendance, leaves, allowances, deductions, and contributions. It supports HR operations by storing detailed employee records, including employment contracts, timesheets, leave history, and compensation data. The database enables the generation of various reports and analyses to facilitate payroll processing, leave tracking, and contribution monitoring.

This database contains 13 tables:  
* employees: employee details such as employee code, name, surname, and contact information.  
* positions: the positions held by the employees.  
* departments: information about departments.  
* contracts: details about employee contracts such as hire date, end date, salary.  
* leaves: contains types of leave available.  
* leave_details: contains records of employees' leave periods, including start date, end date, and request date.  
* contributions: contains types of legal contributions (CAS, CASS, IV, CAM, etc.).  
* contribution_details: stores the calculated contribution amounts for each employee, with record dates for monthly tracking.  
* allowances: defines the types of allowances or bonuses (e.g., night shift bonus, seniority bonus, overtime bonus)  
* allowance_details: contains monthly details of allowances granted to each employee, with corresponding amounts.  
* deductions: contains types of deductions (e.g., Late Payment Penalty).  
* deduction_details: stores monthly deduction amounts applied to each employee, with dates for reporting.  
* timesheets: records employees' daily work data, including total, regular, overtime, excused, and IT-related hours for each month, along with any associated leave information.  
                
The description of the database scheme can be viewed in the following image:
<img width="1185" height="779" alt="scheme_human_resources_database" src="https://github.com/user-attachments/assets/1f0a669b-450f-4e9f-b1f8-6214dd01fdc4" />

