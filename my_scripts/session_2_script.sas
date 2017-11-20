


*Define library from where we can read;
libname mylib 'C:\Users\fme\Downloads\tema 2';        /* This command creates reference to the library where our raw data resides*/

*We're going to create the new dataset "girona_red" from already exisiting dataset "girona.sas7bdat";

data mylib.girona_red;         /* This commands creates the base for target dataset girona_red (the one which we want to create) */
set mylib.girona (obs=20);     /* This command reads 20 observations from existing dataset in the library "mylib" */
run;

*Another possible way of doing is;

data C:\Users\fme\Downloads\tema 2\girona_red;         
set C:\Users\fme\Downloads\tema 2\girona (obs=20);     
run;

*Using the PROC for printing the first 10 observations of the data girona in mylib;

PROC print data= mylib.girona (obs=10);
run;


