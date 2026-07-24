/*	Homework 2
	19 July 2026
	Luka Nergadze */
	
	
/*Exercise 1*/

libname h2 "/home/u64552486/sasuser.v94/Homework 2";

data exercise_1 (label="Exercise 1");
	infile datalines dlm=',';
	input
		ID : 3.
		NS : $25.
		COL1 : $1.
		COL2
		COL3 : $3.
		COL4
		COL5;
	format ID z3.;
		
	label
		ID = "ID of Patient"
		NS = "Name And Surname"
		COL1 = "Gender"
		COL2 = "Weight"
		COL3 = "Weight Unit"
		COL4 = "DATA 1"
		COL5 = "DATA 2" ;	
	datalines;
001,Karen Vardanyan,m,96.915,kg,1045.12,18.66
002,Maria Aramyan,f,78.188,kg,1201.6,19.166
003,Harutyun Manukyan,m,56.866,kg,1255.89,16.667
004,Irina Alixanyan,f,80,kg,1450.11,19.1416
005,Karine Arustamyan,f,79.95,kg,1442.45,17.77777
;
run;

/*Exercise 2*/

/*Gender to Full WOrd*/
proc format;
	value $gender
		'm'='Male'
		'M'='Male'
		'F'='Female'
		'f'='Female';
run;

/*Weight to 80*/
proc format;
	value weight
	low-<80='Less than 80'
	80='Equal to 80'
	80<-high='More than 80';
	
run;

/*Formatting Exercise 1 */
data h2.exercise_2(label="Exercise 2 and 3 combined");
	set exercise_1;
	format 
		ID roman5.
		COL1 $gender.
		COL2 weight.
		COL4 DOLLAR9.1
		COL5 5.2;
run;


