rem remove rar archives
G:\GetGnuWin32\gnuwin32\bin\find -type f -name "*.rar" | xargs -n 1 rm -rf
rem count the files we have
G:\GetGnuWin32\gnuwin32\bin\find.exe -type f -name "*.txt" | wc -l
rem remove personal creditl files
G:\GetGnuWin32\gnuwin32\bin\find.exe -type f -name "*.txt" | grep "/cridtl" | xargs rm
rem remove personal creditl files
G:\GetGnuWin32\gnuwin32\bin\find.exe -type f -name "*.txt" | grep "/exedtl" | xargs rm
rem generate file list to cat
echo @echo off > catter.bat
G:\GetGnuWin32\gnuwin32\bin\find.exe -type f -name "*.txt" | sed "s/\(.*\)/cat &/g" >> catter.bat
echo @echo on >> catter.bat
rem merge lines
call catter.bat > merged.txt
rem remove blank lines
cat merged.txt | sed "/^$/d" > result.txt
rem split into J03 and J04 files
echo RECORD_TYPE^|FIRM_CODE_TYPE^|FIRM_CODE^|NAME^|FIRM_REPRESENTATIVE^|FIRM_ADDRESS^|EXEC_CASE_ID^|EXEC_COURT_ID^|EXEC_GIST^|EXEC_MONEY^|EXEC_OTHERS^|EXEC_CASE_DATE^|CASE_EXEC_STATUS^|INFO_RECORD_STATUS^|INFO_PROVIDE_DATE^| > 05_01_%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.txt
cat result.txt | egrep "^J03.*" >> 05_01_%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.txt
echo RECORD_TYPE^|FIRM_CODE_TYPE^|FIRM_CODE^|NAME^|FIRM_REPRESENTATIVE^|FIRM_ADDRESS^|EFFECT_CASE_ID^|JUDGED_COURT_ID^|JUDGED_NAME^|JUDGED_MONEY^|JUDGED_TYPE_TERM^|JUDGED_TIME^|INFO_RECORD_STATUS^|INFO_PROVIDE_DATE^| > 05_02_%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.txt
cat result.txt | egrep "^J04.*" >> 05_02_%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.txt
rem log last processed folder
echo %DATE% | sed "s/^\([0-9]*\)-\([0-9]*\)-\([0-9]\).*/\1\2\3/g" > lastprocessed
G:\GetGnuWin32\gnuwin32\bin\find.exe -maxdepth 1 -type d | tail -1 >> lastprocessed
