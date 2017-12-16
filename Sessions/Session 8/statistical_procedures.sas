/* Session 8: STATISTICAL PROCEDURES */

/* PROC FREQ
It allows you to construct frequency and contingency tables, Chi2 contrast of independence, and ...
It is used for categorical or continuous variables grouped * /

/* BASIC SYNTAX

PROC FREQ DATA = NOMARCHIVO OPTIONS1;
TABLE = VAR1 VAR2 * VAR3 / OPTIONS2;
RUN;

OPTIONS1: Most used

NOPRINT: Suppresses any printout of tables.
ORDER: FREQ / FORMATED / INTERNAL / ... Categories ordered by frequency / formatted value / original value of the variable.
                                  Numbers without formatting appear in ascending order.

OPTIONS2:

CHISQ: to make Chi2 contrast of independence

You can also control the information that appears in the boxes of the contingency tables with the options:
NOROW
NOCOL
NOPERCENT
NOFREQ
EXPECTED
DEVIATION


MISSING: the missing group is treated as a more group and adds it as a category of the table
OUT - allows you to save the calculated frequencies

*/
PROC PRINT DATA=sashelp.cars; RUN;
PROC FREQ DATA=sashelp.cars; TABLES Make; RUN;

/*Counting the number of cars based on their "Make" and "Origin" */
PROC FREQ DATA=sashelp.cars; TABLES Make*Origin; RUN;

/* NOCUM is used to avoid printing the result with Cumulative Frequencies*/
PROC FREQ DATA=sashelp.cars; TABLES Make/NOCUM; RUN;

/* NOPERCERNT is used to avoid printing the result with Percentages of values as well as the
Cumulative Percentage of values */
PROC FREQ DATA=sashelp.cars; TABLES Make/NOPERCENT; RUN;

PROC FREQ DATA=sashelp.cars; TABLES Make*Origin/NOROW; RUN;
PROC FREQ DATA=sashelp.cars; TABLES Make*Origin/NOROW NOCOL; RUN;
PROC FREQ DATA=sashelp.cars; TABLES Make*Origin/NOROW NOCOL NOPERCENT; RUN;

PROC FREQ DATA=sashelp.cars; TABLES Make*Origin/EXPECTED DEVIATION CHISQ NOROW NOCOL; RUN;

libname mylib "/folders/myfolders/Session 8/dades_s08";
PROC FREQ DATA=sashelp.cars; TABLES Make*Origin/NOROW NOCOL NOPERCENT OUT=mylib.CARS_FREQ; RUN;


/* PROC TABULATE

Presentation of results, frequency tables and descriptives. 
Syntax of the operation can be defined as following-

PROC TABULATE DATA = Name_of_Database / [OPTIONS];
[CLASS];
VAR NameV1 NomV2 ..;
TABLES NomV1 * NomV2 .., ...;
RUN;

The list of variables that we put behind TABLES must appear in VAR or in CLASS
In TABLES we put the row levels first, and behind the comma we put what goes into columns

*/


/*Understanding the data by creating its output through the PROC PRINT*/ 
PROC PRINT DATA=sashelp.cars; RUN;

/* Finding the count of Mpg_City based on the values of Type and Make */
PROC TABULATE DATA=sashelp.cars;
CLASS Type Make;
VAR Mpg_City;
TABLES Type*Make, Mpg_City;
RUN;

/* Finding the Mean of the Mpg_City instead of Sum/Count */
PROC TABULATE DATA=sashelp.cars;
CLASS Type Make;
VAR Mpg_City;
TABLES Type*Make, Mpg_City*Mean; /*Change is done here*/
RUN;

/* Finding the mean of multiple variables "Mpg_City" and "Mpg_Highway" */
PROC TABULATE DATA=sashelp.cars;
CLASS Type Make;
VAR Mpg_City Mpg_Highway;
TABLES Type*Make, (Mpg_City*Mean Mpg_Highway*Mean);
RUN;

/*Creating labels in the output*/
PROC TABULATE DATA=sashelp.cars;
CLASS Type Make;
VAR Mpg_City Mpg_Highway;
TABLES Type*Make, (Mpg_City*Mean="Mean of MPG_CITY" Mpg_Highway*Mean="Mean of MPG_HIGHWAY");
RUN;

PROC TABULATE DATA=sashelp.cars;
CLASS Type Make;
VAR Mpg_City;
TABLES Type*Make, Mpg_City*(Sum Mean Min Max Std); /*Change is done here*/
RUN;


/* Finding some summary statistics for two numerical variables based on the levels of a 
   categorical variable in the rows */
PROC TABULATE DATA=sashelp.cars;
CLASS Type;
VAR Mpg_City Mpg_Highway;
TABLES Type,(Mpg_City*(Sum Mean Std) Mpg_highway*(Sum Mean Std));
RUN;

/* If we need an analysis in which we have to keep the levels of categorical variable in the
   columns and the numerical variables in the rows along with their summary statistics, then
   we can follow a procedure something like the one given below-
*/
PROC TABULATE DATA=sashelp.cars;
CLASS Type;
VAR Mpg_City Mpg_Highway;
TABLES (Mpg_City*(Sum Mean Std) Mpg_highway*(Sum Mean Std)),Type;
RUN;




 
