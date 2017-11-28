
/* Exercise Session 6 (1) (a)
Reading the two datasets from a directory and merging them 
along with providing a third variable for containing record about the origin of data
That is, whether the data is from dataset 1 or from dataset 2
*/

libname w 'C:\Users\fme\Downloads\SAS\Tema6\dades_s06';

data w.asseg_tot; set w.asseg_joves (in=v1) w.asseg_senior ; 
jove=v1; 
run;
proc print data=w.asseg_tot; run;

/* Exercise Session 6 (1) (b)
Sorting the dataset according to the variable npol (Policy Number) */

proc sort data=w.asseg_tot; by npol;
run;
proc print data=w.asseg_tot; run;

/* Exercise Session 6 (1) (c)
Calculating the average age of the total people insured 
*/
proc means data=w.asseg_tot;
var edat;
run;

proc freq data=w.asseg_tot;
tables edat;
run;


/* Exercise Session 6 (2) (a)

*/
DATA w.SENIOR_1; SET w.asseg_senior; RUN;  
DATA w.SENIOR_2; SET w.asseg_senior2; RUN;

PROC PRINT DATA=w.SENIOR_1; RUN;
PROC PRINT DATA=w.SENIOR_2; RUN;
/* Now as we know that sorting the data according to the merging variable 
is necessary. So, weLre going to sort the data according to Policy Numbers (npol)
*/
PROC SORT DATA=w.SENIOR_1; BY npol; RUN;
PROC SORT DATA=w.SENIOR_2; BY npol; RUN;
DATA w.ASSEG_SENIORT; 
MERGE w.SENIOR_1 w.SENIOR_2; BY npol; RUN;

PROC PRINT DATA=w.ASSEG_SENIORT; RUN;

/* Alternative method of doing this described here below */

/* 
Create a data base ASSEG_SENCOST.SAS7BDAT only with the insured who have made
a medical visit (Nvisitas) and including only the variables policy number (Npol) 
and average cost of the visits made for those patients.
 
NOTE: Nvisitas tells the number of visits made to a hospital. In such a case,
We can conclude that for persons, who have not made a medical visit, Nvisitas will 
have the value 0
*/

DATA w.asseg_sencost; SET w.ASSEG_SENIORT;
IF Nvisitas>0;
KEEP npol coste;
RUN;

PROC PRINT DATA=w.asseg_sencost;
RUN;


