/*Sesión 4   PROC PRINT, PROC SORT Y PROC FORMAT*/


/*1 PROC PRINT
Con las variables y observaciones elegidas de una base de datos SAS
listará a la ventana de resultados dicha información;

Sintaxis:
PROC PRINT <option(s)>; 
	ID variable(s); 
	SUM variable(s); 
	VAR variable(s); 

OPTIONS
DATA= [libref.]nomb_base_sas	
NOOBS	No se visualizará el número de la observación.
L | LABEL	Se visualizan las etiquetas de las variables.
N	Informa del número de observaciones listadas al final del output.
*/


/*2 PROC SORT 
Permite la ordenación de los casos de una base de datos según los valores de una o más variables. 
No hay salida de resultados a la ventana de OUTPUT.

Sintaxis:
PROC SORT <option(s)> ;
BY <DESCENDING> variable-1 <...<DESCENDING> variable-n>;


OPCTIONS del PROC SORT
DATA= [libref.]nombre_base_sas	Base a ordenar.
OUT= SAS-data-set	Nombre base donde se guardaran los valores ordenados 
(preferiblemente definirla como temporal).

NODUP|NODUPRECS	Elimina del archivo ya ordenado los caso idénticos.

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


*Se ordenan los registros de la Base1 según los valores de la variable CODI 
     y la base ordenada se guardan en una nueva bdd temporal B1_ORD
     el label añade una etiqueta al archivo explicando lo que contiene, también se pueden
     especificar etiquetas justo despues de DATA nombrearchivo (label='') y asigna la etiqueta 
     al archivo creado;

PROC SORT DATA = W.Base1 OUT = B1_ord (label ='fichero ordenado en función de codi');
BY codi; 
RUN;

TITLE 'Ej1: Listado de la base ordenada';
PROC PRINT DATA = B1_ord n noobs ; 
RUN;

*Utilización opción NODUP, elimina del archivo ya ordenado los caso idénticos;

PROC SORT DATA = W.Base1 OUT = B1_ord21a (label = 'Sin duplicados') NODUP ;
BY codi;
RUN;

TITLE "Ej1: NODUP Sin observaciones coincidentes";
PROC PRINT DATA = B1_ord21a n noobs; 
RUN;

*Utilización opción NODUPKEY;

/*PROC SORT con la opción NODUPKEY, elimina del archivo resultante los casos con valor 
coincidente en la/las variable/s clave/s*/

PROC SORT DATA = W.Base1 OUT = B1_ord23 nodupkey;
BY codi ; RUN;

TITLE 'Ej1: NODUPKEY Sin duplicados var clave';
PROC PRINT DATA = B1_ord23  n noobs; 
RUN;


/*Ejemplo 2 Ordenación según los valores de 2 variables (X1 i x2)*/

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


/*Ejemplo 3 Ordenación de menor a mayor variables carácter */

DATA W.BASE3;
INPUT X1 $;
DATALINES;
banda
ZAMORANO
CAÑERIA
CANARIO
CANÁMO
caña
CAÑA
RUN;

PROC SORT DATA = W.BASE3 OUT = B3_OR; 
BY X1;
RUN;

TITLE 'Ej3: Bdd original';
PROC PRINT DATA = W.BASE3; RUN;

TITLE 'Ej3: Bdd ordenada';
PROC PRINT DATA = B3_OR; RUN;

/*Ejemplo 4 Ordenación decreciente según los valores de X1 y ascendente según los de X2*/

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
   Como consecuencia de utilizar PROC FORMAT se creará un fichero con la definición de estas etiquetas y agrupaciones -> FORMATS.SAS7BCAT * /

*1 DEFINICIÓN DE ETIQUETAS CON PROC FORMAT;

/*nombre de los formatos máximo 8 carácteres y no pueden terminar en un número*/

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
   Haciéndolo permanente:

   LIBNAME alias 'ruta'; /*ruta --> carpeta donde queremos guardar el FORMATS.SAS7BCAT*/

   /*PROC FORMAT LIBRARY = alias;
   value    ....;
   value    ....;
   RUN; */

/*
   NOTA: Cuando queremos decirle a SAS que asigne un formato que tenemos definido en un catálogo de formatos a una 
   determindada variable, SAS lo buscará en la librería WORK o en la librería que tenga asignado el libname LIBRARY. 
   Si el formato en cuestión está en otra librería que no es ni WORK ni LIBRARY se lo tenemos que indicar en 
   OPTIONS FMTSEARCH = nomlibreria.
*/

