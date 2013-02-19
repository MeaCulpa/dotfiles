::------------------------------------------------------------------------------
:: Generate passcode using md5, again and again
:: Usage: pissword.bat PrivatePhrase Count
:: Thoughts: I think for loop can do what cut does here
@echo off
set path=%path%;d:\gnuwin32\bin
set word=%1
set cnt=%2
:loop
FOR /f "usebackq delims=" %%i in (`gecho.exe -n %word% ^| md5sum ^| cut -c 1-8`) do @set word=%%i
set /a cnt=%cnt%-1
if not %cnt% == 0 goto loop
echo %word%
@echo on
