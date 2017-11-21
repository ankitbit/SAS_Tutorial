

/*PROC SORT
It allows the ordering of the cases of a database according to the values of one or more variables.
There is no output of results to the OUTPUT window.
Syntax:
PROC SORT <option (s)>;
BY <DESCENDING> variable-1 <... <DESCENDING> variable-n>;
OPTIONS of PROC SORT
DATA = [libref.] Base_name base to sort.
OUT = SAS-data-set Base name where the ordered values will be stored
(preferably define it as temporary).
NODUP | NODUPRECS Deletes the identical cases from the file already ordered.
NODUPKEY Deletes from the file already ordered the cases with matching value in the / s key / s variable.
*/
