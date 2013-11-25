/* Phase 2 of Intro to Databases Project
	uses the Oracle DBMS

	Matt Costi, Ben Senecal
*/

/*	Drop all tables to make sure database
	is cleared before starting
*/
/*select 'drop table '||table_name||' cascade constraints;' from user_tables;*/
DROP TABLE Employee CASCADE CONSTRAINTS;
DROP TABLE Equipment CASCADE CONSTRAINTS;
DROP TABLE EquipmentType CASCADE CONSTRAINTS;
DROP TABLE Room CASCADE CONSTRAINTS;
DROP TABLE RoomService CASCADE CONSTRAINTS;
DROP TABLE RoomAccess CASCADE CONSTRAINTS;
DROP TABLE Patient CASCADE CONSTRAINTS;
DROP TABLE Doctor CASCADE CONSTRAINTS;
DROP TABLE Admission CASCADE CONSTRAINTS;
DROP TABLE Examine CASCADE CONSTRAINTS;
DROP TABLE StayIn CASCADE CONSTRAINTS;
/* Create Entity tables */

CREATE TABLE Employee
(
	ID int PRIMARY KEY,
	fName varchar(20),
	lName varchar(20),
	salary int,
	jobTitle varchar(50),
	officeNum int,
	empRank varchar(11),
	supervisorID int,
Constraint empVal check (empRank in ('Regular','DivisionMng','GeneralMng'))
);

CREATE TABLE Room 
(
	roomNumber int PRIMARY KEY,
	occupiedFlag CHAR(1),
Constraint flag check (occupiedFlag in('Y','N'))
);

CREATE TABLE RoomService
(
	serviceID int,
	roomNum int,
	serviceName varchar(20),
Foreign Key (roomNum) References Room(roomNumber),
Constraint servicePK Primary Key (serviceID,roomNum)
);

CREATE TABLE RoomAccess
(
	roomNum int,
	empID int,
Foreign Key (roomNum) References Room(roomNumber),
Foreign Key (empID) References Employee(ID),
Constraint accessPK Primary Key (roomNum, empID)
);

CREATE TABLE EquipmentType
(
	ID int PRIMARY KEY,
	description varchar(200),
	model varchar(50),
	instructions varchar(500),
	numUnits int
);

CREATE TABLE Equipment
(
	serialNum char(7) PRIMARY KEY,
	typeID int,
	purchaseYear int, 
	lastInspection date,
	roomNum int,
Foreign Key (typeID) References EquipmentType(ID),
Foreign Key (roomNum) References Room(roomNumber)
);

CREATE TABLE Patient
(
	SSN char(11) PRIMARY KEY,
	fName varchar(20),
	lName varchar(20),
	address varchar(100),
	telNum int
);

CREATE TABLE Doctor
(
	ID int PRIMARY KEY,
	gender char(1),
	specialty varchar(20),
	fName varchar(20),
	lName varchar(20),
Constraint genderVal check (gender in ('M', 'F'))
);

CREATE TABLE Admission
(
	admissionNum int PRIMARY KEY,
	admissionDate date,
	leaveDate date,
	totalPayment number(*, 2),
	insurancePayment number(*, 2),
	futureVisitDate date,
	patientSSN char(11),
Foreign Key (patientSSN) References Patient(SSN)
);

CREATE TABLE Examine
(
	doctorID int,
	admissionNum int,
	comments varchar(500),
Foreign Key (doctorID) References Doctor(ID),
Foreign Key (admissionNum) References Admission(admissionNum),
Constraint examinePK Primary Key (doctorID, admissionNum)
); 

CREATE TABLE StayIn
(
	admissionNum int,
	roomNum int,
	startDate date,
	endDate date,
Foreign Key (admissionNum) References Admission(admissionNum),
Foreign Key (roomNum) References Room(roomNumber),
Constraint stayInPK Primary Key (admissionNum, roomNum, startDate)
);

/* insert data into tables */

