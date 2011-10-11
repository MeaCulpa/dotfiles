@echo off
rem converts utf-8 text to gbk
iconv.exe -f gbk -t utf-8 %1
@echo on
