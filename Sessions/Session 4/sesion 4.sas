/*Sesi�n 4   PROC PRINT, PROC SORT Y PROC FORMAT*/


/*1 PROC PRINT
Con las variables y observaciones elegidas de una base de datos SAS
listar� a la ventana de resultados dicha informaci�n;

Sintaxis:
PROC PRINT <option(s)>; 
	ID variable(s); 
	SUM variable(s); 
	VAR variable(s); 

OPTIONS
DATA= [libref.]nomb_base_sas	
NOOBS	No se visualizar� el n�mero de la observaci�n.
L | LABEL	Se visualizan las etiquetas de las variables.
N	Informa del n�mero de observaciones listadas al final del output.
*/


/*2 PROC SORT 
Permite la ordenaci�n de los casos de una base de datos seg�n los valores de una o m�s variables. 
No hay salida de resultados a la ventana de OUTPUT.

Sintaxis:
PROC SORT <option(s)> ;
BY <DESCENDING> variable-1 <...<DESCENDING> variable-n>;


OPCTIONS del PROC SORT
DATA= [libref.]nombre_base_sas	Base a ordenar.
OUT= SAS-data-set	Nombre base donde se guardaran los valores ordenados 
(preferiblemente definirla como temporal).

NODUP|NODUPRECS	Elimina del archivo ya ordenado los caso id�nticos.

NODUPKEY Elimina del archivo ya ordenado los casos con valor coincidente en la/las variable/s clave/es. 

*/



*Ejemplo 1

Creamos la base W.Base1;

libname w 'd:\CURSAS16_17\S04\dades_S04\';

DATA W.Base1;
INPUT CODI $ X1 X2 X3;
DATALINES;
 R1 1 2  3
 R2 3 2  1
 R3 4 3  2
 R4 2 7  8
 R4 2 3  1
 R1 1 2  3
 R4 2 3  1
 R4 2 7  8
 R1 1 6  7
 R1 1 2  3
 R4 2 7  8
 R3 1 2  1
 R4 2 7  8
 R1 1 2  3
 R1 4 3  2
 ;

TITLE 'Ej1: Listado bdd original';
PROC PRINT DATA = w.Base1 ; RUN;

TITLE "Ej1: Listado bdd original id codi";
PROC PRINT DATA = W.Base1 ; id codi; RUN;


*Se ordenan los registros de la Base1 seg�n los valores de la variable CODI 
     y la base ordenada se guardan en una nueva bdd temporal B1_ORD
     el label a�ade una etiqueta al archivo explicando lo que contiene, tambi�n se pueden
     especificar etiquetas justo despues de DATA nombrearchivo (label='') y asigna la etiqueta 
     al archivo creado;

PROC SORT DATA = W.Base1 OUT = B1_ord (label ='fichero ordenado en funci�n de codi');
BY codi; 
RUN;

TITLE 'Ej1: Listado de la base ordenada';
PROC PRINT DATA = B1_ord n noobs ; 
RUN;

*Utilizaci�n opci�n NODUP, elimina del archivo ya ordenado los caso id�nticos;

PROC SORT DATA = W.Base1 OUT = B1_ord21a (label = 'Sin duplicados') NODUP ;
BY codi;
RUN;

TITLE "Ej1: NODUP Sin observaciones coincidentes";
PROC PRINT DATA = B1_ord21a n noobs; 
RUN;

*Utilizaci�n opci�n NODUPKEY;

/*PROC SORT con la opci�n NODUPKEY, elimina del archivo resultante los casos con valor 
coincidente en la/las variable/s clave/s*/

PROC SORT DATA = W.Base1 OUT = B1_ord23 nodupkey;
BY codi ; RUN;

TITLE 'Ej1: NODUPKEY Sin duplicados var clave';
PROC PRINT DATA = B1_ord23  n noobs; 
RUN;


/*Ejemplo 2 Ordenaci�n seg�n los valores de 2 variables (X1 i x2)*/

DATA w.BASE2;
INPUT x1-x4;
DATALINES;
1 3 2  3
1 1 2  1
3 4 3  2
2 2 3  1
2 1 8  3
4 2 2  3
3 1 3  1
2 2 3  8
RUN;

PROC SORT DATA = w.BASE2 OUT = B2_ORD; 
by x1 x2;
RUN;

TITLE 'Ej2: BASE 2 Original';
PROC PRINT DATA = w.BASE2; RUN;

TITLE 'Ej2: BASE 2 Ordenada por X1 y X2';
PROC PRINT DATA = B2_ORD; RUN;


