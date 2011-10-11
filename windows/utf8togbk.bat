@echo off
rem converts gbk text to utf-8
iconv.exe -f utf-8 -t gbk %1
@echo on
