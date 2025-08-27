-- #######################################################################
-- ###                Human Resources Database        ###
-- ###                  University Project            ###
-- ###    			 by BARGAN DIANA GEORGIANA        ###
-- #######################################################################

-- ###               Data insertion in the database   ### 
-- #######################################################################


INSERT INTO employees (employee_code, first_name, last_name, cnp, email, address, phone)
VALUES 
('SS01','Stefan','Stanciu','1890502098731','savina_voinea28@yahoo.com','Strada Putul lui Zamfir 26','0747113806'),
('PS02','Sonia','Pindaru','2970626231174','floare.zamfir@hotmail.com','Strada Nitu Vasile 14, Bucuresti','0213110179'),
('GL03','Lidia','Gherban','6030412463869','arsenie13@hotmail.com','Calea Vacaresti 391, Bucuresti','0245207677'),
('VH04','Horia','Voinea','6011010197991','cipriana_costea@yahoo.com','Bulevardul Dacia 11, Bucuresti','0723519035'),
('DC05','Corina','Dragan','6010905269381','aristita54@yahoo.com','Str. Dealul Biserici Nr. 67-109, Bucuresti','0744795316'),
('GC06','Cristi','Gheorghiu','1931119176996','bernard_maxim@hotmail.com','Bulevardul Mihail Kogalniceanu 70-72, Bucuresti','0722555235'),
('RG07','Geanina','Radu','6020610373582','brandusa21@yahoo.com','Drobeta Street 23, Bucuresti','0261854403'),
('LM08','Mara','Lamboiu','2870124299420','norica.blaga24@hotmail.com','Strada Barbu Vacarescu 201, Bucuresti','0723942368'),
('VL09','Lucia','Vilculescu','1950503077246','patru64@hotmail.com','Strada Fabricii 22, Bucuresti','0214109048'),
('DC10','Corina','Dumitru','2920119156070','alex66@yahoo.com','Str. Dealul Biserici Nr. 67-109, Bucuresti','0243213576');

INSERT INTO departments (department_code, department_name)
VALUES
('DPF', 'Finance'),
('DPP', 'Production'),
('DPV', 'Sales'),
('DPHR', 'HR'),
('DIT', 'IT'),           
('DPM', 'Marketing');   

INSERT INTO positions (position_code, position_name, department_code, employee_code)
VALUES
('EC','Economist','DPF','SS01'),
('CO','Accountant','DPF','PS02'),
('LC','Sales Clerk','DPV','GL03'),       
('OP','Machine Operator','DPP','VH04'),
('MK','Marketer','DPM','DC05'),         
('AN','Data Analyst','DIT','GC06'),       
('RC','Recruiter','DPHR','RG07'),
('SC','Secretary','DPHR','LM08'),
('MG','Manager','DPP','VL09'),
('IF','Programmer','DIT','DC10');         

INSERT INTO contracts (contract_code, contract_type, contract_number, salary, contract_date, start_date, end_date, employee_code)
VALUES
('C4Q2GUFU','fixed_term','CR001',4000,'2021-04-06','2021-04-16','2025-04-16','SS01'),
('PQG9BKQ6','fixed_term','CR002',5400,'2021-04-06','2021-04-16','2026-04-16','PS02'),
('U9ZX8TGZ','permanent','CR003',4700,'2021-04-06','2021-04-16',NULL,'GL03'),
('CGCQV5XN','fixed_term','CR004',5500,'2021-04-06','2021-04-16','2028-04-16','VH04'),
('TEUYFZ9X','permanent','CR005',3900,'2021-04-06','2021-04-16',NULL,'DC05'),
('AQEY9J95','permanent','CR006',3800,'2021-04-06','2021-04-16',NULL,'GC06'),
('5X78HEYF','permanent','CR007',5100,'2021-04-06','2021-04-16',NULL,'RG07'),
('A9MKMF7T','permanent','CR008',3300,'2021-04-06','2021-04-16',NULL,'LM08'),
('624KMR6U','fixed_term','CR009',3200,'2021-04-06','2021-04-16','2029-04-16','VL09'),
('YTTRMB8J','fixed_term','CR010',5500,'2021-04-06','2021-04-16','2031-04-16','DC10');

