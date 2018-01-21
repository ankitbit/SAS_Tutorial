/* Código generado (IMPORT) */
/* Archivo de origen: train.csv */
/* Ruta de origen: /folders/myfolders/sasuser.v94 */
/* Código generado el: 4/1/18 22:03 */

%web_drop_table(WORK.IMPORT);
/* Importing the Dataset in the SAS for internal use 
*/
FILENAME REFFILE '/folders/myfolders/Submission/data/train.csv';

PROC IMPORT DATAFILE="/folders/myfolders/Submission/data/train.csv"
OUT=WORK.IMPORT DBMS=CSV REPLACE; 
GETNAMES=YES;
DELIMITER=";"; 
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;

DATA IMPORT;
SET WORK



/* proc sql;  */
/* select count(*) from import; run; */

%web_open_table(WORK.IMPORT);


* Missing variables and outliers present (if any) ;
PROC MEANS DATA= IMPORT  NMISS min max RANGE p10 p90 maxdec= 2 ;
TITLE 'Missing Values and Outliers ';
RUN;

* The results of PROC MEANS suggest that there are no missing values or outliers; 

ODS SELECT ExtremeObs;
PROC UNIVARIATE DATA= IMPORT ;
RUN;


proc boxplot data=import;
   plot AGE*SEX; run;

proc freq data = import;
table SaleType; run;

proc freq data = import;
table SaleCondition; run;

proc boxplot data = import; 
plot AGE = SEX; run;

proc boxplot data= import;
plot HOURS_PER_WEEK*EDUCATION / boxstyle = schematic maxpanels= 20;              
run;



/* simple proc means */

PROC MEANS DATA=WORK.IMPORT; 
VAR AGE; RUN;
* This shows the average age of indivuals in this data set is about 39 years approximately ;

PROC FREQ DATA= WORK.IMPORT;
TABLE AGE; RUN;
/* The result of the PROC FREQ suggests that the individuals with age 37 years are present in  
 maximum percentage (3.12 %). Further, we can observe that almost all age group of indiviudals
 between 18-55 have approximate equal representation in this survey where their age percentage is 
 approximate 2% for each age.
 */

PROC PRINT DATA=IMPORT; RUN;

PROC MEANS DATA=WORK.IMPORT; 
VAR HOURS_PER_WEEK; RUN;
/* The result of previous command shows that most of the indovidual work for about 
40 hours per week. It is despite the fact the Minimum is 1 and Maximum is 99 hours per week.
*/

/*
  The objective of the analysis is to identify how the age of the individuals is related 
  with their profession. We can observe from the results of this analysis that 
  "Individuals in the Armed Forces are least in the number and one of the youngest". 
  This is clearly understood from the profile of the Armed forces which seeks relatively young
  individuals.
 */
PROC SGPLOT DATA=WORK.IMPORT; SCATTER X=OCCUPATION Y=AGE 
/MARKERATTRS=(SYMBOL= CIRCLEFILLED SIZE=2MM COLOR=TOMATO);
TITLE 'ANALYSIS OF AGE OF THE INDVIDUALS AND EDUCATIONAL QUALIFICATION';
RUN;

PROC FREQ DATA=IMPORT; 
TABLES OCCUPATION*AGE; RUN;

/* Analysis of Occupation based on the gender 
  The analysis below shows that most of the females are present in the jobs like clerical, 
  prof-speciality, sales and Managerial roles.
*/
PROC FREQ DATA=IMPORT; 
TABLES SEX*OCCUPATION; RUN;
