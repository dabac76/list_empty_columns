DATA WORK.CLASS;
LENGTH
	Name	 $ 8
	Sex		 $ 1
	Age	       8
	Height	   8
	Weight 	   8
	nullcol1   8
	nullcol2 $ 1
	;
INFILE DATALINES4
    DLM=','
    MISSOVER
    DSD 
    ;
INPUT 
	Name	 : $CHAR8.
	Sex		 : $CHAR1.
	Age	     : BEST8.
	Height	 : BEST8.
	Weight 	 : BEST8.
	nullcol1 : BEST8.
	nullcol2 : $CHAR1.
	;
DATALINES4;
Alfred,M,14,69,112.5,,
Alice,F,13,56.5,84,,
Barbara,F,13,65.3,98,,
Carol,F,14,62.8,102.5,,
Henry,M,14,63.5,102.5,,
James,M,12,57.3,83,,
Jane,F,12,59.8,84.5,,
Janet,F,15,62.5,112.5,,
Jeffrey,M,13,62.5,84,,
John,M,12,59,99.5,,
Joyce,F,11,51.3,50.5,,
Judy,F,14,64.3,90,,
Louise,F,12,56.3,77,,
Mary,F,15,66.5,112,,
Philip,M,16,72,150,,
Robert,M,12,64.8,128,,
Ronald,M,15,67,133,,
Thomas,M,11,57.5,85,,
William,M,15,66.5,112,,
;;;;