INSERT INTO leaves (leave_code, leave_type)
VALUES
('L001', 'Annual Leave'),
('L002', 'Professional Training'),
('L003', 'Unpaid Leave'),
('L004', 'Medical Leave'),
('L005', 'Work Accident Leave'),
('L006', 'Maternity Leave'),
('L007', 'Paternity Leave'),
('L008', 'Childcare Leave'),
('L009', 'Sick Child Care Leave'),
('L010', 'Quarantine Leave');

INSERT INTO leave_details (employee_code, leave_code, start_date, end_date, request_date)
VALUES
('SS01','L001','2021-05-01','2021-05-01','2021-04-21'),
('PS02','L002','2021-05-21','2021-06-01','2021-04-21'),
('GL03','L003','2021-06-11','2021-06-16','2021-04-21'),
('VH04','L004','2021-07-01','2021-07-17','2021-06-21'),
('DC05','L005','2021-07-21','2021-08-01','2021-07-18'),
('GC06','L006','2021-09-21','2021-10-01','2021-08-21'),
('RG07','L007','2021-10-23','2021-11-01','2021-10-21'),
('LM08','L008','2022-05-21','2022-06-01','2022-04-21'),
('VL09','L009','2022-06-21','2022-07-01','2022-05-21'),
('DC10','L010','2022-10-21','2022-11-01','2022-10-15');


INSERT INTO contributions (contribution_code, contribution_name, percentage)
VALUES
('CAS','Pension Contribution',0.25),
('CASS','Health Insurance',0.10),
('DP','Personal Deduction',NULL),
('IV','Income Tax',0.10),
('CAM','Work Insurance',0.0225);

-- !! observations for table 'contribution_details' :
	--CAS = social security contribution
	--CASS = health
	--IV = income tax
	--CAM = employment insurance
	--DP = personal deductions (in the example, set to 0).
INSERT INTO contribution_details (employee_code, contribution_code, record_date, value)
VALUES
-- SS01
('SS01','CAS',CURRENT_DATE,4000*0.25),
('SS01','CASS',CURRENT_DATE,4000*0.10),
('SS01','DP',CURRENT_DATE,0),
('SS01','IV',CURRENT_DATE,4000*0.10),
('SS01','CAM',CURRENT_DATE,4000*0.0225),
-- PS02
('PS02','CAS',CURRENT_DATE,5400*0.25),
('PS02','CASS',CURRENT_DATE,5400*0.10),
('PS02','DP',CURRENT_DATE,0),
('PS02','IV',CURRENT_DATE,5400*0.10),
('PS02','CAM',CURRENT_DATE,5400*0.0225),
-- GL03
('GL03','CAS',CURRENT_DATE,4700*0.25),
('GL03','CASS',CURRENT_DATE,4700*0.10),
('GL03','DP',CURRENT_DATE,0),
('GL03','IV',CURRENT_DATE,4700*0.10),
('GL03','CAM',CURRENT_DATE,4700*0.0225),
-- VH04
('VH04','CAS',CURRENT_DATE,5500*0.25),
('VH04','CASS',CURRENT_DATE,5500*0.10),
('VH04','DP',CURRENT_DATE,0),
('VH04','IV',CURRENT_DATE,5500*0.10),
('VH04','CAM',CURRENT_DATE,5500*0.0225),
-- DC05
('DC05','CAS',CURRENT_DATE,3900*0.25),
('DC05','CASS',CURRENT_DATE,3900*0.10),
('DC05','DP',CURRENT_DATE,0),
('DC05','IV',CURRENT_DATE,3900*0.10),
('DC05','CAM',CURRENT_DATE,3900*0.0225),
-- GC06
('GC06','CAS',CURRENT_DATE,3800*0.25),
('GC06','CASS',CURRENT_DATE,3800*0.10),
('GC06','DP',CURRENT_DATE,0),
('GC06','IV',CURRENT_DATE,3800*0.10),
('GC06','CAM',CURRENT_DATE,3800*0.0225),
-- RG07
('RG07','CAS',CURRENT_DATE,5100*0.25),
('RG07','CASS',CURRENT_DATE,5100*0.10),
('RG07','DP',CURRENT_DATE,0),
('RG07','IV',CURRENT_DATE,5100*0.10),
('RG07','CAM',CURRENT_DATE,5100*0.0225),
-- LM08
('LM08','CAS',CURRENT_DATE,3300*0.25),
('LM08','CASS',CURRENT_DATE,3300*0.10),
('LM08','DP',CURRENT_DATE,0),
('LM08','IV',CURRENT_DATE,3300*0.10),
('LM08','CAM',CURRENT_DATE,3300*0.0225),
-- VL09
('VL09','CAS',CURRENT_DATE,3200*0.25),
('VL09','CASS',CURRENT_DATE,3200*0.10),
('VL09','DP',CURRENT_DATE,0),
('VL09','IV',CURRENT_DATE,3200*0.10),
('VL09','CAM',CURRENT_DATE,3200*0.0225),
-- DC10
('DC10','CAS',CURRENT_DATE,5500*0.25),
('DC10','CASS',CURRENT_DATE,5500*0.10),
('DC10','DP',CURRENT_DATE,0),
('DC10','IV',CURRENT_DATE,5500*0.10),
('DC10','CAM',CURRENT_DATE,5500*0.0225);


