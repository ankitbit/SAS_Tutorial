*0 comentarios en SAS; 

/* bla bla bla bla 
 bla bla bla bla 
 bla bla bla bla */ 

*bla bla bla bla bla bla; 

*1 Ventanas principales: editor (script), log (avisos, errores, notas y copia de la sintaxis 
ejecutada) y ventana de resultados y la del Explorer (Work); 

/*

2.1 Normas de sintaxis en SAS 

No diferencia entre may�sculas ni min�sculas y la �nica condici�n es que todos los comandos acaben con ;
 
/*
2.2 Ejecuci�n de instrucciones 

Todo o parte del script. Tecla F8 o icono Running man 

Para ejecutar solo una l�nea o conjunto de l�neas, hay que marcar el bloque con el rat�n y despu�s 
ejecutar sea con F8 o con el icono de ejecuci�n. */

/*

3. Ejemplo de un programa en SAS 

La mayor�a de comandos en SAS se agrupan en dos bloques 

BLOC DATA --> Contiene todos los comandos relacionados con gesti�n de datos 

BLOC PROC --> Comandos de an�lisis estad�stico, listados, reports ... 

y unos pocos comandos que son "independientes" como las opciones de gr�ficos, opciones de salida de resultados ; 

Ejemplo 1 de un programa en SAS 

Definiremos una base de datos con nombre ex1 
Leeremos los datos de 4 variables introducidos en el propio editor con nombres year sex pes y alt 
Definiremos age = 2016-year 
Etiquetaremos alguna variable 
Listaremos a la ventana de resultados los valores de la base de datos 

Haremos: 
 Un an�lisis de frecuencias univariante de sex 
 Un an�lisis descriptivo de alt, peso y edad 
 Un an�lisis descriptivo de alt, peso y edad pero seg�n el sexo de la persona; 

*/

DATA ex1; /*Crear� la base de datos que le pedimos y ser� temporal*/ 

/*Comando INPUT permite definir los nombres de variables, de que tipo son y tambi�n indica a SAS 
como debe leer los datos para asignarlos a las variables*/ 

INPUT YEAR SEX $ ALT PES; 

/*SAS considera que todas las variables son n�meros o caracteres 

INPUT nomvar $ --> el valor es car�cter*/ 

/*Los nombres de las variables en SAS deben empezar siempre por una letra: a-z -may�sculas o min�sculas-, 
(ni � ni �) o bien con el car�cter de guion bajo _ y en su interior 
podemos tener n�meros, letras o _. Los nombres de variables, y en general cualquier nombre en SAS (de 
fichero, de variable, de formato....) no puede tener blancos en su interior. 

Longitud max de nombre (muy largo)*/ 

AGE = 2016-YEAR; /*NUEVAS VARS*/ 

LABEL YEAR = 'A�o nacimiento' age = 'Edad' alt = 'Altura'; 

/*datalines o cards*/ 

/*Los valores missing de las num�ricas SAS los reconoce por el . 
 Los valores missing de las variables tipo car�cter son un blanco 
 El separador decimal es el .*/ 

datalines; 
1989 h 1.74 87 
1991 d 1.67 58 
1992 h 1.74 67 
1988 d .    89 
1987 d 1.74 75 
; 

DATA ex1; 
INPUT YEAR SEX $ ALT PES; 
AGE = 2016-YEAR; 
LABEL YEAR = 'A�o nacimiento' age = 'Edad' alt = 'Altura'; 
datalines; 
1989 h 1.74 87 
1991 d 1.67 58 
1992 h 1.74 67 
1988 d .    89 
1987 d 1.74 75 
;

/*Mensaje del Log si todo ha salido bien: 

The data set WORK.EX1 has 5 observations and 5 variables 

El data set que se obtiene, lo pod�is visualizar en el �rea de trabajo temporal --> LIBRARY WORK*/ 

/*La ejecuci�n de un bloc data no dar� ninguna salida al output pero si al LOG 

Los mensajes de ERROR que suponen una interrupci�n en la ejecuci�n del programa los marca en color 
ROJO 

Los avisos WARNING de que algo no le gusta los marca en color VERDE. Un WARNING en el Log puede ser 
grave o no. En cualquier caso siempre hay que leer el mensaje con atenci�n y decidir nosotros la 
gravedad del aviso 

Los comentarios a las ejecuciones en forma de NOTE lo se�ala en AZUL. Aunque es deseable que en 
nuestro log solo aparezcan NOTES, hay que ir con cuidado porque a veces tambi�n nos pueden indicar que 
la ejecuci�n no ha ido como esper�bamos*/ 

/*Es conveniente ir borrando el contenido de la ventana LOG despu�s de las ejecuciones porque en caso 
de error en la ejecuci�n, cuando hay demasiad informaci�n en el LOG puede resultar dif�cil saber d�nde 
tenemos el error o aviso (CTRL+E)*/ 

/*Puede pasarnos que se nos cierren algunas ventanas, incluida la del explorador. 

Cualquier ventana cerrada se puede volver a abrir desde la opci�n de men� View--> nombre ventana. En 
el caso del explorador, para recuperar el aspecto habitual de la ventana la secuencia ser�: 

1 Opci�n de men� View--> Explorer 

Aparece el explorador en forma de doble panel 

Para restaurar el aspecto �normal�, habr� que seguir la secuencia: Opci�n de men� Windows Docked (o Acoplar)*/

/*Guardar el programa. Desde la ventana del editor Opci�n de men� File - Save as --> ruta y nombre. 

La extensi�n de los scripts en SAS es .sas y son ficheros textos que se pueden editar con cualquier 
editor de texto.*/ 
 
