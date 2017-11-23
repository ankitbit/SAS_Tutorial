/*SesiÛn 6 FusiÛn de archivos*/

*1 UniÛn de archivos en vertical: aÒadimos observaciones;

    /*Cuando tenemos dos o m·s archivos con las mismas variables pero diferentes observaciones, 
	para hacer la uniÛn de estos archivos, es necesario utilizar el comando SET */

/*
SINTAXIS;

LIBNAME libref 'ruta';

DATA libref.UV (DataSet options);
SET b1 (DSoptions) b2 (DSoptions) ÅEbK (DSoptions);
RUN;

Como DSoptons es especialmente ˙til utilizar:

IN=nomvar        que nos permitirÅEcrear una variabie identificadora de la procencia de la observaciÛn;

*/

/*EJEMPLO 1 UNION BY ADDING COMMENTS*/

data b1;
input x1 x2 x3 $;
datalines;
1 11 a
2 21 b
4 41 c
6 61 d
;

data b2;
input x1 x2 x3 $;
datalines;
3 16 t
5 28 f
7 49 s
8 64 p
;

data b1_2;
set b1 (in=origen) b2;
varb1=origen;
run;

proc print data = b1; 
proc print data = b2; 
proc print data = b1_2; run;


/*2 File union in parallel: add variables

When we have two or more files with different variables but the same individuals
to get a uniÛn file that contains all the variables of these files,
it is necessary to use the MERGE command followed by the list of files involved in the uniÛn.

We will indicate a common variable that identifies the individual to ensure that the union is done well.
The name of that varible is put behind the BY. The bases
of data to be merged must be ordered by that variable com ˙n. * /
*SINTAXIS;

/*
LIBNAME libref 'ruta';

PROC CONTENTS DATA = libref.B1; RUN;
PROC CONTENTS DATA = libref.B2; RUN;	

/*Useful to know if the databases that intervene in the union are unordered*/

/*
PROC SORT DATA = libref.B1 OUT = b1; BY variable_comuna; RUN;
PROC SORT DATA = libref.B2 OUT = b2; BY variable_comuna; RUN;

DATA libref.UH (DSopcions);
MERGE b1 (DSopcions) b2 (DSopcions);
BY  variable comun;
RUN;
*/
 
/*NOTAS:

/*ATENCI”N:

1 The use of the BY command assumes that the records of the databases
??that intervene in the union are ordered according to the values ??of the variable / s
??specified from this command, before performing the uniÛn.

??The PROC CONTENTS provides information about whether the databases that
??intervene in the uniÛn est o unordered

2 The variable / s com ˙n / is used to perform this type of uniÛn must
??have the same name, be of the same type and width.

3 For the rest of the variables, it must be taken into account that if some
??they are common in the specified input files behind MERGE,
??and the values ??are not necessarily coincident:
??the values ??that will be written ·n for these variables in the output file
??-the specified behind the DATA -ser ·n the ones that will be found in the archivoth entry file.

4 On the other hand you have to take into account that if in the input files
there are variables with the same name and different width,
the width of the variable to be written ÅE in the uniÛn file
will be determined by the width of the first variable
you find when you execute the MERGE command.
????This can always have unintended consequences
but especially when dealing with alphanumeric variables */

*EJEMPLO 2 UniÛn by addition of variables;

data b1;
input x1 x2 x3 $;
label x1 = 'Identicador del individuo'; 
datalines;
1 11 a
2 21 b
4 41 c
6 61 d
;

data b3;
input x1 x4;
label x1 = 'Identicador del individuo'; 
datalines;
1 200
4 256
6 300
;

data b1_3;
merge b1 b3;
by x1; /*I do not order the original bases for x1 because they are already*/
run;

proc print data = b1; id x1; 
proc print data = b3; id x1;
proc print data = b1_3; id x1; run;

*EJEMPLO3  The same variable in the two files with different names;

DATA treb;
INPUT Nom $13. edat;
DATALINES;
Elena          23
Joan           21
Santiago       19
Jorge Enrique  25
;

DATA salaris;
INPUT treballador $13. salar;
DATALINES;
Santiago       900
Jorge Enrique  1250
Elena          2300
Maria Teresa   1690
Vanessa        1200
;

proc sort data = treb;
by nom;
run;

proc sort data = salaris (rename = (treballador=nom));
by nom;
run;

data empresa;
merge treb salaris;
by nom;
run;

proc print data=treb; id nom; 
proc print data=salaris; id nom;
proc print data=empresa; id nom; run;


*Exclusion / selection of observations

By default the MERGE command combines all the observations of the input files
If we want to select the observations that are coincident in all or some
of the input files then you have to use the database option
IN = var_auxiliar and some combination of IF commands.
The option IN = var_auxiliar, can be used in both a vertical and horizontal uniÛn.
This option creates a temporary variable that indicates whether the corresponding file
intervenes or not in the creation of each case of the output file;

*EJEMPLO 4 Yes, the common individuals;

Data empresa2;
 merge treb (in=v1) salaris (in=v2);
 if (v1=v2);
 by nom;
run;

proc print data=empresa2; id nom; run;

/*
Exercise 1. UNION OF ARCHIVES (I)
The file D: \ CURSAS16_17 \ S06 \ dades_s06 \ ASSEG_JOVES.SAS7BDAT contains a series of variables about young policyholders (under 30 years old) of health insurance of a certain company. In the same way, the file D: \ CURSAS16_17 \ S06 \ dades_s06 \ ASSEG_SENIOR.SAS7BDAT contains information on senior policyholders (over 50 years old) of health insurance from the same company. It is requested:
a) Merge the files into a single one with name D: \ CURSAS16_17 \ S06 \ Exercises \ ASSEG_TOT.SAS7BDAT creating a new variable that indicates the origin of the observation.
b) Sort the database D: \ CURSAS16_17 \ S06 \ Exercises \ ASSEG_TOT.SAS7BDAT by the policy number.
c) Calculate the average age of the total insured using PROC MEANS.
Save the syntax as Ej1_S06.SAS.
*/

/*
Exercise 2. UNION OF ARCHIVES (II)
The file D: \ CURSAS16_17 \ S06 \ dades_s06 \ ASSEG_SENIOR2.SAS7BDAT contains information about the total cost of visits to the health services of the senior insured from file D: \ CURSAS16_17 \ S06 \ dades_s06 \ ASSEG_SENIOR.SAS7BDAT. It is requested:
a) Merge the files ASSEG_SENIOR.SAS7BDAT and ASSEG_SENIOR2.SAS7BDAT creating the file D: \ CURSAS16_17 \ S06 \ Exercises \ ASSEG_SENIORT.SAS7BDAT.
b) Create the database D: \ CURSAS16_17 \ S06 \ Exercises \ ASSEG_SENCOST.SAS7BDAT only with the insured who have made a medical visit (Nvisitas) and including only the variables policy number (Npol) and average cost of the visits made for those patients.
c) Make a list of the contents of the file ASSEG_SENCOST.SAS7BDAT.
Save the syntax as Ej2_S06.SAS
*/
