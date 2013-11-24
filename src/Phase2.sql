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
	jobTitle varchar(20),
	officeNum int,
	empRank varchar(11),
	supervisorID int,
Constraint empVal check (empRank in ('Regular','DivisionMng','GeneralMng'))
);

CREATE TABLE Equipment
(
	serialNum char(7) PRIMARY KEY,
	typeID int,
	purchaseYear int, 
	lastInspection date,
	roomNum int
);

CREATE TABLE EquipmentType
(
	ID int PRIMARY KEY,
	description varchar(200),
	model varchar(50),
	instructions varchar(500),
	numUnits int
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
('000-00-0001', 'Matt', 'Costi',
	'19 East Street, Boston MA 01234',
	5555555555);
INSERT INTO Patient VALUES
('000-00-0002', 'Ben', 'Senecal',
	'19 East Street apt 7, Boston MA 01234',
	3333334444);
INSERT INTO Patient VALUES
('000-00-0003', 'Pat1', 'Last1',
	'19 East Street, Boston MA 01234',
	5555555555);
INSERT INTO Patient VALUES
('000-00-0004', 'Pat2', 'Last2',
	'19 East Street, Boston MA 01234',
	5555555555);
INSERT INTO Patient VALUES
('000-00-0005', 'Matt', 'Costi',
	'19 East Street, Boston MA 01234',
	5555555555);
INSERT INTO Patient VALUES
('000-00-0006', 'Matt', 'Costi',
	'19 East Street, Boston MA 01234',
	5555555555);
INSERT INTO Patient VALUES
('000-00-0007', 'Matt', 'Costi',
	'19 East Street, Boston MA 01234',
	5555555555);
INSERT INTO Patient VALUES
('000-00-0008', 'Matt', 'Costi',
	'19 East Street, Boston MA 01234',
	5555555555);
INSERT INTO Patient VALUES
('000-00-0009', 'Matt', 'Costi',
	'19 East Street, Boston MA 01234',
	5555555555);
INSERT INTO Patient VALUES
('000-00-0010', 'Matt', 'Costi',
	'19 East Street, Boston MA 01234',
	5555555555);

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

/* SQL queries */

/* 1 */
SELECT roomNumber
FROM Room
WHERE occupiedFlag = 'Y';

/* 2 */
SELECT ID, fName, lName, salary
FROM Employee
WHERE empRank = 'Regular' AND supervisorID = 10;

/* 3 */
SELECT patientSSN, SUM(insurancePayment) AS amountPaid
FROM Admission
GROUP BY patientSSN;

/* 4 */
SELECT patientSSN, P.fName, P.lName, COUNT(patientSSN) as patientVisits
FROM Admission A, Patient P
WHERE A.patientSSN = P.SSN
GROUP BY patientSSN, P.fName, P.lName;

/* 5 */
SELECT roomNum
FROM Equipment
WHERE serialNum = 'A01-02X';

/* 6 */
SELECT empID, MAX(numRoomsAccessible) AS numRoomsAccessible
FROM (
	SELECT empID, COUNT(roomNum) AS numRoomsAccessible
	FROM RoomAccess
	GROUP BY empID;)

/* 7 */
SELECT empRank AS Type, COUNT(ID) AS Count
FROM Employee
GROUP BY empRank;

/* 8 */
SELECT patientSSN, P.fName, P.lName, futureVisitDate
FROM Admission A, Patient P
WHERE A.patientSSN = P.SSN AND futureVisitDate IS NOT NULL;

/* 9 */
SELECT ID, model, numUnits
FROM EquipmentType
WHERE numUnits > 3;

