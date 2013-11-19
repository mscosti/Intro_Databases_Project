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
	empRank varchar(10) /*CHECK*/,
	supervisorID int
);
