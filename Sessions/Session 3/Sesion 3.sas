/* SESIÓN 3 */

*LECTURA DATOS EN FICHEROS DE TEXTO, PLANOS O ASCII;

/*COMANDO INPUT
 1 INPUT nv1 nv2 .... nvk $ .....;
 2 INPUT nv1 p1-p2    nvk $ pk-pk2  ....; pi -->num col donde se encuentra el valor a leer
 3 INPUT   @p1 V1 informat1w.  .........@pk Vk informatkw.;
   Este tipo de imput es obligatorio si tenéis información no estándar 
   (información estándar: son variables numéricas -separador decimal como  . y cadenas)
   Información no estándar: fechas, $123, 123,152,527  ...
 4 INPUT como un mix de todo lo anterior*/

*1 INPUT LIST o lectura en formato libre
  Los datos son de tipo estándar, 
  Si hay variables texto deben ser cortas (máx. 8 cars)
  No existen datos missing representados por espacios en blanco
  Los valores de las variables deben estar separados entre sí por uno o más blancos;

*Estructura BLOC DATA para leer desde archivo;

DATA EX_INPUT1;
   INFILE   'w:\ruta\nom_archivo.ext' opcions; /*opciones de infile*/
     INPUT V1 V2 V3$;
RUN;

*Estructura BLOC DATA para leer desde el propio editor;

DATA EX_INPUT1;
     INPUT V1 V2 V3$;
	 *más comandos;
	 datalines;
	 1 3 h 
	 5 6 d
	 4 8 d
;


*EJ 1 Crearemos la base d:\CURSAS16_17\S03\dades_s03\bas1.sas7bdat que tendrá 
2 variables: X1(nombre) y X2 (numérica);

libname s3 "d:\CURSAS16_17\S03\dades_s03\";

DATA s3.bas1;
input x1 $ x2;
DATALINES;
PEDRO    1
ELENA    0
MARIO    1
JOAN     1
;

*EJ 2. Ejercicio a) del documento Ejercicios_S3.pdf
  El archivo d:\CURSAS16_17\S03\dades_s03\ATURATS.DAT contiene datos trimestrales relativos 
  al número de parados en las 18 CCAA y el total de España (segunda variable), 
  desde el tercer trimestre de 1976 hasta el segundo trimestre de 1995.
  Crear la base d:\CURSAS16_17\S03\dades_s03\ATUR_T.SAS7BDAT con toda la información 
  del archivo ATURATS.DAT;


data s3.atur_t;
infile 'd:\CURSAS16_17\S03\dades_s03\ATURATS.DAT';
input ca $ total x1-x18;
run;


/* 2 COLUMN INPUT O FORMATO FIJO 

INPUT var1 p11-p1j var2 p21-p2j vark pk1-pkj;

Donde:

VARK Simboliza el nombre de la variable k-ésima
PK1 --> número columna en la que debe situarse el puntero de lectura para iniciar 
        la lectura del valor de la VARK
PKj --> número columna en la que debe situarse el puntero de lectura para finalizar 
        la lectura del valor de la VARK
IMPORTANTE --> Los datos a leer deben estar debidamente alineados en columnas.

Características de los datos para poder utilizar COLUMN INPUT. 

a. La información debe ser lo que SAS llama de tipo estándar:
    números sin ningún carácter especial salvo el punto como separador de decimales
    cadena o alfanumérica
b. Los valores de las variables no están necesariamente separados por espacios en blanco.
c  Las variables pueden presentar valores missing representados por espacios en blanco
d. Podemos leer sólo la información relativa a algunas variables.
e. Las variables cadena pueden tener una longitud superior a 8 caracteres y/o blancos en su interior.


*EJ 3 Crearemos la base  d:\CURSAS16_17\S03\dades_s03\EX3.SAS7BDAT
	con 3 variables edad, peso, genero (carácter) utilizando Column input;

/* Los datos son:
23 87.70 H
28 54    D
21       D
32 59    H
54 62    D
*/

data s3.ex3;
input edad peso 4-8 genero $;
datalines;
23 87.70 H
28 54    D
21       D
32 59    H
54 62    D
;


/*EJ 4 Examinar el archivo de datos d:\CURSAS16_17\S03\dades_s03\ALCADES.DAT (altura a principio y a final de año). 
 Escribir un programa para leer los datos y guardarlos temporalmente en alt.sas7bdat, 
 hacer una descriptiva inicial de las variables , 
 y crear variable altura promedio y describirla*/

  DATA alt;
   infile 'd:\CURSAS16_17\S03\dades_s03\alcades.dat';;
   input alti altf;
   /*corregimos a posteriori porque en el primer análisis con PROC MEANS vemos que hay valores de alti fuera de rango
   Los pasamos a missing de sistema*/
   if alti<=0 then alti=.;
   altm=(alti+altf)/2; /*altura promedio*/
run;

PROC MEANS DATA = ALT; RUN;

*EJ 5  
a) Crear la bdd D:\CURSAS16_17\S03\dades_s03\EX4.SAS7BDAT a partir del fichero D:\CURSAS16_17\S03\dades_s03\NOTES.TXT 
   pero sólo con las variables NOMBRE, NOTA1 Y NOTA2
