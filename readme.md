### Synopsis

This script scans a data set for columns that contain only missing values. It can either output a copy of a calling data set without them, list them in a log file (and their type) or make a new data set with a list of those column names.  

For some reason, other solutions for this problem I was able to find on the web were not as simple as this one.

### Instructions

Script has two calling arguments and can be called in three ways:

```
%list_empty_cols(dsn=SAS-data-set, out=<|loglist|SAS-data-set>)
```
- Omitting value of second argument creates a new data set (named like calling data set just suffixed with `_nullcols`) with a list of found column names.
- If `loglist` value is specified then output is directed to log. Found column names along with their type are printed.
- If you specify new data set name then a copy of a calling set is created which does not contain columns found to be completely empty.

### Tests

First run `demo_data.sas` to create a testing data set, then compile `list_empty_cols.sas` and then run test script `demo_test.sas`. 