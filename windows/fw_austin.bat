@echo off
@rem telnet 9.3.118.1
D:\gnuwin32\bin\echo.exe -e "xujinyu@cn.ibm.com\n" | d:\nc\nc.exe -i 1 -vvn 9.3.118.1 23
@rem gecho -e "xujinyu@cn.ibm.com\nINTRANETPWD\n" | nc -i 1 -vvn 9.3.118.1 23
@echo on
