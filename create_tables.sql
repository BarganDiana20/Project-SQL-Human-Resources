-- #######################################################################
--###                Human Resources Database        ###
-- ###                  University Project           ###
-- ###    			by BARGAN DIANA GEORGIANA        ###
-- #######################################################################


-- #######################################################################
-- ###               Database description  ### 

/* This database contains 13 tables:  
├── employees: employee details such as employee code, name, surname, and contact information.
├── positions: the positions held by the employees
├── departments: information about departments
├── contracts: details about employee contracts such as hire date, end date, salary
├── leaves: contains types of leave available
├── leave_details: contains records of employees' leave periods, including start date, end date, and request date.
├── contributions: contains types of legal contributions (CAS, CASS, IV, CAM, etc.).
├── contribution_details: stores the calculated contribution amounts for each employee, with record dates for monthly tracking.
├── allowances: defines the types of allowances or bonuses (e.g., night shift bonus, seniority bonus, overtime bonus)
├── allowance_details: contains monthly details of allowances granted to each employee, with corresponding amounts.
├── deductions: contains types of deductions (e.g., Late Payment Penalty).
├── deduction_details: stores monthly deduction amounts applied to each employee, with dates for reporting.
└── timesheets: records employees' daily work data, including total, regular, overtime, excused, and IT-related hours for each month, 
                along with any associated leave information.

 */
-- #######################################################################


DROP TABLE IF EXISTS contracts, leave_details, leaves, contribution_details, 
deduction_details, allowance_details, positions, timesheets, deductions, 
allowances, contributions, departments, employees CASCADE;

-- Employees
CREATE TABLE employees (
    employee_code    VARCHAR(10) PRIMARY KEY,
    first_name       VARCHAR(255),
    last_name        VARCHAR(255),
    cnp			     VARCHAR(13) UNIQUE NOT NULL,
    email            VARCHAR(100),
    address          VARCHAR(100),
    phone            VARCHAR(15) UNIQUE
);

-- Departments
CREATE TABLE departments (
    department_code  VARCHAR(10) PRIMARY KEY,
    department_name  VARCHAR(50)
);

-- Positions
CREATE TABLE positions (
    position_code    VARCHAR(20) PRIMARY KEY,
    position_name    VARCHAR(40),
    department_code  VARCHAR(10) NOT NULL REFERENCES departments(department_code),
    employee_code    VARCHAR(10) NOT NULL REFERENCES employees(employee_code)
);

-- Contracts
CREATE TABLE contracts (
    contract_code    VARCHAR(20) PRIMARY KEY,
    contract_type    VARCHAR(50),
    contract_number  VARCHAR(20),
    salary           DECIMAL(10,2),
    contract_date    DATE,
    start_date       DATE,
    end_date         DATE,
    employee_code    VARCHAR(10) NOT NULL REFERENCES employees(employee_code)
);

-- Leaves (types)
CREATE TABLE leaves (
    leave_code       VARCHAR(20) PRIMARY KEY,
    leave_type       VARCHAR(60)
);

-- Leave Details
CREATE TABLE leave_details (
    employee_code    VARCHAR(10) NOT NULL REFERENCES employees(employee_code),
    leave_code       VARCHAR(20) NOT NULL REFERENCES leaves(leave_code),
    start_date       DATE,
    end_date         DATE,
    request_date     DATE,
    PRIMARY KEY (employee_code, leave_code)
);

-- Contributions
CREATE TABLE contributions (
    contribution_code VARCHAR(10) PRIMARY KEY,
    contribution_name VARCHAR(30),
    percentage        DECIMAL(5,2)
);
                                              
-- Contribution Details
CREATE TABLE contribution_details (
    employee_code     VARCHAR(10) NOT NULL REFERENCES employees(employee_code),
    contribution_code VARCHAR(10) NOT NULL REFERENCES contributions(contribution_code),
    record_date       DATE NOT NULL,
    value             DECIMAL(15,2),
    PRIMARY KEY (employee_code, contribution_code, record_date)
);                             

-- Deductions
CREATE TABLE deductions (
    deduction_code    VARCHAR(15) PRIMARY KEY,
    deduction_name    VARCHAR(100),
    percentage        DECIMAL(5,2)
);

-- Deduction Details
CREATE TABLE deduction_details (
    employee_code     VARCHAR(10) NOT NULL REFERENCES employees(employee_code),
    deduction_code    VARCHAR(15) NOT NULL REFERENCES deductions(deduction_code),
    record_date       DATE NOT NULL,
    value             DECIMAL(15,2),
    PRIMARY KEY (employee_code, deduction_code, record_date)
);
-- Allowances
CREATE TABLE allowances (
    allowance_code    VARCHAR(15) PRIMARY KEY,
    allowance_type    VARCHAR(100),
    percentage        DECIMAL(5,2)
);

-- Allowance Details
CREATE TABLE allowance_details (
    employee_code     VARCHAR(10) NOT NULL REFERENCES employees(employee_code),
    allowance_code    VARCHAR(15) NOT NULL REFERENCES allowances(allowance_code),
    record_date       DATE NOT NULL,
    value             DECIMAL(15,2),
    PRIMARY KEY (employee_code, allowance_code, record_date)
);

-- Timesheets
CREATE TABLE timesheets (
    timesheet_code    VARCHAR(20) PRIMARY KEY,
    employee_code     VARCHAR(10) NOT NULL REFERENCES employees(employee_code),
    work_date         DATE NOT NULL,
    leave_code        VARCHAR(20) REFERENCES leaves(leave_code),
    total_hours       DECIMAL(5,2),
    regular_hours     DECIMAL(5,2),
    overtime_hours    DECIMAL(5,2),
    excused_hours     DECIMAL(5,2),
    it_hours          DECIMAL(5,2)
);