b)Crear la variable NOTAF como promedio de las dos notas;

DATA s3.ex4;
infile 'd:\CURSAS16_17\S03\dades_s03\notes.txt';
input nombre $ nota1 13-15 nota2 17-19;
notaf=(nota1+nota2)/2;
run;

proc print data = s3.ex4; run;

*EJ 6  
a) Crear la BDD D:\CURSAS16_17\S03\dades_s03\EX5.SAS7BDATa partir del fichero D:\CURSAS16_17\S03\dades_s03\NOTES_M.TXT 
   con las variables NOMBRE, SEXO, EDAD, NOTA1 Y NOTA2
b) Crear la variable NOTAF como promedio de las dos notas;

DATA s3.EX5;
infile 'd:\CURSAS16_17\S03\dades_s03\notes_m.txt';
INPUT nombre $ sexo $ edad nota1 13-15 nota2 17-19;
notaf_m=(nota1+nota2)/2;
/*el operador + si hay missin no suma, pone missing*/
notaf_b=sum(of nota1 nota2)/2;
run;

proc print data = s3.ex5; run;


/* 3 INPUT con PUNTERO DE COLUMNAS
INPUT   @p1 V1 informat1w.  .........@pk Vk informatkw.;

Donde:

@pj es un número que indica al programa a qué columna se tiene que dirigir el puntero 
    para leer la información con un formato de lectura que viene dado por el informatjw.
Informats  son formatos de lectura predefinidos por SAS
formats  son formatos de escritura predefinidos por SAS 

Esta especificación de input será obligatoria cuando tengamos información NO ESTANDAR
como variables numéricas con coma como separador de decimales, fechas, etc...

12AGO2013 informat date9.
120813 informat ddmmyy6.
12-08-13 informat ddmmyy8.
12/08/13 informat ddmmyy8.
12/08/2013 informat ddmmyy10.*/

*EJ 7;

DATA ALUMNES_B;
INPUT nom $ 1-22 edat curs $ @33 data_i ddmmyy8./*informat de la fecha*/; 
FORMAT data_i ddmmyy10.; /*aspecto de la fecha a la salida*/ 
DATALINES;
Rodríguez Alvaro, José  23   A  15/10/96
Carbó Durró, Maria      20   B  07/09/97
Santos Abella, Jaume    21   B  11/09/95
;
RUN;

PROC PRINT DATA = ALUMNES_B;
RUN;

*EJ 8 Punter1: aqui el puntero estricto no sirve porque los datos no están totalmente encolumnados, en esos casos
hay que utilizar los : delante del nombre del informat, de ese modo le indicamos a SAS dos cosas:

a) cuando hayas terminado de leer la varaible anterior, debes ir al próximo carácter NO BLANCO que encuentres y
b) lee lo que encuentres con el formato que indicamos y dejas de "rastrear" cuando encuentres un carácter en blanco;

/*Además, tener en cuenta la siguiente instrucción cuando trabajemos con datos fecha*/

/*options yearcutoff=year;*/ 

/*OPTIONS YEARCUTOFF = YEAR especifica el primer año de la ventana de 100 años que toma como referencia para 
asignar fechas en las que el año se indica con dos digitos
Por omision, options yearcutoff=1920, de manera que asigna años entre 1920-2019*/

DATA EJ8; 
*INPUT Nom $ Cog $ @14 ddn ddmmyy8. @24 ddi ddmmyy6. sex $; /*no funciona porque no están encolumnados*/
INPUT Nom $ Cog $ ddn :ddmmyy8. ddi :ddmmyy6. sex $;
format ddn ddi ddmmyy10.;
DATALINES;
BACH  JORDI   13/10/05  110711  H
CASES EVA    01/09/50  070801  D
TORT  JOSEP   07/01/44  230899  H
SALA  JOAN    24/11/83  090906  H
;

PROC PRINT DATA = EJ8;
RUN;

*EJ 9;
*Leemos las variables fecha del estatuto columnas 3 a 10 
y Nombre de la Comunidad Autónoma a partir de la columna 26;

DATA ccaa_estat;
INPUT   X1 :ddmmyy.   @26 x2 :$11.;
LABEL X1 = Data estatut X2 = Comunitat;
*http://support.sas.com/documentation/cdl/en/nlsref/63072/HTML/default/viewer.htm#p0tdu5chzbp58cn18p9ehzrdxg7t.htm;
FORMAT X1 eurdfwdx24.;
DATALINES;
  19-03-07   Sevilla     Andalucia 28 de febrero (Día de Andalucía)
  18-04-07   Zaragoza    Aragón    23 de abril (Día de Aragón)
  20-07-06   Barcelona   Catalunya 11 de septiembre (Diada)
  26-02-83   Mérida      Extremadura 8 de septiembre (Día de Extremadura)
;
PROC PRINT DATA = ccaa_estat; RUN;

/*options dflang="Spanish"; con esta instrucción la fecha aparecería en español*/
/*options dflang="catalan"; amb aquesta instrucció la data apareixeria en català*/