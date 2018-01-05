/* SESIÓN 9 CREACION DE VARIABLES*/

libname W 'D:\CURSAS16_17\sesion 9\dades_s09';

OPTIONS FMTSEARCH=(W);

DATA MEGAZ;
SET W.MEGAZ;
  vsum1=v1+v2+v3+v4+v5+v6;
  vsum2=sum(of v1 -- v6);
  varit=exp(abs(v1-v2)); /*cualquier operacion que queramos*/
  vmean=mean(of v1 -- v6); /*media*/
  vstd=std(of v1 -- v6); /*dev estandar*/
  vvar=var(of v1 -- v6); /*varianza*/
  vmean_i=int(vmean); /*devuelve la parte entera*/
  vmiss=nmiss(of v1 -- v6); /*cuenta el numero de missings*/
RUN;

/*TRANSFORMACION CONDICIONAL DE VARIABLES*/

data megaz;
set megaz;
if (gender=1 & age < 35) then var1 = 1; 
run;

data megaz;
set megaz;
if (gender=1 & age < 35) then var2 = 1;
else var2=2;
run;

proc freq data = megaz; tables var1*var2 / missing; run;

data megaz;
set megaz;
if (gender=1 & age < 35) then var3 = 1;
if (gender=1 & age >= 35) then var3 = 2;
if (gender=2) then var3 = 3;
run;

data megaz;
set megaz;
if (gender=1 & age < 35) then var4 = 1;
else if (gender=1 & age >= 35) then var4 = 2;
else var4 = 3;
run;

data megaz;
set megaz;
var5 = (gender=1 & age < 35)*1 + (gender=1 & age >= 35)*2 + (gender = 2)*3;
run;

proc freq data = megaz; tables var3*var4*var5; run;

/*creación de más de una variable con un mismo bloque if*/

data megaz;
set megaz;
if (gender=1 & age < 35) then do;
    var6 = 1; 
    var7=sum(of v1 -- v6);
    var8=mean(of v1 -- v6);
    var9=std(of v1 -- v6);
end;
run;


/*SELECCION DE OBSERVACIONES*/

data megaz2;
set megaz;
if (gender=1 & age < 35);
run;


/*CREACION DE VARIABLES A TRAVES DE ARRAYS*/

DATA MEGAZ (DROP = COUNT);
SET MEGAZ;
ARRAY VAL(6) V1 - V6;
ARRAY XX(6) X1 - X6;
DO COUNT = 1 TO 6;
   IF (VAL(COUNT)>=5) THEN XX(COUNT)=1;
   ELSE IF (VAL(COUNT)>=0) THEN XX(COUNT)=0;
   ELSE XX(COUNT)=.;
END;
RUN;

proc print data=megaz; var v1-v6 x1-x6;
run;


/*ARRAYS CON DIMENSION VARIABLE*/


data mis1;
input x1 x2 x3 x4 $;
cards;
1 -99 2 -99
-99 3 -99 06
0 -99 2 -99
;
run;

data mis2 /*(drop = i)*/;
set mis1;
 /*todas las numericas de mi base
    tiene los miss como -99*/
ARRAY X(*) _numeric_; /* * el contará por nosotros*/
   DO i = 1 TO dim(x);
   IF X(i) = -99 THEN X(i) =.;
END;
run;

proc print; run;

data mis3;
input x1 x2 x3 x4 $ x5 $;
cards;
1 -99 2 p 07
-99 3 -99 06 p
0 -99 2 p p
;
run;

data mis4 /*(drop = i)*/;
set mis3;
 /*busca solo en las cadena */
ARRAY X(*) _character_; /* las buscará por nosotros*/
   DO i = 1 TO dim(x);
   IF X(i) = "p" THEN X(i) =' ';
  END;
run;

proc print; run;

data mis5;
input x1 x2 x3 x4;
cards;
1 -99 2 -99
-99 3 -99 6
0 -99 2 -99
;
run;

data mis6 /*(drop = i)*/;
set mis5;
/*todas son numericas*/
ARRAY X(*) _all_; /* * el contará por nosotros*/
   DO i = 1 TO dim(x);
   IF X(i) = -99 THEN X(i) =.;
  END;
run;

proc print; run;


/*DEFINICION DE VALORES MISSING DE USUARIO*/

DATA EJEM1;
INPUT X1 X2 X3;
DATALINES;
1 2 99999
3 4 7
5 1 99999
2 3 8
2 . 7
3 4 3
3 7 7
; 
RUN;

PROC MEANS DATA=EJEM1; RUN;

DATA EJEM1; SET EJEM1; IF X3=99999 THEN X3=.; /*EL VALOR A SERÁ MISSING DE SISTEMA, PUNTO*/
RUN;

PROC MEANS DATA=EJEM1; RUN;