/* Cuando hacemos doble clic encima de este fichero FORMATS sólo veremos los nombres de los formatos, 
   no cómo se han definido*/

/* Para averiguar cómo están definidas las etiquetas y/o agrupaciones es preciso utilizar la opció FMTLIB ;

/*EJEMPLOS*/

proc format /*fmtlib page*/; /*crea catálogo de formatos temporal, lo guarda en WORK*/
 value $gene 'm'='Mujer' 'h'='Hombre';
 value resp 0 = 'NO' 1 = 'SI';
 value age low -< 18 = 'menor de edad' 18-<45 = 'adulto menor de 45' 45-high = 'adulto con 45 o más';
run;

data ejemplo1; 
input x1 $ x2 $ x3 x4 x5 x6;
label x1 = 'Nombre' 
      x2 = 'Género' 
      x3 = 'Edad' 
      x4 = 'Peso'
      x5 = 'Altura'
      x6 = '¿Seguro de salud?';
format x2 $gene. x6 resp. x3 age.;
cards; 
maría  m 16 60 168 1
pablo  h 18 70 175 0
manuel h 22 80 184 0
paula  m 46 58 156 1
;

proc freq data=ejemplo1; tables x2 x3 x6;
run;

/*salgo del programa y vuelvo a entrar*/

*Creo una carpeta para guardar de forma permanente los formatos;

libname library 'd:\CURSAS16_17\S04\dades_S04\formatos';

proc format library = library /*fmtlib page*/; /*crea catálogo de formatos permanentes*/
 value $gene 'm'='Mujer' 'h'='Hombre';
 value resp 0 = 'NO' 1 = 'SI';
 value age low -< 18 = 'menor de edad' 18-<45 = 'adulto menor de 45' 45-high = 'adulto con 45 o más';
run;

data ejemplo2; 
input x1 $ x2 $ x3 x4 x5 x6;
label x1 = 'Nombre' 
      x2 = 'Género' 
      x3 = 'Edad' 
      x4 = 'Peso'
      x5 = 'Altura'
      x6 = '¿Seguro de salud?';
format x2 $gene. x6 resp. x3 age.;
cards; 
maría  m 16 60 168 1
pablo  h 18 70 175 0
manuel h 22 80 184 0
paula  m 46 58 156 1
;

proc freq data=ejemplo2; tables x2 x3 x6;
run;


/*eliminamos el catálogo de formatos*/

libname form 'd:\CURSAS16_17\S04\dades_S04\formatos';

proc format library = form /*fmtlib page*/; /*crea catálogo de formatos permanentes*/
 value $gene 'm'='Mujer' 'h'='Hombre';
 value resp 0 = 'NO' 1 = 'SI';
 value age low -< 18 = 'menor de edad' 18-<45 = 'adulto menor de 45' 45-high = 'adulto con 45 o más';
run;

options fmtsearch = (form);

data ejemplo3; 
input x1 $ x2 $ x3 x4 x5 x6;
label x1 = 'Nombre' 
      x2 = 'Género' 
      x3 = 'Edad' 
      x4 = 'Peso'
      x5 = 'Altura'
      x6 = '¿Seguro de salud?';
format x2 $gene. x6 resp. x3 age.;
cards; 
maría  m 16 60 168 1
pablo  h 18 70 175 0
manuel h 22 80 184 0
paula  m 46 58 156 1
;

proc freq data=ejemplo3; tables x2 x3 x6;
run;

/*Abrir un archivo que tiene formatos. Si queremos abrir una base de datos que fue creada asignando formatos definidos por el usuario, 
  necesitamos tener el catálogo de formatos y decirle a SAS dónde está. Por ejemplo, creamos la base de datos permanente FORM.
  Ejemplo3 que tiene formatos definidos en el catálogo FORMATS que hay en la carpeta FORM:*/

data form.ejemplo3; 
input x1 $ x2 $ x3 x4 x5 x6;
label x1 = 'Nombre' 
      x2 = 'Género' 
      x3 = 'Edad' 
      x4 = 'Peso'
      x5 = 'Altura'
      x6 = '¿Seguro de salud?';
format x2 $gene. x6 resp. x3 age.;
cards; 
maría  m 16 60 168 1
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

/*También puedo decirle a SAS que abra la base de datos sin formatos, esto es útil cuando no tenemos el catálogo de formatos y al menos queremos poder abrir y utilizar la base de datos original sin formatear, en ese caso hacemos:*/

options nofmterr;
proc print data=form.ejemplo3; run;
