@echo off
start polipo.exe -c config
:start
plink.exe <Server IP> -N -ssh -2 -P <Server SSH Port> -l <Username> -C -D 7070 -v -pw <Password>
goto start