DATA EJEM1;
INPUT X1 X2 X3;
DATALINES;
1 2 99999
3 4 7
5 1 99999
2 3 8
2 . 7
3 4 3
3 7 7
; 
RUN;

DATA EJEM1; SET EJEM1; IF X3=99999 THEN X3=.A; /*EL VALOR A SERÁ MISSING DE USUARIO, VALOR A*/
RUN;

PROC MEANS DATA=EJEM1; RUN;

/*DEFINIR EL MISSING DE USUARIO DENTRO DEL BLOQUE DATA*/

DATA EJEM1;
INPUT X1 X2 X3;
DATALINES;
1 2 .A
3 4 7
5 1 .A
2 3 8
2 . 7
3 4 3
3 7 7
; 
RUN;

PROC MEANS DATA=EJEM1; RUN;

DATA EJEM1;
INPUT X1 X2 X3;
missing A;
DATALINES;
1 2 A
3 4 7
5 1 A
2 3 8
2 . 7
3 4 3
3 7 7
; 
RUN;

PROC MEANS DATA=EJEM1; RUN;

/*GENERACION DE BASES DE DATOS POR SIMULACION*/

/*podéis hacerlo con las funciones RANnnn(seed), las más utilizadas son:

  RANBIN(SEED,N,P)
  RANEXP(SEED)
   ranexp(seed)/lambda
  RANGAM(SEED,ALPHA)
   x=beta*rangam(seed,alpha);
  RANNOR(SEED)
   x=MU+sqrt(S2)*rannor(seed);
  RANPOI(SEED,M)
  RANUNI(SEED)

    */

DATA u1 (drop = i);
  do i = 1 to 100;
    x=rannor(635985);
    output;
  end;
run;

proc print data= u1;
run;

/*también puede hacerse con una rutina CALL, las más utilizadas

  CALL RANBIN(SEED,N,P,X)
  CALL RANEXP(SEED,X)
  CALL RANGAM(SEED,ALPHA,X)
  CALL RANNOR(SEED,X)
  CALL RANPOI(SEED,M,X)
  CALL RANUNI(SEED,X)

*/

data u2(keep = x);
   seed = 898647;
   do i = 1 to 100;
	  call ranuni(seed, x); 
      output;
   end;
run;

proc print data= u2;
run;

/*FUNCIONES FECHA*/

DATA MEGAZ;
SET MEGAZ;
DIA=CEIL(28*RANUNI(346895));
MES=CEIL(12*RANUNI(859647));
ANY=2013;
DATAE=MDY(MES,DIA,ANY);
FORMAT DATAE DDMMYY10.;
RUN;

proc print; var dia mes any datae; run;

/*CREA AHORA UNA VARIABLE LLAMADA SS1 QUE VALGA 1 SI LA ENTREVISTA SE HIZO EN FEBRERO Y 0 EN CASO CONTRARIO, 
UTILIZANDO UNICAMENTE LA VARIABLE DATAE*/

DATA MEGAZ;
SET MEGAZ;
IF MONTH(DATAE)=2 THEN SS1=1;
ELSE SS1=0;
RUN;

proc print; var dia mes any datae ss1; run;

/*FUNCIONES CADENA:

CAT(CHAR1,CHAR2,..): CONCATENA
LOWCASE(CHAR): PASA A MINÚSCULAS
UPCASE(CHAR): PARA A MAYÚSCULAS
SUBSTR(CHAR,START,LENGTH): EXTRAE UNA CADENA
*/

DATA EJEM2;
INPUT ID $ PROV $;
DATALINES;
12457856 bcn
98653255 gir
78569595 tar
45659811 lle
98685735 bcn
78784585 tar
65962684 tar
98659912 gir
; 
RUN;

DATA EJEM2;
SET EJEM2;
CODI1=cat(ID,PROV);
CODI2=cat(ID,UPCASE(PROV));
CODI3=SUBSTR(ID,3,2);
RUN;

proc print; run;



/* CONVERSIÓN DE VARIABLES CADENA A NUMÉRICAS O FECHA, Y VICEVERSA */

data char;
input string $8. date $6. numer fecha ddmmyy8.; /* variable carácter  -  variable fecha  -  variable numerica */
 numeric=input(string,8.); /* Convertir carácter a numérica */ 
 numeric2=string+0;        /* Convertir carácter a numérica: si sólo contiene números la carácter pasa a numérica mediante cualquier operación aritmética  */
  chara=put(numer,5.2);     /* Convertir numérica a carácter  */
 sasdate=input(date,mmddyy6.);  /* Convertir carácter a fecha */
 fechcar=put(fecha,ddmmyy8.);  /* Convertir carácter a fecha */
 format sasdate ddmmyy10. chara $5. fecha ddmmyy8.; 
datalines;
1234.56 031704 121.2 12/11/15
3920    123104 132.2 20/11/25
;

proc contents varnum;
run;

proc print; 
run; 