*Seguimos con el ejemplo de un programa en SAS 

a) listar a la ventana de resultados los valores de la bdd que hemos creado (PROC print) 
b) un an�lisis de frecuencias univariante de la variable sex 
c) un an�lisis descriptivo de las variables alt, peso y edad 
d) un an�lisis descriptivo de alt, peso y edad pero seg�n sexo de la persona. 


Los Procs en SAS siempre tienen el mismo aspecto; 

/*
PROC nomproc opciones; 
comandos ....; 
RUN; 
*/

*a); 

PROC PRINT data = ex1; 
RUN; 

/*

El formato de salida de los resultados se puede controlar desde sintaxis mediante el comando ODS 
(Output Delivery System). Posibles formatos de salida de resultados son: 

 listing
 html 
 pdf 
 rtf 
 ... 

*/ 
 
ODS HTML CLOSE; /*cierra la salida al formato Html, si este es el formato confirgurado en el ordenador*/ 
ODS LISTING; /*Abre la salida de resultados a la ventana output �en formato plano o texto*/ 

PROC PRINT data = ex1; 
RUN; 

ODS LISTING CLOSE; /*cerramos la salida de resultados a la ventana OUTPUT. En este momento no habr�a 
ninguna salida activa*/ 
 
ODS HTML; /*volvemos a abrir una salida para los resultados en formato html*/ 

/*Podemos mejorar algunos aspectos de la salida re resultados a�adiendo t�tulos*/ 

TITLE 'Primer ejemplo con SAS'; 

PROC PRINT data = ex1 label; /*label imprime la etiqueta en lugar del nombre de variable*/ 
ID year; 
RUN; 

TITLE; /*Anula cualquier definici�n de t�tulo*/ 

/*Tambi�n se pueden a�adir notas a pie de p�gina con Footnote*/ 

Footnote 'sasdasd'; 
 

*b) An�lisis de frecuencias univariante de sex; 

PROC FREQ DATA = ex1; 
table sex; 
 *table v1 v3 v4 v1*v3; /*otras posibles especificaciones que veremos m�s adelante*/ 
RUN; 

*c) An�lisis descriptivo de alt, peso y edad con dos decimales; 
    /*maxdec = n controla el n�mero de decimales que queremos visualizar*/

*c1 har� el descriptivo de todas la num�ricas; 

PROC MEANS DATA = ex1 maxdec = 2; RUN; 

*c2 har� el descriptivo solo de age y alt; 

PROC MEANS DATA = ex1 maxdec = 2; 
var age alt; 
RUN; 

*d) An�lisis descriptivo de alt, pes pero seg�n el sexo de la persona; 
 
/*Printalltypes nos da tambi�n el resultado del an�lisis global, sino utilizamos esta opci�n, s�lo se 
obtiene el an�lisis por subgrupos*/ 

PROC MEANS DATA = ex1 maxdec = 2 printalltypes; 
var alt pes; 
class sex; /*detr�s del comando especificamos la variable/s que define/n los grupos*/ 
RUN; 

footnote; /*elimina los footnotes*/

*Ejemplo 2 Creamos una base de datos permanente en d:\CURSAS16_17\S01\ex01.sas7bdat; 

*Crearemos una carpeta que ser� d:\CURSAS\S01;
 
options noxwait; /*evita tener que teclear exit despu�s de ejecutar el siguiente comando*/ 
x 'md e:\CURSAS16_17\S01'; /*Salida a sistema operativo y crear la estructura de carpetas especificada. Los nombres 
de las carpetas que especifiquemos no pueden contener blancos en su interior*/ 
 
DATA 'e:\CURSAS16_17\S01\ex01'; 
INPUT YEAR SEX $ ALT PES; 
AGE = 2016-YEAR; /*NUEVAS VARS*/ 
LABEL YEAR = 'A�o nacimiento' age = 'Edad' alt = 'Altura'; /*Asignamos etiquetas a algunas variables*/ 
datalines; 
1989 h 1.74 87 
1991 d 1.67 58 
1992 h 1.74 67 
1988 d .    89 
1987 d 1.74 75 
; 

/*Otra manera m�s c�moda de hacer una base de datos permanente es con la definci�n de un libmane*/

libname s1 'e:\CURSAS16_17\S01\';

DATA s1.ex01; 
INPUT YEAR SEX $ ALT PES; 
AGE = 2016-YEAR; /*NUEVAS VARS*/ 
LABEL YEAR = 'A�o nacimiento' age = 'Edad' alt = 'Altura'; /*Asignamos etiquetas a algunas variables*/ 
datalines; 
1989 h 1.74 87 
1991 d 1.67 58 
1992 h 1.74 67 
1988 d .    89 
1987 d 1.74 75 
;
 

*/Cuando desde el explorador de Windows hacemos doble clic sobre un SAS data set se abre Enterprise 
Guide (otro entorno de trabajo de SAS).

4 Ayuda con SAS --> SAS online Help 

El propio programa SAS incorpora HELP, para acceder la ayuda simplemente hay que teclear el icono de 
ayuda. De las carpetas que se abren en la ayuda de SAS, de momento nos pueden interesar el apartado:

Ayuda y documentaci�n SAS
Introducci�n al sortware SAS 

SAS se vende y se instala en m�dulos separados, entre otros: 

BASE (Estad�stica B�sica y Avanzada), 
STAT (Estad�stica m�s avanzada) 
OR (Operational Research) 
ETS (Series Temporales) 
QC (Control de calidad) 
GRAPH (Gr�ficos) 
SAS IML (Lenguaje matricial)*/


