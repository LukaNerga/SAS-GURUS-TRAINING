proc import
	datafile="/home/u64552486/sasuser.v94/Homework1.xlsx"
	out= SALARY
	dbms = xlsx
	replace;
	range="B3:D9";
	sheet="Sheet1";
	getnames=yes;
run;

data patients(Label= "Homework 1 Exercise 2") ; 
	
	input
    Name      $ 1-10
    Surname   $ 12-24
    Age         27-28
    Gender    $ 29-35
    TRTGR     $ 36-47
    Temp      $ 48-52
    Height    $ 53-70
    Weight      71-75;
	
	label
    Name     = "Patient First Name"
    Surname  = "Patient Last Name"
    Age      = "Patient Age"
    Gender   = "Patient Gender"
    TRTGR    = "Treatment Group"
    Temp     = "Body Temperature (C)"
    Height   = "Height (cm)"
    Weight   = "Weight (kg)";
    
	datalines;
Artak      Yedigaryan     24 M      Treatment 1 36,3 184               80.1
Mher       Sargsyan       28 M      Treatment 1 36,9 180               73.5
Armenuhi   Ter-Minasyan   61 Female Treatment 2 38,1 Test was not done 66.1
Hasmik     Afyan          52 Female Treatment 2 37   175               75
Margarita  Afrikyan       44 Female Treatment 1 37,3 164               72.7
;
run; 

data a3(Label= "Homework 1 Exercise 3A");
	input
		ID $ 5-7
		Name $ 8-16
		Gender $ 4
		Height 1-3;
    
    label
        ID="ID Number"
        Name="Name of patient"
        Gender="Male or Female"
        Height="Height in CM";
		
	datalines;
184m001Karen
178m002Aristakes
156f003Asya
196f004Irina
;
run;

data b3(label="Homework 1 Exercise 3b");
	infile datalines dlm= '/';
	input SUBJID $ Weight Gender $ Height @@;
	
	label SUBJID="SUBJID" Weight="Weight in KG" Gender="Gender" Height="Height in CM";
	datalines;
001/56/Male/181/002/60/Male/./003/65/Female/178/004/./Male/199
;
run;

data txt4(label="Homework 1 Exercise 4");
    infile "/home/u64552486/sasuser.v94/homework1.txt" dlm='%';
    input Age Weight Height Gender $ Allergic $;

    label
        Age="Age"
        Weight="Weight in KG"
        Height="Height in CM"
        Gender="Male or Female"
        Allergic="Allergic to peanut";
run;
