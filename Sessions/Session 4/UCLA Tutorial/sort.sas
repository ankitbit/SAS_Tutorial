* Using PROC SORT and BY statements  ;

* PROC PRINTTO LOG="sort.out" PRINT="sort.out" NEW ;
* RUN;

OPTIONS NODATE NOCENTER NONUMBER ;
TITLE ;


* 1. Introduction  ;

* This module will examine the use of "PROC SORT" and use of the "BY" ;
* statement with SAS Procedures. ;
* The program below creates a data file called "auto" that we will ;
* use in our examples.  Note that this file has a duplicate record ;
* for the BMW. ;

DATA auto ;
  INPUT make $  mpg rep78 weight foreign ;
CARDS ;
AMC     22 3 2930 0
AMC     17 3 3350 0
AMC     22 . 2640 0
Audi    17 5 2830 1
Audi    23 3 2070 1
BMW     25 4 2650 1
BMW     25 4 2650 1
Buick   20 3 3250 0
Buick   15 4 4080 0
Buick   18 3 3670 0
Buick   26 . 2230 0
Buick   20 3 3280 0
Buick   16 3 3880 0
Buick   19 3 3400 0
Cad.    14 3 4330 0
Cad.    14 2 3900 0
Cad.    21 3 4290 0
Chev.   29 3 2110 0
Chev.   16 4 3690 0
Chev.   22 3 3180 0
Chev.   22 2 3220 0
Chev.   24 2 2750 0
Chev.   19 3 3430 0
Datsun  23 4 2370 1
Datsun  35 5 2020 1
Datsun  24 4 2280 1
Datsun  21 4 2750 1
;
RUN ;

PROC PRINT DATA=auto ;
RUN ;

* The output from the program is shown below.  The PROC PRINT shows ;
* that the data file has been successfully created. ;


* 2. Sorting data with PROC SORT  ;

* We can use "PROC SORT" to sort this data file.  The program below ;
* sorts the "auto" data file on the variable "foreign" (1=foreign car, ;
* 0=domestic car) and saves the sorted file as "auto2". The original ;
* file remains unchanged since it is used strictly as the input and ;
* "auto2" is the file that contains the sorted data. ;

PROC SORT DATA=auto OUT=auto2 ;
  BY foreign ;
RUN ;

PROC PRINT DATA=auto2 ;
RUN ;

* From the "PROC PRINT" below, you can that "auto2" is indeed ;
* sorted on "foreign".  The observations where foreign is 0 precede ;
* all of the observations where foreign is 1. ;


* Suppose you wanted the data sorted, but with the ;
* foreign cars ("foreign"=1) first and the domestic cars ("foreign"=0) ;
* second.  The example below shows the use of the DESCENDING keyword ;
* to tell SAS that you want to sort by "foreign", but you want the sort ;
* order reversed (i.e. largest to smallest).  ;

PROC SORT DATA=auto OUT=auto3 ;
  BY DESCENDING foreign ;
RUN ;

PROC PRINT DATA=auto3 ;
RUN ;

* You can see in the "PROC PRINT" below that the data is now ordered ;
* by foreign, but highest to lowest. ;


* It is also possible to sort on more than one variable at a time. ;
* Perhaps you would like the data sorted on "foreign" (this time we ;
* will go back to the normal sort order for foreign) and then ;
* sorted by "rep78" within each level of foreign.  The example ;
* below shows how this can be done. ;

PROC SORT DATA=auto OUT=auto4 ;
  BY foreign rep78 ;
RUN ;

PROC PRINT DATA=auto4 ;
RUN ;

* You can see in the "PROC PRINT" below that the data is now ordered ;
* by foreign, domestic cars ("foreign"=0) followed by foreign ;
* ("foreign"=1) cars.  Within the domestic cars, the data is sorted ;
* by "rep78" and within foreign cars the data is also sorted by ;
* "rep78". ;


* In the output above, note how the missing values of "rep78" were ;
* treated.  Since a missing value is treated as the lowest value ;
* possible (e.g. negative infinity) the missing values come before ;
* all other values of "rep78". ;

* 3. Removing duplicates with PROC SORT  ;

* At the beginning of this page, we noted that there was a duplicate ;
* observation in "auto", that there were two identical records for ;
* BMW.  We can use "PROC SORT" to remove the duplicate observations ;
* from our data file using the "NODUPLICATES" option.  The example ;
* below sorts the data by "foreign" and removes the duplicates at ;
* the same time.  Note that it did not matter what variable we ;
* chose for sorting the data.  As long as we use the "NODUPLICATES" ;
* option, the duplicate observations are removed. ;

PROC SORT DATA=auto OUT=auto5 NODUPLICATES ;
  BY foreign ;
RUN ;

PROC PRINT DATA=auto5 ;
RUN;

* As you see in the output below, the extra observation for BMW was ;
* deleted.  ;


* When you use the "NODUPLICATES" option, the SAS LOG ;
* displays a note telling you how many duplicates were removed. ;
* As you see below, SAS informs us that 1 duplicate ;
* observation was deleted. ;

/*
150        PROC SORT DATA=auto OUT=auto5 NODUPLICATES ;
151          BY foreign ;
152        RUN ;

NOTE: 1 duplicate observations were deleted.
NOTE: The data set WORK.AUTO3 has 26 observations and 5 variables.
*/

* 4. Obtaining Separate Analyses with Sorted Data  ;

* Sometimes you would like to obtain results separately for ;
* different groups.  For example, you might want to get the ;
* mean "mpg" and "weight" separately for "foreign" and "domestic" ;
* cars.  As you see below, it is possible to use "PROC MEANS" ;
* with the "CLASS" statement to get these results. ;

PROC MEANS DATA=auto ;
  CLASS foreign ;
  VAR foreign weight ;
RUN ;

* However, what if you wanted to obtain the correlation of ;
* "weight" and "mpg" separately for foreign and domestic cars? ;
* "PROC CORR" does not support a "CLASS" statement like ;
* "PROC MEANS" does, but you can use the "BY" statement as ;
* in the example below. ;

PROC SORT DATA=auto OUT=auto6 ;
  BY foreign ;
RUN ;

PROC CORR DATA=auto6 ;
  BY foreign ;
  VAR weight mpg ;
RUN ;

* As you see in the output below, using the "BY" statement ;
* resulted in getting a "PROC CORR" for the domestic cars ;
* and a "PROC CORR" for the foreign cars. In general, using ;
* the "BY" statement requests that the "PROC" be performed for ;
* every level of the "BY" variable (in this case, for every ;
* level of "foreign"). ;


* Here are other examples of where you might use a "BY" ;
* statement with the "auto" data file. (Note that some ;
* of these analyses are not very practical because of the ;
* small size of the "auto" data file, so please imagine ;
* that we would be analyzing a larger version of the ;
* "auto" data file.) ;
* - You might use a "BY" statement with "PROC UNIVARIATE" ;
* to request univariate statistics for "mpg" separately ;
* for foreign and domestic cars because you would like ;
* to check to see that "mpg" is normally distributed ;
* for foreign cars and normally distributed for domestic ;
* cars. ;
* - You might use a "BY" statement with "PROC REG" ;
* you would like to do separate regression analyses ;
* for foreign and domestic cars. ;
* - You might use a "BY" statement with "PROC MEANS" ;
* even though it has the "class" statement.  If you ;
* wanted the means displayed on separate pages, then ;
* using the "BY" statement would give you the kind ;
* of output you desire. ;

* 5. Problems to look out for...  ;

* 6. For more information...  ;

* 7. Web Notes  ;