INSERT INTO deductions (deduction_code, deduction_name, percentage)
VALUES
('DED001', 'Late Payment Penalty', 0.05),
('DED002', 'Inappropriate Behavior Penalty', 0.07),
('DED003', 'Workplace Safety Violation Penalty', 0.03),
('DED004', 'Abuse of Office Penalty', 0.10),
('DED005', 'Damages Recovery Deduction', 0.05),
('DED006', 'Miscellaneous Debts to Company', 0.05),
('DED007', 'Union Fee Deduction', 0.01);

INSERT INTO deduction_details (employee_code, deduction_code, record_date, value)
VALUES
-- SS01 (Stefan Stanciu - Economist)
('SS01', 'DED001', date_trunc('month', CURRENT_DATE)::date, 4000 * 0.05),  -- Late penalties
('SS01', 'DED007', date_trunc('month', CURRENT_DATE)::date, 4000 * 0.01), -- Union fee Deduction
-- PS02 (Sonia Pindaru - Accountant)
('PS02', 'DED002', date_trunc('month', CURRENT_DATE)::date, 5400 * 0.07), -- Inappropriate behavior penalties
('PS02', 'DED007', date_trunc('month', CURRENT_DATE)::date, 5400 * 0.01), -- Union fee Deduction
-- GL03 (Lidia Gherban - Sales Clerk)
('GL03', 'DED003', date_trunc('month', CURRENT_DATE)::date, 4700 * 0.03), -- Workplace Safety violation penaltie
('GL03', 'DED007', date_trunc('month', CURRENT_DATE)::date, 4700 * 0.01), -- Union fee Deduction
-- VH04 (Horia Voinea - Machine Operator)
('VH04', 'DED004', date_trunc('month', CURRENT_DATE)::date, 5500 * 0.10), -- Abuse of office penalty
('VH04', 'DED005', date_trunc('month', CURRENT_DATE)::date, 5500 * 0.05), -- Damage coverage
('VH04', 'DED007', date_trunc('month', CURRENT_DATE)::date, 5500 * 0.01), -- Union fee Deduction
-- DC05 (Corina Dragan - Marketer)
('DC05', 'DED006', date_trunc('month', CURRENT_DATE)::date, 3900 * 0.05), -- Debt coverage to company
('DC05', 'DED007', date_trunc('month', CURRENT_DATE)::date, 3900 * 0.01), -- Union fee Deduction
-- GC06 (Cristi Gheorghiu - Data Analyst)
('GC06', 'DED007', date_trunc('month', CURRENT_DATE)::date, 3800 * 0.01), -- Union fee Deduction
-- RG07 (Geanina Radu - Recruiter)
('RG07', 'DED001', date_trunc('month', CURRENT_DATE)::date, 5100 * 0.05), -- Late payment penalty
('RG07', 'DED007', date_trunc('month', CURRENT_DATE)::date, 5100 * 0.01), -- Union fee Deduction
-- LM08 (Mara Lamboiu - Secretary)
('LM08', 'DED005', date_trunc('month', CURRENT_DATE)::date, 3300 * 0.05), -- Damage coverage
('LM08', 'DED007', date_trunc('month', CURRENT_DATE)::date, 3300 * 0.01), -- Union fee Deduction
-- VL09 (Lucia Vilculescu - Manager)
('VL09', 'DED004', date_trunc('month', CURRENT_DATE)::date, 3200 * 0.10), -- Abuse of office penalty
('VL09', 'DED007', date_trunc('month', CURRENT_DATE)::date, 3200 * 0.01), -- Union fee Deduction
-- DC10 (Corina Dumitru - Programmer)
('DC10', 'DED002', date_trunc('month', CURRENT_DATE)::date, 5500 * 0.07), -- Inappropriate behavior penalty
('DC10', 'DED007', date_trunc('month', CURRENT_DATE)::date, 5500 * 0.01); -- Union fee Deduction


