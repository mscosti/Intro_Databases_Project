/* Phase 3 of Intro to Databases Project
	uses the Oracle DBMS

	Matt Costi, Ben Senecal
*/

/*	Drop all tables to make sure database
	is cleared before starting
*/
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
DROP VIEW CriticalCases;
DROP VIEW DoctorLoad;

/* Create Entity tables */
CREATE TABLE Employee
(
	ID int PRIMARY KEY,
	fName varchar(20),
	lName varchar(20),
	salary int,
	jobTitle varchar(50),
	officeNum int,
	empRank int,
	supervisorID int,
Constraint empVal check (empRank in (0,1,2))
);

CREATE TABLE Room 
(
	roomNumber int PRIMARY KEY,
	occupiedFlag CHAR(1),
Constraint flag check (occupiedFlag in('Y','N'))
);

CREATE TABLE RoomService
(
	roomNum int,
	serviceName varchar(20),
Foreign Key (roomNum) References Room(roomNumber),
Constraint servicePK Primary Key (roomNum, serviceName)
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
	instructions varchar(500)
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
	comments varchar(50),
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
(00, 'M', 'TimeLord', 'Doctor', 'Who');
INSERT INTO Doctor VALUES
(11, 'M', 'Doctoring', 'Matt', 'Smith');
INSERT INTO Doctor VALUES
(22, 'M', 'Doctoring', 'Chris', 'Eccleston');
INSERT INTO Doctor VALUES
(33, 'M', 'Doctoring', 'Doc4', 'Who');
INSERT INTO Doctor VALUES
(44, 'M', 'Doctoring', 'Doc5', 'Who');
INSERT INTO Doctor VALUES
(55, 'F', 'Doctoring', 'Doc6', 'Who');
INSERT INTO Doctor VALUES
(66, 'F', 'Doctoring', 'Doc7', 'Who');
INSERT INTO Doctor VALUES
(77, 'F', 'Doctoring', 'Doc8', 'Who');
INSERT INTO Doctor VALUES
(88, 'F', 'Doctoring', 'Doc9', 'Who');
INSERT INTO Doctor VALUES
(99, 'F', 'Doctoring', 'Doc10', 'Who');

/* Regular Employee */
INSERT INTO Employee VALUES
(1, 'Bob', 'Smith', 50000, 'secretary', 1001, 0, 11);
INSERT INTO Employee VALUES
(2, 'Sally', 'Sue', 70000, 'Nurse', 1002, 0, 10);
INSERT INTO Employee VALUES
(3, 'Billy', 'Boy', 50000, 'secretary', 1001, 0, 11);
INSERT INTO Employee VALUES
(4, 'Jill', 'Baker', 50000, 'Rehab', 1001, 0, 14);
INSERT INTO Employee VALUES
(5, 'George', 'Gaft', 65000, 'Nurse', 1001, 0, 10);
INSERT INTO Employee VALUES
(6, 'Marge', 'Milstone', 67000, 'Nurse', 1001, 0, 10);
INSERT INTO Employee VALUES
(7, 'Nick', 'Taffrey', 70000, 'Nurse', 1001, 0, 10);
INSERT INTO Employee VALUES
(8, 'Missy', 'McCoon', 45000, 'Janitor', 1001, 0, 13);
INSERT INTO Employee VALUES
(9, 'Frank', 'Libersons', 45000, 'Janitor', 1001, 0, 13);
INSERT INTO Employee VALUES
(12, 'Lilly', 'Lovelock', 50000, 'Rehab', 1001, 0, 14);

/* Division Managers */
INSERT INTO Employee VALUES
(11, 'Div1', 'Mng1', 90000, 'Financial Supervisor',2001,1,15);
INSERT INTO Employee VALUES
(10, 'Div2', 'Mng2', 95000, 'Nurse Supervisor',2001,1,16);
INSERT INTO Employee VALUES
(13, 'Div3', 'Mng3', 90000, 'Facilities Supervisor',2001,1,15);
INSERT INTO Employee VALUES
(14, 'Div4', 'Mng4', 90000, 'Rehab Supervisor',2001,1,16);

/* General Managers */
INSERT INTO Employee VALUES
(15, 'Gen1', 'Mng1', 120000, 'Boss', 3001, 2, NULL);
INSERT INTO Employee VALUES
(16, 'Gen2', 'Mng2', 130000, 'Co-Boss', 3001, 2, NULL);

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
(100, 'ICU');
INSERT INTO RoomService VALUES
(101, 'MRI');
INSERT INTO RoomService VALUES
(100, 'X-Ray');
INSERT INTO RoomService VALUES
(100, 'MRI');
INSERT INTO RoomService VALUES
(104, 'ICU');
INSERT INTO RoomService VALUES
(102, 'ICU');


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
(1001, 'Sonic Screwdriver', 'sonic model', 'be careful');
INSERT INTO EquipmentType VALUES
(1002, 'x-ray', 'Model2', 'instructions go here');
INSERT INTO EquipmentType VALUES
(1004, 'MRI Machine', 'model 42', 'how do magnets work');

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
('X02-bce', 1002, 2003, DATE '2013-01-01', 200);
INSERT INTO Equipment VALUES
('X03-cde', 1002, 2005, DATE '2013-01-01', 201);
INSERT INTO Equipment VALUES
('001-MRI', 1004, 1990, DATE '2012-01-01', 100);
INSERT INTO Equipment VALUES
('002-MRI', 1004, 2000, DATE '2012-01-01', 202);
INSERT INTO Equipment VALUES
('003-MRI', 1004, 2010, DATE '2012-01-01', 203);

INSERT INTO Admission VALUES
(1, DATE '2013-01-01', DATE '2013-01-02',200.00,350.00,DATE '2013-02-01',
	'000-00-0001');
INSERT INTO Admission VALUES
(2, DATE '2013-01-01', DATE '2013-01-02',200.00,500.00, null,
	'000-00-0001');
INSERT INTO Admission VALUES
(3, DATE '2013-01-01', DATE '2013-01-02',200.00,500.00,DATE '2013-02-01',
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
(7, DATE '2013-01-01', DATE '2013-01-02',200.00,150.00,DATE '2013-02-01',
	'111-22-3333');
INSERT INTO Admission VALUES
(8, DATE '2013-01-01', DATE '2013-01-02',200.00,300.00,DATE '2013-05-01',
	'111-22-3333');
INSERT INTO Admission VALUES
(9, DATE '2013-01-01', DATE '2013-01-02',200.00,300.00, null,
	'333-22-4444');
INSERT INTO Admission VALUES
(10, DATE '2013-01-01', DATE '2013-01-02',200.00,602.00, null,
	'333-22-4444');
INSERT INTO Admission VALUES
(11, DATE '2013-01-01', DATE '2013-01-02',200.00,300.00, null,
	'000-00-0008');
INSERT INTO Admission VALUES
(12, DATE '2013-06-01', DATE '2013-06-02',200.00,500.00, null,
	'000-00-0001');
INSERT INTO Admission VALUES
(13, DATE '2013-07-01', DATE '2013-07-02',150.00,400.00, null,
	'000-00-0001');
INSERT INTO Admission VALUES
(14, DATE '2013-08-01', DATE '2013-08-02',100.00,200.00, null,
	'000-00-0001');
INSERT INTO Admission VALUES
(15, DATE '2013-08-01', DATE '2013-08-02',100.00,200.00, null,
	'000-00-0002');


INSERT INTO Examine VALUES
(00, 1, 'Patient is probably terminal');
INSERT INTO Examine VALUES
(00, 2, 'Patient is DEFINITLEY terminal');

INSERT INTO Examine VALUES
(11, 3, 'Patient is probably terminal');
INSERT INTO Examine VALUES
(11, 5, 'Patient is DEFINITLEY terminal');
INSERT INTO Examine VALUES
(11, 7, 'Patient is DEFINITLEY terminal');

INSERT INTO Examine VALUES
(99, 1, 'Patient is DEFINITLEY terminal');
INSERT INTO Examine VALUES
(99, 2, 'Patient is DEFINITLEY terminal');
INSERT INTO Examine VALUES
(99, 3, 'Patient is DEFINITLEY terminal');
INSERT INTO Examine VALUES
(99, 4, 'Patient is DEFINITLEY terminal');
INSERT INTO Examine VALUES
(99, 5, 'Patient is DEFINITLEY terminal');
INSERT INTO Examine VALUES
(99, 6, 'Patient is DEFINITLEY terminal');
INSERT INTO Examine VALUES
(99, 7, 'Patient is DEFINITLEY terminal');
INSERT INTO Examine VALUES
(99, 8, 'Patient is DEFINITLEY terminal');
INSERT INTO Examine VALUES
(99, 9, 'Patient is DEFINITLEY terminal');
INSERT INTO Examine VALUES
(99, 10, 'Patient is DEFINITLEY terminal');
INSERT INTO Examine VALUES
(99, 11, 'Patient is DEFINITLEY terminal');


INSERT INTO StayIn VALUES
(1, 100, DATE '2013-01-01', DATE '2013-01-02');
INSERT INTO StayIn VALUES
(2, 101, DATE '2013-02-02', DATE '2013-03-03');
INSERT INTO StayIn VALUES
(3, 102, DATE '2013-02-02', DATE '2013-02-03');
INSERT INTO StayIn VALUES
(12, 100, DATE '2013-06-01', DATE '2013-06-02');
INSERT INTO StayIn VALUES
(13, 100, DATE '2013-07-01', DATE '2013-07-02');
INSERT INTO StayIn VALUES
(14, 100, DATE '2013-08-01', DATE '2013-08-02');
INSERT INTO StayIn VALUES
(15, 100, DATE '2013-08-01', DATE '2013-08-02');
 
 
/* Part 1 */

CREATE VIEW CriticalCases AS
SELECT SSN AS Patient_SSN, fname AS firstName, lname AS lastName, ICUCount AS numberOfAdmissionsToICU
FROM	(SELECT A.patientSSN, COUNT(ICUAdmits.admissionNum) as ICUCount
			FROM	(SELECT admissionNum, serviceName
						FROM StayIn S, RoomService R
						WHERE S.roomNum = R.roomNum
						AND serviceName = 'ICU') ICUAdmits
					INNER JOIN Admission A ON ICUAdmits.admissionNum = A.admissionNum
			GROUP BY A.PatientSSN) ICUPatients
		INNER JOIN Patient P ON P.SSN = ICUPatients.PatientSSN
WHERE ICUCount > 1; 

CREATE VIEW DoctorLoad AS
SELECT overload.ID AS ID, overload.gender AS Gender, 'overload' as load
FROM	(SELECT D.ID, D.gender, COUNT(DistinctAdmits.admissionNum) as numCases
		FROM 	(SELECT DISTINCT admissionNum, doctorID FROM Examine) DistinctAdmits
				INNER JOIN Doctor D ON D.ID = DistinctAdmits.doctorID
		GROUP BY D.ID, D.gender) overload
WHERE 	overload.numCases > 10
UNION
SELECT overload.ID AS ID, overload.gender AS Gender, 'underload' as load
FROM	(SELECT D.ID, D.gender, COUNT(DistinctAdmits.admissionNum) as numCases
		FROM 	(SELECT DISTINCT admissionNum, doctorID FROM Examine) DistinctAdmits
				INNER JOIN Doctor D ON D.ID = DistinctAdmits.doctorID
		GROUP BY D.ID, D.gender) overload
WHERE 	overload.numCases < 11;

/* report the critical case patients with more than 4 visits to the ICU */
SELECT Patient_SSN, firstName, lastName
FROM CriticalCases
WHERE numberOfAdmissionsToICU > 4;

/* report the female doctors who are overloaded */
SELECT D.ID, D.fName, D.lName
FROM (Doctor D INNER JOIN DoctorLoad DL
	ON DL.ID = D.ID)
WHERE DL.Gender = 'F' AND DL.load = 'overload';

/* report comments inserted by underloaded doctors when examining critical-case patients */
SELECT E.DoctorID, A.patientSSN, E.comments
FROM (Examine E INNER JOIN DoctorLoad DL
	ON E.DoctorID = DL.ID) INNER JOIN Admission A
		ON E.admissionNum = A.admissionNum
WHERE DL.load = 'underload' 
	AND A.patientSSN IN (SELECT Patient_SSN FROM CriticalCases);


/* Part 2 */


/* any room in the hospital can not offer more than 3 services */
CREATE OR REPLACE TRIGGER ServiceCheck
BEFORE INSERT OR UPDATE OF roomNum ON RoomService
FOR EACH ROW
DECLARE
	CURSOR rooms IS (
		SELECT roomNum, count(*) AS numServices FROM RoomService
		GROUP BY roomNum);
BEGIN
	FOR rec IN rooms LOOP
		IF (rec.roomNum = :new.roomNum AND rec.numServices = 3) THEN
			RAISE_APPLICATION_ERROR(-20000, 
				'You can not add more than 3 services to a room');
		END IF;
	END LOOP;
END;
/

 /* insurance payment should be 70% of total payment */
 CREATE OR REPLACE TRIGGER AmountInsurancePaid
 BEFORE INSERT OR UPDATE ON Admission
 FOR EACH ROW
 BEGIN
 	:new.insurancePayment := :new.totalPayment * .7;
 END;
 /

 /* Employees have properly ranked supervisors */
 CREATE OR REPLACE TRIGGER EmployeeSupervisorCheck
 BEFORE INSERT OR UPDATE OF empRank, supervisorID ON Employee
 FOR EACH ROW
 DECLARE
 	CURSOR emps IS (SELECT ID, empRank, supervisorID FROM Employee);
 BEGIN
 	IF (:new.empRank != 2) THEN
	 	FOR emp IN emps LOOP
	 		IF (:new.supervisorID = emp.ID) THEN
	 			IF (:new.empRank != emp.empRank - 1) THEN
	 				RAISE_APPLICATION_ERROR(-20000, 
						'An employees supervisor must be 1 rank higher');
	 			END IF;
	 		END IF;
	 	END LOOP;
	END IF;
 END;
 /

 /* 
 CREATE OR REPLACE TRIGGER EmployeeSupervisorCheck
 BEFORE INSERT OR UPDATE OF empRank, supervisorID ON Employee
 FOR EACH ROW
 DECLARE
 	CURSOR emps IS (
 		SELECT E.empRank AS LowerRank, S.empRank AS UpperRank 
 		FROM (Employee AS E INNER JOIN Employee AS S)
 		ON E.supervisorID = S.ID);
 BEGIN
 	FOR emp IN emps LOOP
 		IF (emp.LowerRank != emp.UperRank - 1) THEN
 			RAISE_APPLICATION_ERROR(-20001, 
				'An employee must have a supervisor who is one rank higher');
 		END IF;
 	END LOOP;
 END;
 /
 */
-- SELECT DISTINCT admissionNum, serviceName
-- 						FROM StayIn S, RoomService R
-- 						WHERE S.roomNum = R.roomNum
-- 						AND serviceName = 'ICU';

-- SELECT SSN, fname, lname, ICUCount
-- FROM	(Select A.patientSSN, COUNT(ICUAdmits.admissionNum) as ICUCount
-- 			FROM	Admission 
-- 			WHERE 	Admission.admissionNum IN
-- 					(SELECT admissionNum
-- 						FROM StayIn S,
-- 						WHERE S.admissionNum IN (SELECT * FROM RoomService WHERE ServiceName = 'ICU'))
-- 			GROUP BY A.PatientSSN)
-- WHERE ICUCount >1;
	