/*Ejemplo 3 Ordenaci�n de menor a mayor variables car�cter */

DATA W.BASE3;
INPUT X1 $;
DATALINES;
banda
ZAMORANO
CA�ERIA
CANARIO
CAN�MO
ca�a
CA�A
RUN;

PROC SORT DATA = W.BASE3 OUT = B3_OR; 
BY X1;
RUN;

TITLE 'Ej3: Bdd original';
PROC PRINT DATA = W.BASE3; RUN;

TITLE 'Ej3: Bdd ordenada';
PROC PRINT DATA = B3_OR; RUN;

/*Ejemplo 4 Ordenaci�n decreciente seg�n los valores de X1 y ascendente seg�n los de X2*/

DATA W.BASE4;
INPUT X1 X2 X3;
DATALINES;
 1 8  3
 3 2  1
 4 3  2
 2 7  1
 1 5  3
 1 1  3
 2 4  1
 2 1  8
RUN;

PROC SORT DATA = W.BASE4 OUT = B4_ORD;
BY DESCENDING X1 X2; 
RUN;

TITLE 'Ej4: Bdd original';
PROC PRINT DATA = W.BASE4; RUN;

TITLE 'Ej4: Bdd ordenada';
PROC PRINT DATA = B4_ORD; RUN;

TITLE;


/*3 PROC FORMAT */

/* PROC FORMAT es un procedimiento que sirve para definir etiquetas de valores y/o definir agrupaciones
   Como consecuencia de utilizar PROC FORMAT se crear� un fichero con la definici�n de estas etiquetas y agrupaciones -> FORMATS.SAS7BCAT * /

*1 DEFINICI�N DE ETIQUETAS CON PROC FORMAT;

/*nombre de los formatos m�ximo 8 car�cteres y no pueden terminar en un n�mero*/

/*PROC FORMAT ;
  VALUE nom1f v1 = etiqueta  .... vk = etiqueta;
  VALUE nom2f v1-v2 = etiqueta  .... vj-vk = etiqueta;
  RUN*/

  /* Especificaciones de valores 

 valor1 = etiq  valor2 = etiq    1 = 'Afroamericano'  2 =  'Caucasiano'
 Valor1-valorn  	Un rango de valores, incluye Valor1 y Valorn  13-20 = 'Entre 13 y 20'  
 valor1, valar2, valork   Una llista de valores 1,5,7,8 = 0 
                 Una llista de valores y un rango 1,5,7,8, 9-15 = 'Nivel alto' 
 valor1<-valorn  Todos los valores del rango, excepto el valor1	13<-20 = 1 20<-40 = 2
 valor1-<valorn  Todos los valores del rango, excepto el valorn	13-<20 = 1 20-40 = 2

   Se pueden utilizar la palabras: low, high, other*/

/* Cuando utilizamos PROC FORMAT se crea un fichero de formatos FORMATS.SAS7BCAT
   Donde de crea este fichero? si no decimos nada, se crea en la libreria WORK, por tanto es temporal.

/* Como puedo guardar el fichero de FORMATS para no tener que volver a ejecutar cada vez las instrucciones? 
   Haci�ndolo permanente:

   LIBNAME alias 'ruta'; /*ruta --> carpeta donde queremos guardar el FORMATS.SAS7BCAT*/

   /*PROC FORMAT LIBRARY = alias;
   value    ....;
   value    ....;
   RUN; */

/*
   NOTA: Cuando queremos decirle a SAS que asigne un formato que tenemos definido en un cat�logo de formatos a una 
   determindada variable, SAS lo buscar� en la librer�a WORK o en la librer�a que tenga asignado el libname LIBRARY. 
   Si el formato en cuesti�n est� en otra librer�a que no es ni WORK ni LIBRARY se lo tenemos que indicar en 
   OPTIONS FMTSEARCH = nomlibreria.
*/

/* Cuando hacemos doble clic encima de este fichero FORMATS s�lo veremos los nombres de los formatos, 
   no c�mo se han definido*/

/* Para averiguar c�mo est�n definidas las etiquetas y/o agrupaciones es preciso utilizar la opci� FMTLIB ;

/*EJEMPLOS*/

proc format /*fmtlib page*/; /*crea cat�logo de formatos temporal, lo guarda en WORK*/
 value $gene 'm'='Mujer' 'h'='Hombre';
 value resp 0 = 'NO' 1 = 'SI';
 value age low -< 18 = 'menor de edad' 18-<45 = 'adulto menor de 45' 45-high = 'adulto con 45 o m�s';