INSERT INTO allowances (allowance_code, allowance_type, percentage)
VALUES
('AL001','Night Shift Bonus',0.25),
('AL002','Hazard Bonus',0.12),
('AL003','Seniority Bonus',0.05),
('AL004','Holiday Work Bonus',1.0),
('AL005','Overtime Bonus',0.75),
('AL006','Special Bonus',0.15);

--var ok cu sporuri realiste
INSERT INTO allowance_details (employee_code, allowance_code, record_date, value)
VALUES
-- SS01 - Stefan Stanciu, Economist, salariu 4000
('SS01','AL001', DATE_TRUNC('month', CURRENT_DATE)::date, 4000*0.10), -- Night Shift 10%
('SS01','AL004', DATE_TRUNC('month', CURRENT_DATE)::date, 4000*0.15), -- Holiday Work 15%
('SS01','AL006', DATE_TRUNC('month', CURRENT_DATE)::date, 4000*0.05), -- Special Bonus 5%

-- PS02 - Sonia Pindaru, Accountant, salariu 5400
('PS02','AL001', DATE_TRUNC('month', CURRENT_DATE)::date, 5400*0.10),
('PS02','AL004', DATE_TRUNC('month', CURRENT_DATE)::date, 5400*0.15),
('PS02','AL006', DATE_TRUNC('month', CURRENT_DATE)::date, 5400*0.05),

-- GL03 - Lidia Gherban, Sales Clerk, salariu 4700
('GL03','AL001', DATE_TRUNC('month', CURRENT_DATE)::date, 4700*0.15),
('GL03','AL002', DATE_TRUNC('month', CURRENT_DATE)::date, 4700*0.08),
('GL03','AL004', DATE_TRUNC('month', CURRENT_DATE)::date, 4700*0.10),
('GL03','AL005', DATE_TRUNC('month', CURRENT_DATE)::date, 4700*0.10),

