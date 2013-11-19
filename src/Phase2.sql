/* Phase 2 of Intro to Databases Project
	uses the Oracle DBMS

	Matt Costi, Ben Senecal
*/

/*	Drop all tables to make sure database
	is cleared before starting
*/

DROP TABLE Employee;
DROP TABLE EquiptmentType;
DROP TABLE Equipment;
DROP TABLE Room;
DROP TABLE RoomService;
DROP TABLE RoomAccess;
DROP TABLE Patient;
DROP TABLE Doctor;
DROP TABLE Admission;
DROP TABLE Examine;
DROP TABLE StayIn;

CREATE TABLE Employee
(
ID int PRIMARY KEY,
FName varchar(20),
LName varchar(20),
Salary int,
jobTitle varchar(20),
OfficeNum int,
empRank varchar(10) /*CHECK*/,
supervisorID int
);

