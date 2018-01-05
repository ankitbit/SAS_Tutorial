
LIBNAME LIB "/folders/myfolders/Session 10/dades_s10";

PROC PRINT DATA=LIB.STOCKS; RUN;

/* SCATTERPLOT */
PROC SGPLOT DATA=SASHELP.CLASS; SCATTER X=WEIGHT Y=HEIGHT; RUN;

PROC SGPLOT DATA=SASHELP.CLASS; 
SCATTER X=WEIGHT Y=HEIGHT/ MARKERATTRS=(SYMBOL= TRIANGLEFILLED SIZE=2MM COLOR=RED); 
RUN;

PROC SGPLOT DATA=SASHELP.CLASS; 
SCATTER X=WEIGHT Y=HEIGHT/ MARKERATTRS=(SYMBOL= CIRCLEFILLED SIZE=2MM COLOR=TOMATO); 
RUN;

PROC SGPLOT DATA=SASHELP.CLASS; 
SCATTER X=WEIGHT Y=HEIGHT/ MARKERATTRS=(SYMBOL= SQUARE SIZE=2MM COLOR=BLUE); 
RUN;
/* UISNG DATALABEL */
PROC SGPLOT DATA=SASHELP.CLASS; 
SCATTER X=WEIGHT Y=HEIGHT/ MARKERATTRS=(SYMBOL= CIRCLEFILLED SIZE=2MM COLOR=TOMATO) 
DATALABEL= WEIGHT; /* IF VARIABLE NOT SPECIFIED THEN VALUES OF Y VARIABLE ARE USED */
RUN;



/* CREATING A SERIES PLOT */
PROC SGPLOT DATA=LIB.STOCKS;
SERIES X=YEAR Y=STOCK1;
TITLE1 "STOCK1 PER YEAR - SERIES PLOT";
RUN;
/* USING MARKERS */
PROC SGPLOT DATA=LIB.STOCKS;
SERIES X=YEAR Y=STOCK1/MARKERS;
TITLE1 "STOCK1 PER YEAR - SERIES PLOT";
RUN;
/* IF THE PLOT REQUIRES TWO TITLES SIMULTANEOUSLY THEN READ THE FOLLOWING */
PROC SGPLOT DATA=LIB.STOCKS;
SERIES X=YEAR Y=STOCK1/MARKERS;
TITLE1 "STOCK1 PER YEAR - SERIES PLOT";
TITLE2 "PLOT 1";
RUN;

PROC SGPLOT DATA=LIB.STOCKS;
SERIES X=YEAR Y=STOCK1/MARKERS 
MARKERATTRS=(SYMBOL= CIRCLEFILLED SIZE=2MM COLOR=TOMATO)
CURVELABEL;
TITLE1 "STOCK1 PER YEAR - SERIES PLOT";
TITLE2 "PLOT 1";
RUN;

/* MULTIPLE SERIES PLOTS TOGETHER */
PROC SGPLOT DATA=LIB.STOCKS;
SERIES X=YEAR Y=STOCK1/MARKERS 
MARKERATTRS=(SYMBOL= CIRCLEFILLED SIZE=2MM COLOR=TOMATO)
CURVELABEL;
TITLE1 "STOCK1 PER YEAR - SERIES PLOT";
TITLE2 "PLOT 1";
SERIES X=YEAR Y=STOCK2/ MARKERS 
MARKERATTRS=(SYMBOL= CIRCLEFILLED SIZE=2MM COLOR=DARKGREEN)
CURVELABEL;
RUN;

