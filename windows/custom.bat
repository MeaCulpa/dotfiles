@echo off
echo "海关文档专用"
net use /delete * /y
echo "海关文档专用..."
pause
net use \\137.168.99.111 haiguan /user:haiguan
start \\137.168.99.111\海关项目\
date /T >> \\137.168.99.111\海关项目\use.log
echo %COMPUTERNAME%  >> \\137.168.99.111\海关项目\use.log
echo "用完后按任意键，恢复其他文档使用"
pause
net use /delete * /y
net use \\137.168.99.111 1 /user:administrator
echo "恢复administrator访问权限按任意键退出..."
pause
start \\137.168.99.111\
