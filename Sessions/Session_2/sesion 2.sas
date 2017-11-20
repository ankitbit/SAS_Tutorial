/* Sesi?n 2 */ 

/*
Lectura de datos 

I UTILIZACI?N DE BASES DE DATOS EN FORMATO SAS (*.SAS7BDAT) 

  1.1 Como acceder a bases de datos en formato SAS desde un BLOC DATA 
  1.2 Como acceder a bases de datos en formato SAS desde un BLOC PROC 

II IMPORTACI?N/EXPORTACI?N FORMATOS EXCEL, SPSS, ACCESS, SPSS ... 

  2.1 IMPORTACI?N DE DATOS EN OTROS FORMATOS (EXCEL, SPSS ...) 
  2.2 EXPORTACI?N DE DATOS SAS A OTROS FORMATOS (EXCEL, SPSS ...) 

*/ 

 

*I UTILIZACI?N DE BASES DE DATOS EN FORMATO SAS (*.SAS7BDAT); 

/*1.1 Como acceder a bases de datos en formato SAS desde un BLOC DATA*/ 

*Una librer?a es simplemente un link que se establece desde SAS a una ruta f?sica en el disco; 
*El usuario puede definir sus propias librer?as utilizando el comando LIBNAME; 
 
LIBNAME libref 'C:\Users\fme\Downloads\tema 2'; 

*libref is a name that the user decides max 8 characters (whichever you want), and 
'k: \ route' is the structure of folders that you want to link with SAS;

libname carpeta 'C:\Users\fme\Downloads\tema 2\dades s02'; 

*1 Message in the log 

NOTE: Libref CARPETA was successfully assigned as follows: 
Physical Name: d:\CURSAS16_17\S02\; 

* 2 In the explorer window you should see a library with the name that you gave it;

/* In the same session it may be necessary to execute more than one LIBNAME command depend? from where
are the databases that we need to use and where we want to create them
LIBNAME libref ?k:\ruta?; 
LIBNAME libref2 ?k:\ruta2?; 
LIBNAME librefj ?k:\rutaj?;*/ 

/*Syntax of BLOC DATA with libref*/ 

DATA libref.nombre_nueva_base [(opciones)]; /*the bases that are going to be created*/ 
SET libref.nombre_ base_existente [opciones]; /*The bases that are already created*/ 
/*m?s comandos;*/ 
RUN; 


*example from the base Girona.sas7bdat I will create a new base in
the same route to be? Girona_red.sas7bdat (I only want the first 20 observations);

data carpeta.girona_red; /*Is this the foundation that will be created?*/ 
set carpeta.girona (obs = 20) ; /*This is the one that enters (already exists)*/ 
run; 



/*log 

There were 20 observations read from the data set E.GIRONA. 
NOTE: The data set CARPETA.GIRONA_RED has 20 observations and 3 variables*/ 

*Otra posibildad es hacerlo como:; 


data 'd:\CURSAS16_17\S02\dades s02\girona_red'; 
set 'd:\CURSAS16_17\S02\dades s02\girona' (obs = 20); 
run; 

/* But given that SAS actually, whatever we do, internally only works with libraries
and not in all the procs let us make a specification in the form of 'd: \ CURSAS16_17 \ S02 \ girona_red'
It is preferable to work with bookstores.

/*1.2.2 How to access databases in SAS format from a BLOC PROC */

/* LIBNAME libref 'k: \ path'; */

PROC nomprocedimiento 
DATA = libref.nombre_bdd_existente [(opciones)]; 
/*COMANDOS DEL PROC*/
RUN;

*Example we use Girona.sas7bdat to list the first 10 observations;
proc print data = carpeta.girona (obs =10); 
run; 


/* 2 SAS DATA SETS OPTIONS - SAS DATA BATTERIES

These options have their equivalent in commands, but the options are much more flexible and
In addition, we can also use them in the PROCS, the commands can only be used
in the BLOCS DATA.

-ELIMINATE OR SELECT VARIABLES
 DROP = listvar -> the specified variable list is not included
 KEEP = listvar -> the file keep? the specified variable list

-SELECTION OF OBSERVATIONS -> WITHOUT CONDITION
 OBS = N1 -> READ THE N1 FIRST OBSERVATIONS
 FIRSTOBS = N2 -> READ FROM THE ROW N2 UNTIL THE END

-SELECTION OF OBSERVATIONS -> WITH CONDITION
 WHERE = (condition)
 Under the conditions you can use comparison operators
 <(LT) <= (LE) = (EQ)> (GT)> = (GE) ~ = (NE) i also ^ = (NE)
 Logics AND (&) OR (|) NOT (^ o ~)
 Arithmetic +, -, *, /, **

-RENOMBRATE VARIABLES
 RENAME = (name_ant = name_new)

-IN = var_temporal ->? Til in the uni? N of files

-Priority in the use of these options
  1 KEEP | DROP
  2 RENAME
  3 WHERE

All options except firstobs and obs can be used in both input and output files
of output and can also be used in PROCS

*/