INSERT INTO Patient VALUES
('111-22-3333', 'Matt', 'Costi','19 East Street, Boston MA 01234',5555555555);
INSERT INTO Patient VALUES
('333-22-4444', 'Ben', 'Senecal','19 East Street apt 7, Boston MA 01234',3333334444);
INSERT INTO Patient VALUES
('000-00-0001', 'Pat1', 'Last1','1 Main Street, Boston MA 01234',1112223333);
INSERT INTO Patient VALUES
('000-00-0002', 'Pat2', 'Last2','2 Main Street, Boston MA 01234',0123456789);
INSERT INTO Patient VALUES
('000-00-0003', 'Pat3', 'Last3','3 Main Street, Boston MA 01234',1212123232);
INSERT INTO Patient VALUES
('000-00-0004', 'Pat4', 'Last4','4 Main Street, Boston MA 01234',1231231234);
INSERT INTO Patient VALUES
('000-00-0005', 'Pat5', 'Last5','5 Main Street, Boston MA 01234',3333333512);
INSERT INTO Patient VALUES
('000-00-0006', 'Pat6', 'Last6','10 North Main Street, Boston MA 01234',1111111111);
INSERT INTO Patient VALUES
('000-00-0007', 'Pat7', 'Last7','20 North Main Street, Boston MA 01234',2222222222);
INSERT INTO Patient VALUES
('000-00-0008', 'Pat8', 'Last8','30 North Main Street, Boston MA 01234',3333333333);

INSERT INTO Doctor VALUES
(00, 'M', 'Doctoring', 'Bill', 'Who');
INSERT INTO Doctor VALUES
(11, 'M', 'Doctoring', 'Bill', 'Who');
INSERT INTO Doctor VALUES
(22, 'M', 'Doctoring', 'Bill', 'Who');
INSERT INTO Doctor VALUES
(33, 'M', 'Doctoring', 'Bill', 'Who');
INSERT INTO Doctor VALUES
(44, 'M', 'Doctoring', 'Bill', 'Who');
INSERT INTO Doctor VALUES
(55, 'F', 'Doctoring', 'Bill', 'Who');
INSERT INTO Doctor VALUES
(66, 'F', 'Doctoring', 'Bill', 'Who');
INSERT INTO Doctor VALUES
(77, 'F', 'Doctoring', 'Bill', 'Who');
INSERT INTO Doctor VALUES
(88, 'F', 'Doctoring', 'Bill', 'Who');
INSERT INTO Doctor VALUES
(99, 'F', 'Doctoring', 'Bill', 'Who');

/* Regular Employee */
INSERT INTO Employee VALUES
(1, 'Bob', 'Smith', 50000, 'secretary', 1001,
	'Regular',11);
INSERT INTO Employee VALUES
(2, 'Sally', 'Sue', 70000, 'Nurse', 1002,
	'Regular',10);
INSERT INTO Employee VALUES
(3, 'Bob', 'Smith', 50000, 'secretary', 1001,
	'Regular',11);
INSERT INTO Employee VALUES
(4, 'Bob', 'Smith', 50000, 'Rehab', 1001,
	'Regular',14);
INSERT INTO Employee VALUES
(5, 'Bob', 'Smith', 65000, 'Nurse', 1001,
	'Regular',10);
INSERT INTO Employee VALUES
(6, 'Bob', 'Smith', 67000, 'Nurse', 1001,
	'Regular',10);
INSERT INTO Employee VALUES
(7, 'Bob', 'Smith', 70000, 'Nurse', 1001,
	'Regular',10);
INSERT INTO Employee VALUES
(8, 'Bob', 'Smith', 45000, 'Janitor', 1001,
	'Regular',13);
INSERT INTO Employee VALUES
(9, 'Bob', 'Smith', 45000, 'Janitor', 1001,
	'Regular',13);
INSERT INTO Employee VALUES
(12, 'Bob', 'Smith', 50000, 'Rehab', 1001,
	'Regular',14);
/* Division Manager */
INSERT INTO Employee VALUES
(11, 'Div1', 'Mng1', 90000, 'Financial Supervisor',2001,
	'DivisionMng',15);
INSERT INTO Employee VALUES
(10, 'Div2', 'Mng2', 95000, 'Nurse Supervisor',2001,
	'DivisionMng',16);
