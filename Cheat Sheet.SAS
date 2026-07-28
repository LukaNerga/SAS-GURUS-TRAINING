/* SAS Cheat Sheet*/

/* ATTRIBUTES */
variables have 6 atributes : Name , Type , Length , Label , Format , Informat


/*Importing Data*/
proc import
	datafile="PATH TO DATA"
	out=SALARY /*New DataSet Name*/
	dbms=xlsx 
	replace; /*Overwrite*/
	sheet="Sheet1";
	getnames=yes;
	range="B3:D9";
run;


/*INPUT*/
The : tells SAS to read the value using the informat, stopping at a delimiter 
(such as a space) rather than requiring the field to occupy the full width.


/*New Dataset*/

Data DatasetName(Label="Label For Dataset");
	infile datalines dlm='	'; /* Setting Delimeter*/
	length Name $9 Surname $12 TRTGR $11; /*Length of Variables*/
	input Name $ Age; /*Variables one Character one Numeric*/
	datalines;
DATA GOES HERE
;
run;


/*Comparison Operators*/
=   or EQ    equal
^=  or NE    not equal
>   or GT    greater than
<   or LT    less than
>=  or GE    greater than or equal
<=  or LE    less than or equal


/*Library*/
Libname LIBNAME "Path";

Data LibName.Varname;


/*Formatting*/
Proc Format;
	Value Formatname /* NEEDS $ if we are doing char to char */
	OPTIONS;
run;


DOLLAR.
PERCENT.
Z. 
ROMAN.


format VariableName format. 
	;

0 - 10		0 ≤ x ≤ 10 (include both)
0 -< 10		0 ≤ x < 10 (exclude right)
0 <- 10		0 < x ≤ 10 (exclude left)
0 <-< 10	0 < x < 10 (exclude both)

/*If Else*/

if condition1 then X;
Else if condition 2 then y;
else z;



/*WHERE*/
Where is common in PROC

/*Sorting*/

Proc Sort Data= Dataset name out=New Dataset Dupout= Dataset NodupKey;
by ID;
run;

Nodupkey - no duplicate ID
Nodup - no duplicate observations
dupout - duplicates to new dataset 


/*SELECT*/

select (Grade);
    when ('A') Result = 'Excellent';
    when ('B') Result = 'Good';
    when ('C') Result = 'Pass';
    otherwise Result = 'Other';
end;

/*SET*/
KEEP

	data new;
	    set old;
	    keep ID Name Salary;
	run;


DROP

	data new;
	    set old;
	    drop TemporaryVariable;
	run;

/*MERGE*/

before merging we should sort both datasets
3 types of merge : one to one , one to many , many to many (should not use it)

Data Ex4_Final;
	merge Ex4_400(in=a) 
		  Ex4_600(in=b);
	by ID;
	if a and not b;
Run;

if inA;					Keep all observations from A (left merge).
if inB;					Keep all observations from B (right merge).
if inA and inB;			Keep only matching observations (inner join).
if inA or inB;			Keep all observations from either dataset (full outer join).
if inA and not inB;		Keep observations in A only.
if inB and not inA;		Keep observations in B only.
if not inA and inB;		Same as if inB and not inA;.
if not inB and inA;		Same as if inA and not inB;.




/* DO LOOPS*/

Iterative DO loop

	data test;
	    do i = 1 to 5;
	        output;
	    end;
	run;

Do WHILE

	data test;
	    x = 1;
	    do while (x <= 5);
	        output;
	        x + 1;
	    end;
	run;

Do Untill - Always does minimal of one step

	data test;
	    x = 1;
	    do until (x > 5);
	        output;
	        x + 1;
	    end;
	run;


/* FIRST AND LAST*/

proc sort data=sales;
    by CustomerID;
run;

data summary;
    set sales;
    by CustomerID;

    if first.CustomerID then Total = 0;
    Total + Amount;

    if last.CustomerID then output;
run;
