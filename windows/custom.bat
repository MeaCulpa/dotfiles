@echo off
echo "�����ĵ�ר��"
net use /delete * /y
echo "�����ĵ�ר��..."
pause
net use \\137.168.99.111 haiguan /user:haiguan
start \\137.168.99.111\������Ŀ\
date /T >> \\137.168.99.111\������Ŀ\use.log
echo %COMPUTERNAME%  >> \\137.168.99.111\������Ŀ\use.log
echo "�������������ָ������ĵ�ʹ��"
pause
net use /delete * /y
net use \\137.168.99.111 1 /user:administrator
echo "�ָ�administrator����Ȩ�ް�������˳�..."
pause
start \\137.168.99.111\
