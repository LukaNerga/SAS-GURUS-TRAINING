/* SAS Cheat Sheet*/

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
 :

/*New Dataset*/

Data DatasetName(Label="Label For Dataset");
	infile datalines dlm='	'; /* Setting Delimeter*/
	length Name $9 Surname $12 TRTGR $11; /*Length of Variables*/
	input Name $ Age; /*Variables one Character one Numeric*/
	datalines;
DATA GOES HERE
;
run;


