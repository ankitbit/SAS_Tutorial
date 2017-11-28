
LIBNAME lib 'C:\Users\fme\Downloads\SAS\Tema3\dades_s03';
DATA lib.EBNOR lib.EBRES;
SET lib.ebpf;

PROC PRINT DATA=lib.EBNOR;
RUN;

libname e 'C:\Users\fme\Downloads\SAS\Tema3\dades_s03';
data e.ebnor (where = (codi='N')) e.ebres (where = (codi^='N'));
set e.ebpf;
run;

PROC PRINT DATA=e.ebpf; RUN;
PROC PRINT DATA=e.ebnor; RUN;

DATA example;
INFILE 'C:\Users\fme\Downloads\SAS\Tema3\dades_s03\ebpf.sas7bdat'
INPUT (X1-X6)$;
RUN;
PROC PRINT DATA=e.example; RUN;

var X1 today();
RUN;
