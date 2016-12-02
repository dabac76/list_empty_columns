/*   - output log list (out=loglist), 
     - output source dataset without empty cols (out=dsref), 
     - output table with the list of empty cols (out=);
*/

%MACRO list_empty_cols(dsn=,out=);

%if &out= %then 
    data work.%scan(&dsn,-1,.)_nullcols (keep=colname)%str(;);
%else 
    %str(data _null_;);


    if 0 then set &dsn nobs=_nobs_;
    array allnvars[*] _numeric_;   
    array allcvars[*] _character_;   
    length nvar_found_ind 3 cvar_found_ind 3 col_cnt 3 list_cnt 3 num_nvar 3 num_cvar 3 all_var 3 colname $32;
   
    col_cnt   = 1;
    list_cnt  = 1;
    num_nvar  = dim(allnvars);
    num_cvar  = dim(allcvars);
    put 'Total NUM ' num_nvar;
    put 'Total CHR ' num_cvar;
    all_var   = max(num_nvar, num_cvar) + 1;
        /* Outer loop : iterate through all columns of table */
        do until( col_cnt eq all_var );           
            /* value found indicator initially set to FALSE  */
            nvar_found_ind = 0;
            cvar_found_ind = 0;
            /* Inner loop : iterate thorugh all rows of each column */            
            do j = 1 to _nobs_;
                set &dsn point=j;
                /* Value found indicators = 1 (TRUE) is a signal that column is NOT completely empty */                               
                if (col_cnt le num_nvar) & not(nvar_found_ind) then
                  if not(missing(allnvars[col_cnt])) then nvar_found_ind = 1;
                if (col_cnt le num_cvar) & not(cvar_found_ind) then
                  if not(missing(allcvars[col_cnt])) then cvar_found_ind = 1;
                /* If at least one non-missing element is intercepted in both columns leave inner loop */
                if nvar_found_ind & cvar_found_ind then leave;
            end;
            /* Output names of completely empty columns */
            if j > _nobs_ & (col_cnt le num_nvar) & not(nvar_found_ind) then do;
                colname = vname(allnvars[col_cnt]);
                %if &out=loglist %then 
                    %str(put 'NUM ' colname;); 
                %else %if &out=  %then  
                    %str(output;);
                %else %do;
                    call symput('colname'||strip(put(list_cnt,6.)), strip(colname));
                    call symput('list_cnt', strip(put(list_cnt,6.)));
                %end;
                list_cnt+1;
            end;
            if j > _nobs_ & (col_cnt le num_cvar) & not(cvar_found_ind) then do;
                colname = vname(allcvars[col_cnt]);
                %if &out=loglist %then 
                    %str(put 'CHR ' colname;); 
                %else %if &out=  %then  
                    %str(output;);
                %else %do;
                    call symput('colname'||strip(put(list_cnt,6.)), strip(colname));
                    call symput('list_cnt', strip(put(list_cnt,6.)));
                %end;
                list_cnt+1;
            end;
            /* Increment column counter (array iterator) */
            col_cnt+1;
        end;
    stop;
run;

%if &out.^= & &out^=loglist %then %do;
    data &out;
    set  &dsn (drop=%do cnt=1 %to &list_cnt; &&colname&cnt %str( ) %end;);
    run;    
%end;

%MEND check_empty_cols;
