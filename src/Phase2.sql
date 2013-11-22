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
	serialNum int PRIMARY KEY,
	typeID int,
	purchaseYear smallint, /*investigate better way for year*/
	lastInspection date,
	roomNum int
);

CREATE TABLE EquipmentType
(
	ID int PRIMARY KEY,
	description text,
	model varchar(50),
	instructions text,
	numUnits int
);

CREATE TABLE Room 
(
	roomNumber int PRIMARY KEY,
	occupiedFlag CHAR(1),
Constraint flag check (occupiedFlag in('Y','N'))
);

CREATE TABLE Service
(
	serviceID int,
	roomNum int,
	serviceName varchar(20),
Foreign Key roomNum References Room(roomNumber),
Constraint pk Primary Key (serviceID,roomNum)
);

CREATE TABLE Patient
(
	SSN int PRIMARY KEY,
	firstName varchar(20),
	lastName varchar(20),
	address varchar(30),
	telNum int
);