-- VH04 - Horia Voinea, Machine Operator, salariu 5500
('VH04','AL001', DATE_TRUNC('month', CURRENT_DATE)::date, 5500*0.12),
('VH04','AL002', DATE_TRUNC('month', CURRENT_DATE)::date, 5500*0.08),
('VH04','AL005', DATE_TRUNC('month', CURRENT_DATE)::date, 5500*0.12),
-- DC05 - Corina Dragan, Marketer, salariu 3900
('DC05','AL004', DATE_TRUNC('month', CURRENT_DATE)::date, 3900*0.12),
('DC05','AL006', DATE_TRUNC('month', CURRENT_DATE)::date, 3900*0.05),
-- GC06 - Cristi Gheorghiu, Data Analyst, salariu 3800
('GC06','AL005', DATE_TRUNC('month', CURRENT_DATE)::date, 3800*0.10),
('GC06','AL006', DATE_TRUNC('month', CURRENT_DATE)::date, 3800*0.05),
-- RG07 - Geanina Radu, Recruiter, salariu 5100
('RG07','AL003', DATE_TRUNC('month', CURRENT_DATE)::date, 5100*0.05),
('RG07','AL004', DATE_TRUNC('month', CURRENT_DATE)::date, 5100*0.12),
('RG07','AL006', DATE_TRUNC('month', CURRENT_DATE)::date, 5100*0.05),
-- LM08 - Mara Lamboiu, Secretary, salariu 3300
('LM08','AL003', DATE_TRUNC('month', CURRENT_DATE)::date, 3300*0.05),
('LM08','AL004', DATE_TRUNC('month', CURRENT_DATE)::date, 3300*0.12),
('LM08','AL005', DATE_TRUNC('month', CURRENT_DATE)::date, 3300*0.10),
-- VL09 - Lucia Vilculescu, Manager, salariu 3200
('VL09','AL004', DATE_TRUNC('month', CURRENT_DATE)::date, 3200*0.12),
('VL09','AL006', DATE_TRUNC('month', CURRENT_DATE)::date, 3200*0.05),
-- DC10 - Corina Dumitru, Programmer, salariu 5500
('DC10','AL005', DATE_TRUNC('month', CURRENT_DATE)::date, 5500*0.10),
('DC10','AL006', DATE_TRUNC('month', CURRENT_DATE)::date, 5500*0.05);

INSERT INTO timesheets (timesheet_code, employee_code, work_date, leave_code, total_hours, 
    regular_hours,overtime_hours, excused_hours, it_hours) 
VALUES
-- SS01 - Economist, birou, fără concediu, ore normale
('TS01', 'SS01', DATE_TRUNC('month', CURRENT_DATE)::date, NULL, 160, 160, 4, 0, 0),
-- PS02 - Accountant, fără concediu, câteva ore suplimentare
('TS02', 'PS02', DATE_TRUNC('month', CURRENT_DATE)::date, NULL, 162, 160, 2, 0, 0),
-- GL03 - Sales Clerk, a avut concediu de 3 zile (24h), câteva ore suplimentare
('TS03', 'GL03', DATE_TRUNC('month', CURRENT_DATE)::date, 'L003', 144, 144, 8, 0, 0),
-- VH04 - Machine Operator, a lucrat ore suplimentare semnificative
('TS04', 'VH04', DATE_TRUNC('month', CURRENT_DATE)::date, NULL, 172, 160, 12, 0, 0),
-- DC05 - Marketer, 2 zile concediu, câteva ore suplimentare
('TS05', 'DC05', DATE_TRUNC('month', CURRENT_DATE)::date, 'L005', 152, 152, 6, 0, 0),
-- GC06 - Data Analyst, concediu lung (10 zile libere)
('TS06', 'GC06', DATE_TRUNC('month', CURRENT_DATE)::date, 'L006', 120, 120, 0, 0, 0),
-- RG07 - Recruiter, o zi de concediu
('TS07', 'RG07', DATE_TRUNC('month', CURRENT_DATE)::date, 'L007', 152, 152, 0, 0, 0),
-- LM08 - Secretary, normal program
('TS08', 'LM08', DATE_TRUNC('month', CURRENT_DATE)::date, NULL, 160, 160, 0, 0, 0),
-- VL09 - Manager, a stat o zi în ședințe externe (ore justificate)
('TS09', 'VL09', DATE_TRUNC('month', CURRENT_DATE)::date, NULL, 158, 158, 0, 8, 0),
-- DC10 - Programmer, câteva ore suplimentare
('TS10', 'DC10', DATE_TRUNC('month', CURRENT_DATE)::date, NULL, 166, 160, 6, 0, 10);
