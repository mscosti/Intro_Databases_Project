/* Phase 2 of Intro to Databases Project
	uses the Oracle DBMS

	Matt Costi, Ben Senecal
*/
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