INSERT INTO Employee VALUES
(13, 'Div3', 'Mng3', 90000, 'Facilities Supervisor',2001,
	'DivisionMng',15);
INSERT INTO Employee VALUES
(14, 'Div4', 'Mng4', 90000, 'Rehab Supervisor',2001,
	'DivisionMng',16);
/* General Manager */
INSERT INTO Employee VALUES
(15, 'Gen1', 'Mng1', 120000, 'Boss', 3001,
	'GeneralMng', NULL);
INSERT INTO Employee VALUES
(16, 'Gen2', 'Mng2', 130000, 'Co-Boss', 3001,
	'GeneralMng', NULL);

INSERT INTO Room VALUES
(100, 'N');
INSERT INTO Room VALUES
(101, 'N');
INSERT INTO Room VALUES
(102, 'Y');
INSERT INTO Room VALUES
(103, 'Y');
INSERT INTO Room VALUES
(104, 'N');
INSERT INTO Room VALUES
(200, 'N');
INSERT INTO Room VALUES
(201, 'Y');
INSERT INTO Room VALUES
(202, 'Y');
INSERT INTO Room VALUES
(203, 'Y');
INSERT INTO Room VALUES
(204, 'N');

INSERT INTO RoomService VALUES
(001,100, 'shower');
INSERT INTO RoomService VALUES
(002,100, 'TV');
INSERT INTO RoomService VALUES
(003,100, 'Telephone');
INSERT INTO RoomService VALUES
(001,101, 'shower');
INSERT INTO RoomService VALUES
(004,101, 'service4');
INSERT INTO RoomService VALUES
(005,104, 'service5');
INSERT INTO RoomService VALUES
(002,104, 'TV');
INSERT INTO RoomService VALUES
(002,203, 'TV');


INSERT INTO RoomAccess VALUES
(100, 1);
INSERT INTO RoomAccess VALUES
(101, 1);
INSERT INTO RoomAccess VALUES
(104, 2);
INSERT INTO RoomAccess VALUES
(103, 2);
INSERT INTO RoomAccess VALUES
(200, 3);

INSERT INTO EquipmentType VALUES
(1001, 'Sonic Screwdriver', 'sonic model', 'be careful', 11);
INSERT INTO EquipmentType VALUES
(1002, 'x-ray', 'Model2', 'instructions go here', 20);
INSERT INTO EquipmentType VALUES
(1004, 'MRI Machine', 'model 42', 'how do magnets work', 2);

INSERT INTO Equipment VALUES
('A01-02X', 1001, 2003, DATE '2011-01-01', 101);
INSERT INTO Equipment VALUES
('A02-03X', 1001, 2000, DATE '2011-01-01', 102);
INSERT INTO Equipment VALUES
('A03-04X', 1001, 2007, DATE '2011-01-01', 202);
INSERT INTO Equipment VALUES
('X01-abc', 1002, 1996, DATE '2013-01-01', 100);
INSERT INTO Equipment VALUES
('X02-bcd', 1002, 2003, DATE '2013-01-01', 200);
INSERT INTO Equipment VALUES
('X03-cde', 1002, 2005, DATE '2013-01-01', 201);
INSERT INTO Equipment VALUES
('001-MRI', 1004, 1990, DATE '2012-01-01', 100);
INSERT INTO Equipment VALUES
('002-MRI', 1004, 2000, DATE '2012-01-01', 202);
INSERT INTO Equipment VALUES
('003-MRI', 1004, 2010, DATE '2012-01-01', 203);

INSERT INTO Admission VALUES
(1, DATE '2013-01-01', DATE '2013-01-02',200.00,300.00,DATE '2013-02-01',
	'000-00-0001');
INSERT INTO Admission VALUES
(2, DATE '2013-01-01', DATE '2013-01-02',200.00,300.00, null,
	'000-00-0001');
INSERT INTO Admission VALUES
(3, DATE '2013-01-01', DATE '2013-01-02',200.00,300.00,DATE '2013-02-01',
	'000-00-0002');
