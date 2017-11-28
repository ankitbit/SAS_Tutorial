
libname mm 'C:\Users\fme\Downloads\SAS\session 4\dades_s04';
ods listing;
proc contents data=mm.medi;
run;
ods listing close;

PROC CONTENTS DATA=mm.medi;
RUN;

/* Printing the MEDI */
PROC PRINT DATA=mm.medi;
RUN;

*b;

ods rtf;
proc print data=mm.medi noobs label; 
var num_pac data med chol;
run;
ods rtf close;

ods pdf;
proc print data=mm.medi noobs; 
var num_pac data med chol;
run;
ods pdf close;


*a;

ods listing;
proc sort data=mm.bas11 out=bas11ord; by z; run;

proc print data=bas11ord; run;

*b;

proc sort data=mm.bas11 out=bas11ord2; by z descending x; run;

proc print data=bas11ord2 noobs; run;

*c;

proc print data=bas11ord noobs; 
var x;
by z;
sum x;
run;

libname w 'C:\Users\fme\Downloads\SAS\session 4\dades_s04';
libname w3 'C:\Users\fme\Downloads\SAS\session 4\dades_s04';

proc format library = w3;
value opi 
1 = 'Muy buena'
2 = 'Buena'
3 = 'Regular'
4 = 'Mala'
5 = 'Muy mala'
6-high ='NS/NC';
value gene 1='Hombre' 2= 'Mujer';
value estadc 1='Viudo/a' 2='Separado/Div' 3 ='Casado/a' 4='Soltero';
run;
/* Data without formatting */
data w3.enqasseg2;
set w.enqasseg;
*format x5-x7 opi. x3 gene. x4 estadc.;
*label A?ADIR VOSOTROS LAS ETIQ VARIABLE;
run;

PROC PRINT DATA=w3.enqasseg2; RUN;


options fmtsearch=(w3);

/* PRINTING the DATA with FORMATTING*/
data w3.enqasseg2;
set w.enqasseg;
format x5-x7 opi. x3 gene. x4 estadc.;
*label A?ADIR VOSOTROS LAS ETIQ VARIABLE;
run;



proc freq data=w3.enqasseg2;
tables x5 x6 x7;
run;

proc contents data=w.bas08; run;

proc format library = w;
value SN 
1 = 'SI'
2 = 'NO';
run;

/*es posible que aqui os d? error si el archivo FORMATS.SAS7BCAT est? protegido contra escritura. En tal caso, 
poniendo el rat?n encima del archivo FORMATS.SAS7BCAT y clicanco el bot?n derecho, id a propiedades y desactivar
la opci?n de solo lectura.*/

options fmtsearch=(w);

PROC PRINT DATA=w.bas08;
RUN;

proc freq data=w.bas08; tables v3-v5; run;

PROC MEANS DATA=w.bas08; VAR V3-V5;
RUN;

libname w6 'C:\Users\fme\Downloads\SAS\session 4\dades_s04';
PROC PRINT DATA=w6.pol; RUN;


PROC FORMAT LIBRARY=w6;
value $gene "h"="Home" "d"="Dona";
value x 1="SI" 2="NO";
value $gender "d"="FEMALE" "h"="MALE";
value y 1="YES" 2="NO";
RUN; 

options fmtsearch=(w6);
PROC PRINT DATA=w.pol; format x1 $gene. x4 x.;
RUN; 

PROC PRINT DATA=w.pol; format x1 $y. x4 z.;
RUN;

proc format library=w6;
value $gene 'd'='Dona' 'h'='Home';
value respc 1 = 'SI' 2 = 'NO';
value $gender 'd'='Female' 'h'='Male';
value respa 1 = 'Yes' 2 = 'No';
run;

options fmtsearch=(w6);

proc print data=w.pol; format x1 $gene. x4 respc.;
var x1 x4;
run;

proc print data=w.pol; format x1 $gender. x4 y.;
*var x1 x4;
run;
