/*	Homework 3
	22 July 2026
	Luka Nergadze */
	
libname  h3 "/home/u64552486/sasuser.v94/Homework 3";

/*Exercise 1*/
/*1.1*/
data homework_3 (label="1.1 of H3");
	infile datalines dlm=',';
    length Name $9 SURNAME $9 GRADE $2;
	input ID
	Name : $9.
	Score1-Score3 ;
	TOTAL = sum(Score1,Score2,Score3);

/*1.2*/	
label 
	Score1="Score 1"
	Score2="Score 2"
	Score3="Score 3";
	
	/*1.3*/
	if Name in ("Hovhannes","Sargis","Mari","Anna","Hayk") then SURNAME = "Manukyan";
	else SURNAME = "Stepanyan";
	
	/*1.4*/
	if TOTAL >= 280 then GRADE = "A+";
	else if TOTAL >= 260 then GRADE = "A";
	else if TOTAL >= 240 then GRADE = "B";
	else GRADE = "C";
	
datalines;
1,Arsine,99,90,91
2,Sargis,81,85,91
3,Armine,61,68,94
4,Mari,82,82,83
5,Sergey,51,55,71
6,Anna,64,81,81
7,Hovhannes,95,42,94
8,Hayk,100,96,96
;

run;


/*1.5*/
proc format;
	value  NumToGrade 
		280-HIGH = "A+"
		260-<280 = "A"
		240-<260 = "B"
		LOW-<240 = "C";	
run;

/* 1.5, 1.6 and 1.7 */
data H3.h3 (label="Final Dataset");
	set homework_3;
	label Score2 = "";

	format TOTAL NumToGrade.;

	where TOTAL > 200 or (Score1 >= 65 AND Score2 >= 65 AND Score3 >= 65);
run;



/*Exercise 2*/

data Exercise_2;
	set SASHELP.DEMOGRAPHICS;
	
	length RegionName $30;
	Select(Region);
		when("EUR") RegionName = "European Region";
		when("AFR") RegionName = "African Region";
		when("EMR") RegionName = "Eastern Mediterranean Region";
		when("SEAR") RegionName = "South-East Asia Region";
		otherwise RegionName = "Other Regions";
	end;
run;

/*Exercise 3*/

data Exercise_3;
	set MAPSSAS.AFRICA;
run;

proc sort data = Exercise_3 out =SortedAfrica nodupkey;
	by CONT ID SEGMENT;
run;

data FinalData;
	set SortedAfrica;
	where ID >= 400;
run;
