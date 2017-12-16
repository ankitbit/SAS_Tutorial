## Statistical Procedures
The objective of this session will be to develop a sound understanding of the following SAS PROCEDURES

* **PROC MEANS**
* **PROC FREQ**
* **PROC UNIVARIATE**
```
/* PROC UNIVARIATE
*/
LIBNAME W '/folders/myfolders/Session 8/dades_s08';
OPTIONS FMTSEARCH=(W);
/* Understanding the dataset */
PROC PRINT DATA=W.megaz; RUN;
PROC CONTENTS DATA=W.megaz; RUN;

```
/* Applying UNIVARIATE procedure on the variable "Age" */
PROC UNIVARIATE DATA=W.megaz; VAR Age; RUN;
/*PLOT option is used for plotting a stem-and-leaf plot (or a horizontal bar chart) for 
  the variable under consideration. In our case, we have the variable "Age".
  Apart from histogram,Produces a "box plot", and a "normal quantile plot" in line printer output.
*/
```
PROC UNIVARIATE DATA=W.megaz PLOT; VAR Age; RUN;
```
/* NORMAL option is used for performing a sequence of Normality tests for examining the normality
   of a varibale. These tests are based on goodness of fit measures 
   and empirical distribution fucntion
*/
```
PROC UNIVARIATE DATA=W.megaz NORMAL; VAR Age; 
RUN;
```
/* Calling a HISTOGRAM explicity */
```
PROC UNIVARIATE DATA=W.megaz; VAR Age; HISTOGRAM; 
RUN;
```
/* The similar procedure applies if we wish to conduct analysis for many variables at the 
   same time. In such a case, we can specify the sequence of variables under the VAR options
   */
```
PROC UNIVARIATE DATA=W.megaz; VAR Age Income; RUN;

PROC UNIVARIATE DATA=W.megaz CIBASIC alpha=0.05; VAR Age; RUN;
```



* **PROC TABULATE**

```
Hello
```

jjh
