### Session 4: Statistical Procedures

An introductory lecture on the topic can be found here [Using **PROC SORT** and **BY** statement](https://stats.idre.ucla.edu/sas/modules/using-proc-sort-and-by-statements/)

* Sorting out the data using one specific variable
* Sorting out the data using one specific variable in desceding order of that variable
* Sorting out the data using more than one variable
* Using the **NODUPLICATES** option for removing duplicate values

**NOTE**: 
* Since a missing value is treated as the lowest value possible (e.g., negative infinity), the missing values come before all other values of a particular variable using which we're sorting.
* We can use **PROC SORT** to remove the duplicate observations from our data file using the **NODUPLICATES** option, as long as the **duplicate observations are next to each other**.

***What happens if all the duplicate values are not falling next to each other?***

You can sort the data file by all of the variables (which can be indicated with the special keyword **_ ALL_** ), which would force the duplicate observations to be next to each other.