/*EX1 

From the base CLASS.SAS7BDAT that we have in the SASHELP bookshop we are going to create a base
temporary EX1 only with cases that are men with more than 60 in the variable HEIGHT

The HEIGHT variable we want to be called HEIGHT in the new base and also in the base that we are going to
create only we want the variables NAME, HEIGHT = HEIGHT, and AGE*/ 

 data ex1 (drop = weight sex); 
 set sashelp.class (where = (sex ='M' and altura >60) rename = (height = altura)); 
 run; 

 proc contents data = ex1; run; 

* Proc contents

  Quickly and truthfully informs what is in the SAS bdd without the need to incorporate it into memory
  Number of observations
  Number of variables
  Name and types of variables, labels of variables and values, if any, and position
  they occupy the variables in the file;

* SAS BOOKSTORES. Types of SAS files

 TABLES -> SAS data sets. *. Sas7bdat
 CATALOGS -> (graphics, labels ...). *. Sas7bcat
  ...
  ;
/*EX2 

Create EX2-temporary only with the SEX variable changing the name to GENERO and a new one
variable with values ??x1 = 1 if it is male-male- 0 if female-female -; */

* VERSION 1 We rename in the input file - ALERT with the priorities

  KEEP | DROP Priority 1
  RENAME Priority 2
  WHERE Priority 3; 

 data ex2; 
 set sashelp.class (rename = (sex = genero)); 
 X1 = (genero= 'M'); /*SELECTION WITH THE VARIABLE ALREADY RENOWNED*/ 
 run; 
 

* VERSION 2 Rename in the output file - more so if you can;

data ex2 (rename = (sex = genero)); 
set sashelp.class ; 
X1 = (SEX= 'M'); 
run; 


*Obtain the distribution of frequencies of variable X1;; 

PROC FREQ DATA = EX2; 
TABLE X1; 
RUN; 

 
/*EX3 

From the base P1 that is created in the next block, create the temporary basis P2 only with the
total variable = x1 + x2 + x3; */
data p1; 
input(x1-x3)(1.); 
datalines; 
123 
111 
234 
101 
; 

data p2; set p1; 
total=x1+x2+x3; 
keep total; 
run;
 

/*EX4 

Create class0-temporary from SASHELP.CLASS CLASS0 must have the variables SEX, AGE
and HEIGHT changing the name to GENDER, AGE and HEIGHT and select only cases
corresponding to men */

data class0 (rename = (sex=genero age=edad height=altura));
set sashelp.class (where = (sex ='M'));  
run;

 
/*EX5 Crear class1 -temporal a partir de SASHELP.CLASS 

 CLASS1 must have the variables SEX, AGE and HEIGHT changing the name by GENDER, AGE and HEIGHT
but only the cases corresponding to a value of AGE = 12 */

data class1 (rename = (sex=genero age=edad height=altura));
set sashelp.class (where = (AGE=12));  
run;


/ *
II IMPORT / EXPORTATION FORMATS EXCEL, SPSS, ACCESS, SPSS ...

  2.1 IMPORTATION OF DATA IN OTHER FORMATS (EXCEL, SPSS ...)
  2.2 EXPORT OF SAS DATA TO OTHER FORMATS (EXCEL, SPSS ...)
* /

/* 2.1 IMPORT OF DATA IN OTHER FORMATS (EXCEL, SPSS ...)
  /* Import Wizard -> Type DIMPORT from the command box in the upper left
  Step 1
  Step 2
  Step 3
  Step 4
  or you could also do FILE / IMPORT DATA

/*EX6 

   Importing the information available in a sheet of an Excel file by creating a temporary basis
   Import the file information mond2.xls creating the temporary database mond2;
*/

PROC IMPORT OUT= WORK.mond2 
            DATAFILE= "C:\Users\ana.maria.perez.mari\Desktop\tema2\dades s02\mond2.xls" 
            DBMS=XLS REPLACE;
     GETNAMES=YES;
RUN;


*Ex7 The file VICTI.TXT is a file delimited by tabs. Import the information from victi.txt
     to the base d: \ CURSAS16_17 \ S02 \ dades s02 \ victi.SAS7BDAT;


PROC IMPORT OUT= e.victi 
            DATAFILE= "C:\Users\ana.maria.perez.mari\Desktop\tema2\dades s02\Victi.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;


/* 2.2 EXPORT OF SAS DATA TO OTHER FORMATS (EXCEL, SPSS ...) * /

 / * Export Wizard -> Type DEXPORT from the command box in the upper left
  Step 1
  Step 2
  Step 3
  Step 4
  or you can also make FILE / EXPORT DATA

*Ex8 (Ejercicio 3 pdf) 