INSERT INTO Admission VALUES
(4, DATE '2013-01-01', DATE '2013-01-02',200.00,300.00,DATE '2013-02-01',
	'000-00-0002');
INSERT INTO Admission VALUES
(5, DATE '2013-01-01', DATE '2013-01-02',200.00,300.00, null,
	'000-00-0003');
INSERT INTO Admission VALUES
(6, DATE '2013-01-01', DATE '2013-01-02',200.00,300.00, null,
	'000-00-0003');
INSERT INTO Admission VALUES
(7, DATE '2013-01-01', DATE '2013-01-02',200.00,300.00,DATE '2013-02-01',
	'111-22-3333');
INSERT INTO Admission VALUES
(8, DATE '2013-01-01', DATE '2013-01-02',200.00,300.00,DATE '2013-05-01',
	'111-22-3333');
INSERT INTO Admission VALUES
(9, DATE '2013-01-01', DATE '2013-01-02',200.00,300.00, null,
	'333-22-4444');
INSERT INTO Admission VALUES
(10, DATE '2013-01-01', DATE '2013-01-02',200.00,300.00, null,
	'333-22-4444');
INSERT INTO Admission VALUES
(11, DATE '2013-01-01', DATE '2013-01-02',200.00,300.00, null,
	'000-00-0008');

INSERT INTO Examine VALUES
(00, 1, 'Patient is probably terminal');

INSERT INTO StayIn VALUES
(1, 100, DATE '2013-01-01', DATE '2013-01-02');



/* SQL queries */

/* 1 */
/* This query is to select the hospital rooms that are occupied */
SELECT roomNumber
FROM Room
WHERE occupiedFlag = 'Y';

/* 2 */
/* This query is to select the regular employees supervised by the
	given division manager (in this case 10) */
SELECT ID, fName, lName, salary
FROM Employee
WHERE empRank = 'Regular' AND supervisorID = 10;

/* 3 */
/* This query is to select the patient's SSN and amount paid by the insurance
	over all visits to the hospital */
SELECT patientSSN, SUM(insurancePayment) AS amountPaid
FROM Admission
GROUP BY patientSSN;

/* 4 */
/* This query is to select the patient SSN, first name, last name, and the
	amount of times the patient visited */
SELECT patientSSN, P.fName, P.lName, COUNT(patientSSN) as patientVisits
FROM Admission A, Patient P
WHERE A.patientSSN = P.SSN
GROUP BY patientSSN, P.fName, P.lName;

/* 5 */
/* This query is to report the room number with the serial number 'A01-02X' */
SELECT roomNum
FROM Equipment
WHERE serialNum = 'A01-02X';

/* 6 */
/* This query is to report the employee(s) who has access to the largest number
	of rooms they can access*/
SELECT empID, COUNT(roomNum) AS numRoomsAccessible
FROM RoomAccess
GROUP BY empID
HAVING COUNT(roomNum) = (
	SELECT MAX(COUNT(roomNum))
	FROM RoomAccess
	GROUP BY empID);

/* 7 */
/* This query is to report the number of regular employees, division managers, 
	and general managers */
SELECT empRank AS Type, COUNT(ID) AS Count
FROM Employee
GROUP BY empRank;

/* 8 */
/* This query is to report the SSN, first name, last name, and future visit date
	of patients who have scheduled future visits */
SELECT patientSSN, P.fName, P.lName, futureVisitDate
FROM Admission A, Patient P
WHERE A.patientSSN = P.SSN AND futureVisitDate IS NOT NULL;

/* 9 */
/* This query is to report the equipment type ID, model, and number of units for 
	equipment types that have more than 3 units */
SELECT ID, model, numUnits
FROM EquipmentType
WHERE numUnits > 3;

/* 10 */
/* This query is to report the date of the coming future visit for the patient with
	SSN equal to '111-22-3333' */
SELECT futureVisitDate
FROM Admission
WHERE patientSSN = '111-22-3333'
AND futureVisitDate = 
		(SELECT max(futureVisitDate)
		FROM Admission
		Where patientSSN = '111-22-3333');