run;

data ejemplo1; 
input x1 $ x2 $ x3 x4 x5 x6;
label x1 = 'Nombre' 
      x2 = 'G�nero' 
      x3 = 'Edad' 
      x4 = 'Peso'
      x5 = 'Altura'
      x6 = '�Seguro de salud?';
format x2 $gene. x6 resp. x3 age.;
cards; 
mar�a  m 16 60 168 1
pablo  h 18 70 175 0
manuel h 22 80 184 0
paula  m 46 58 156 1
;

proc freq data=ejemplo1; tables x2 x3 x6;
run;

/*salgo del programa y vuelvo a entrar*/

*Creo una carpeta para guardar de forma permanente los formatos;

libname library 'd:\CURSAS16_17\S04\dades_S04\formatos';

proc format library = library /*fmtlib page*/; /*crea cat�logo de formatos permanentes*/
 value $gene 'm'='Mujer' 'h'='Hombre';
 value resp 0 = 'NO' 1 = 'SI';
 value age low -< 18 = 'menor de edad' 18-<45 = 'adulto menor de 45' 45-high = 'adulto con 45 o m�s';
run;

data ejemplo2; 
input x1 $ x2 $ x3 x4 x5 x6;
label x1 = 'Nombre' 
      x2 = 'G�nero' 
      x3 = 'Edad' 
      x4 = 'Peso'
      x5 = 'Altura'
      x6 = '�Seguro de salud?';
format x2 $gene. x6 resp. x3 age.;
cards; 
mar�a  m 16 60 168 1
pablo  h 18 70 175 0
manuel h 22 80 184 0
paula  m 46 58 156 1
;

proc freq data=ejemplo2; tables x2 x3 x6;
run;


/*eliminamos el cat�logo de formatos*/

libname form 'd:\CURSAS16_17\S04\dades_S04\formatos';

proc format library = form /*fmtlib page*/; /*crea cat�logo de formatos permanentes*/
 value $gene 'm'='Mujer' 'h'='Hombre';
 value resp 0 = 'NO' 1 = 'SI';
 value age low -< 18 = 'menor de edad' 18-<45 = 'adulto menor de 45' 45-high = 'adulto con 45 o m�s';
run;

options fmtsearch = (form);

data ejemplo3; 
input x1 $ x2 $ x3 x4 x5 x6;
label x1 = 'Nombre' 
      x2 = 'G�nero' 
      x3 = 'Edad' 
      x4 = 'Peso'
      x5 = 'Altura'
      x6 = '�Seguro de salud?';
format x2 $gene. x6 resp. x3 age.;
cards; 
mar�a  m 16 60 168 1
pablo  h 18 70 175 0
manuel h 22 80 184 0
paula  m 46 58 156 1
;

proc freq data=ejemplo3; tables x2 x3 x6;
run;

/*Abrir un archivo que tiene formatos. Si queremos abrir una base de datos que fue creada asignando formatos definidos por el usuario, 
  necesitamos tener el cat�logo de formatos y decirle a SAS d�nde est�. Por ejemplo, creamos la base de datos permanente FORM.
  Ejemplo3 que tiene formatos definidos en el cat�logo FORMATS que hay en la carpeta FORM:*/

data form.ejemplo3; 
input x1 $ x2 $ x3 x4 x5 x6;
label x1 = 'Nombre' 
      x2 = 'G�nero' 
      x3 = 'Edad' 
      x4 = 'Peso'
      x5 = 'Altura'
      x6 = '�Seguro de salud?';
format x2 $gene. x6 resp. x3 age.;
cards; 
mar�a  m 16 60 168 1
pablo  h 18 70 175 0
manuel h 22 80 184 0
paula  m 46 58 156 1
;

/*ahora salgo del programa y vuelvo a entrar. Intento abrir FORM.EJEMPLO3 o imprimirlo con un proc print*/

libname form 'd:\CURSAS16_17\S04\dades_S04\formatos';

proc print data=form.ejemplo3; run; /*da error porque no encuentra la carpeta de formatos*/

/*para que la encuentre, tengo que hacer*/

options fmtsearch = (form);
proc print data=form.ejemplo3; run;

/*Tambi�n puedo decirle a SAS que abra la base de datos sin formatos, esto es �til cuando no tenemos el cat�logo de formatos y al menos queremos poder abrir y utilizar la base de datos original sin formatear, en ese caso hacemos:*/

options nofmterr;
proc print data=form.ejemplo3; run;
