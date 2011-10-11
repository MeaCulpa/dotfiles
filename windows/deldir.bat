rem G:\GetGnuWin32\gnuwin32\bin\find -type f -name "*.svn" | sed "s/\.\//rm -rf /g" > todel.bat
rem call todel.bat
G:\GetGnuWin32\gnuwin32\bin\find -type d -name "*.svn" | xargs -n 1 rm -rf