@echo off
rem remove carriage return and converts gbk text to utf-8
rem dunno how to add a carriage return by tr. have to use
rem more powerful tools like sed awk so fell out of scope
cat %1 | tr -d "\r" | iconv -f gbk -t utf-8
@echo on
