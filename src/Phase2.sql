/* Phase 2 of Intro to Databases Project
	uses the Oracle DBMS

	Matt Costi, Ben Senecal
*/

/*	Drop all tables to make sure database
	is cleared before starting
*/
select 'drop table '||table_name||' cascade constraints;' from user_tables;

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
	SSN int PRIMARY KEY,
	firstName varchar(20),
	lastName varchar(20),
	address varchar(30),
	telNum int
);

CREATE TABLE Doctor
(
	ID int PRIMARY KEY,
	gender char(1),
	specialty varchar(20),
	firstName varchar(20),
	lastName varchar(20),
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
	patientSSN int,
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
SELECT patientSSN, fName, lName, COUNT(patientSSN) as patientVisits
FROM Admission A, Patient P
WHERE A.patientSSN = P.SSN
GROUP BY patientSSN;

/* 5 */
SELECT roomNum
FROM Equipment
WHERE serialNum = 'A01-02X';

/* 6 */
SELECT empID, MAX(COUNT(roomNum)) AS numRoomsAccessible
FROM RoomAccess
GROUP BY empID;

/* 7 */
SELECT empRank AS Type, COUNT(ID) AS Count
FROM Employee
GROUP BY empRank;

/* 8 */
SELECT patientSSN, fname, lname, futureVisitDate
FROM Admission
WHERE futureVisitDate IS NOT NULL;

/* 9 */
SELECT ID, model, numUnits
FROM EquipmentType
WHERE numUnits > 3;

