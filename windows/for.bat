for in BAT

Command line usage:

for /f %f in ('dir /b c:\') do echo %f

Batch file usage:

for /f %%f in ('dir /b c:\') do echo %%f

Update: if the directory contains files with space in the names, you need to change the delimiter the for /f command is using. for example, you can use the pipe char.

for /f "delims=|" %%f in ('dir /b c:\') do echo %%f

Update 2: (quick one year and a half after the original answer :-)) If the directory name itself has a space in the name, you can use the usebackq option on the for:

for /f "usebackq delims=|" %%f in (`dir /b "c:\program files"`) do echo %%f

And if you need to use output redirection or command piping, use the escape char (^):

for /f "usebackq delims=|" %%f in (`dir /b "c:\program files" ^| findstr /i microsoft`) do echo %%f


