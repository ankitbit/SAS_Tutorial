### Solution to Session 2: Exercises

* Exercise 1;

/*Create the base d: \ CURSAS16_17 \ S02 \ Exercises \ GIRONA.SAS7BDAT from the population data of the sheet
Gerona in the file d: \ CURSAS16_17 \ S02 \ dades_s02 \ POBMUNCAT_CEN01.XLS.
a) How many observations should GIRONA.SAS7BDAT have?
b) How many observations do you have?
c) Modify the syntax of the file Ej1_S02.SAS.
Save the syntax in the Ej1_S02.SAS file.*/

* Solution 1;
libname e 'ruta';

PROC IMPORT OUT= e.GIRONA 
            DATAFILE= "ruta\pobmuncat_cen01.xls" 
            DBMS=XLS REPLACE;
     RANGE="Girona$A1:C222"; 
     GETNAMES=YES;
RUN;

* Exercise 2;

PROC IMPORT OUT= e.BCN 
            DATAFILE= "ruta\pobmuncat_cen01.xls" 
            DBMS=XLS REPLACE;
     RANGE="BCN$B9:F319"; 
     GETNAMES=NO;
RUN;

/* two alternative ways of doing it */

/*First way*/

data e.bcn;
set e.bcn;
keep b d f;
label b='Codigo municipio' d ='Nombre municipio' f = 'Poblacion total';
rename b=p1 d=p2 f=p3;
run;

proc contents data=bcn; run;

/*Second way*/

data e.bcn;
set e.bcn (keep = b d f rename = (b=p1 d=p2 f=p3));
label p1='Codigo municipio' p2 ='Nombre municipio' p3 = 'Poblacion total';
run; 

* ej 3;

PROC EXPORT DATA= e.Girona 
            OUTFILE= "ruta\giro_comes.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;

PROC EXPORT DATA= e.Girona 
            OUTFILE= "ruta\giro_TAB.dat" 
            DBMS=TAB REPLACE;
     PUTNAMES=YES;
RUN;

data giro;
set e.girona;
if total>2200;
run;

PROC EXPORT DATA= WORK.Giro 
            OUTFILE= "ruta\giro.dat"  
            DBMS=DLM REPLACE;
     DELIMITER='00'x; 
     PUTNAMES=YES;
RUN;

PROC EXPORT DATA= e.Girona 
            OUTFILE= "ruta\giro.XLSX" 
            DBMS=XLSX REPLACE;
     SHEET="dades_girona"; 
RUN;


