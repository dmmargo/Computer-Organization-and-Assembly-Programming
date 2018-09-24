Diane Margo
CS265
7/23/18

Problem 1:

Given arrays to input, the pogram takes the arrays and loads it into the memory. Two arrays are printed 
and looped. It creates a new array. The function (|Yi| + |Zi| + 2*S + T) define the values and then 
printed to the console. 
Part B to this problem is the same as part A except with a different set of values. 

#Problem 1(A) output:________________________________________
Print Y Vector values:
1 2 3 4 5 
Print Z Vector values:
-5 -4 -3 -2 -1 
Print X Vector values:
11 11 11 11 11 

##############################################################
Memory and registers cleared

SPIM Version 9.1.19 of July 25, 2017
Copyright 1990-2017 by James Larus.
All Rights Reserved.
SPIM is distributed under a BSD license.
See the file README for a full copyright notice.
QtSPIM is linked to the Qt library, which is distributed under the GNU Lesser General Public License version 3 and version 2.1.



#Problem 1(B) output:________________________________________
Print Y Vector values:
-1 3 -5 7 -9 2 -4 6 -8 10 
Print Z Vector values:
1 2 3 4 5 6 7 8 9 10 
Print X Vector values:
10 13 16 19 22 16 19 22 25 28 

##############################################################
Memory and registers cleared

SPIM Version 9.1.19 of July 25, 2017
Copyright 1990-2017 by James Larus.
All Rights Reserved.
SPIM is distributed under a BSD license.
See the file README for a full copyright notice.
QtSPIM is linked to the Qt library, which is distributed under the GNU Lesser General Public License version 3 and version 2.1.






Problem 2:

Given the array of {5, 2, -9, 10, -23, 43, 2, 1, 3, 5, and 10},
problem2.asm tries to find the min using stack and a recursive function 'Min' on itself 
to locate the smallest value and print the smallest element in arrayA. The output will be 
stored in the register. After finding the smallest value, a 'high' variable must be set 
where the highest value is equal to$a3. 

#output_____________________________________________________

Problem 2:

find the smallest value in array through func 'Min'...

Output: -23

##############################################################
Memory and registers cleared

SPIM Version 9.1.19 of July 25, 2017
Copyright 1990-2017 by James Larus.
All Rights Reserved.
SPIM is distributed under a BSD license.
See the file README for a full copyright notice.
QtSPIM is linked to the Qt library, which is distributed under the GNU Lesser General Public License version 3 and version 2.1.