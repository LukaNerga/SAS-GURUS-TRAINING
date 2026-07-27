/*	Homework 5
	27 July 2026
	Luka Nergadze */
	
/* Exercise 1*/

/*1.1	Import SHIFT file to OnDemand using proc step. 
1.2	 Create a DUMMY dataset where there are 3 tests 
(“Basophils“, “Eosinophils“, “Hemoglobin“) to be done 
in 2 visits(1, 2), and for each test in each visit must 
be results “Low“, “Normal“, “High“. 1.3	 Merge DUMMY with 
SHIFT. Replace missing values of FIRST_GRP and SECOND_GRP with 0.*/

proc import
	datafile="/home/u64552486/sasuser.v94/Homework 5/Shift for homework 5.xlsx"
	out= SHIFT
	dbms=xlsx
	replace;
	sheet="Sheet1";
	getnames=yes;
run;


data DUMMY;
length TEST $11 POST_RES $6;
	do TESTNUM= 1 to 3;
			select (TESTNUM);
				when (1) TEST="Basophils";
				when (2) TEST="Eosinophils";
				when (3) TEST="Hemoglobin";
			end;
			
			do VISITNUM = 1 to 2;
				
				do RESULTNUM = 1 to 3;
						select (RESULTNUM);
							when (1) POST_RES="Low";
							when (2) POST_RES="Normal";
							when (3) POST_RES="High";
						end;
					output;
				end;

			end;
		

	end;
drop TESTNUM RESULTNUM;
run;


proc sort data= SHIFT;
by TEST VISITNUM POST_RES;
run;

proc sort data= DUMMY;
by TEST VISITNUM POST_RES;
run;
data FINAL_ONE;
	merge SHIFT DUMMY;
	by TEST VISITNUM POST_RES;
	if missing(FIRST_GRP) then FIRST_GRP = 0;
	if missing(SECOND_GRP) then SECOND_GRP = 0;
run;



/* Exercise 2*/



/*Someone made a $10000 deposit. Interest rate is 3% per year.
 Make a program to get the latest year when deposit will be less
 than $13000. Keep only last value of deposit.*/

Data DEPOSIT_13K;
Deposit = 10000;
Interest_Rate = 3;
Limit = 13000;

format deposit DOLLAR. limit DOLLAR.;

	do While((Deposit + (Deposit * Interest_Rate / 100)) < Limit);
		YEAR + 1;
		Deposit + (Deposit * Interest_Rate / 100);
	end;
	/*keep Deposit; (if we want to only keep deposit number)*/
	output;
run;

/*Exercise 3*/
/*Count how many of the given values are more than 12000.*/

DATA Count_Table;
	infile datalines dlm= '	';
	input Qtr1 Qtr2 Qtr3 Qtr4;
	datalines;
13000	12500	6650	26000
18000	11400	14800	24000
21000	26300	18500	26600
16000	28000	13000	31000
19500	9200	9900	8000
;
run;

DATA Counting;
	SET Count_Table end=last;
	Do Row = 1 to 4;
		Select (Row);
			when (1) Line = Qtr1;
			when (2) Line = Qtr2;
			when (3) Line = Qtr3;
			when (4) Line = Qtr4;
		end;
		
		IF Line > 12000 then More + 1;
	end;
	if last then output;
	keep more;
run;
		
