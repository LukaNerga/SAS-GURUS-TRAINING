/*	Homework 4
	23 July 2026
	Luka Nergadze */
	
/* Exercise 1*/
DATA Data_1 (Label= "Exercise 1 Dataset 1");
	infile datalines dlm= ',';
	
	length 
		Name $9
		Surname $9
		Salary $9
		Department $24 ;
		
	input Name $ Surname $ Salary $  Department $;
	datalines;
Daniela,Townsend,$10200.00,Human Resources
Katherine,Bauer,$5800.00,Research and Development
Shane,Stevenson,$6500.00,Production
Neo,Peters,$7200.00,Marketing
Aron,Steele,$3200.00,Accounting and Finance
Eric,Ray,$22000.00,Operations management
;
RUN;

DATA Data_2 (Label="Exercise 1 Dataset 2");
	infile datalines dlm =',';
	length Name $11 Surname $10; 
	input Name $ Number Surname $;
	
	
	datalines;
Aron,15,Hutchinson
Abdulrahman,2,Villegas
Wendy,64,Smith
Karim,9,Benzema
;
RUN;

DATA Exercise_1 (label="Data_1 and Data_2 set ");
	length Name $11 Surname $10;
	set Data_1 Data_2;
	keep Name Salary Number;
	
run;

Proc Sort Data=Exercise_1 out= Exercise_1_Sorted;
	by Name;
RUN;

/*Exercise 2*/

Data Exercise_2;
	set SASHELP.GAS;
run;

proc sort data = Exercise_2 out= Gas_Sorted;
	by Fuel CpRatio;
run;

data Gas_Sorted_Filtered;
	set Gas_Sorted;
	keep Fuel NOx;
Run;

Data Ex2_Data2;
	infile datalines dlm=',';
	input Fuel $ FuelCD $;
	datalines;
Gasohol,F4
Methanol,F2
Ethanol,F5
94%Eth,F6
82rongas,F1
Indolene,F3
;
run;

proc sort Data = Ex2_Data2;
by Fuel;
run;

Data Ex2_Merged;
	merge Gas_Sorted_Filtered Ex2_Data2;
	by Fuel;
run;

proc format;
	value NOx_x
		LOW-<0.35 ="less than 0.35"
		0.35-HIGH = "greater or equal to 0.35";
run;

Data final_EX2;
	set Ex2_Merged;
	format NOx Nox_x.;
run;

/*Exercise 3*/

proc import
	datafile ="/home/u64552486/sasuser.v94/Homework 4/Dataset1.xlsx"
	out= Data_1_3
	dbms=xlsx
	replace;
	sheet = "Sheet1";
	getnames=yes;
run;

proc import
	datafile ="/home/u64552486/sasuser.v94/Homework 4/Dataset2.xlsx"
	out= Data_2_3
	dbms=xlsx
	replace;
	sheet = "Sheet1";
	getnames=yes;
run;

proc sort data=Data_1_3; 
by ID Team;
run;

proc sort data=Data_2_3; 
by ID Team;
run;


data Ex3;
	merge Data_1_3 Data_2_3;
	by ID Team;
RUN;
	
	
/* Exercise 4*/

Data Ex4;
	set MAPSSAS.AFRICA;
	keep CONT ID SEGMENT ;
run;

proc sort Data = Ex4 Out= Africa_Nodup nodupkey;
	by CONT ID SEGMENT;
run;

Data Ex4_400;
	set Africa_Nodup;
	where ID >= 400;
run;

Data Ex4_2;
	set MAPSSAS.AFRICA2;
run;

Data EX4_2_600;
	set Ex4_2;
	where ID <= 600;
run;

proc sort data= Ex4_400 ;
	by ID;
run;

proc sort data= Ex4_2_600 ;
	by ID;
run;


Data Ex4_Final;
	merge Ex4_400(in=a) 
		  Ex4_2_600(in=b);
	by ID;
	if a and not b;
Run;
