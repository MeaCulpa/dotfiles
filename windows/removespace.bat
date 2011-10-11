@echo off
dir /b /a-d *.* > temp.txt
for /F "tokens=*" %%* in (temp.txt) do call :sub %%*
del temp.txt
goto :eof

:sub
echo ren "%*" %1%2%3%4%5%6%7%8%9