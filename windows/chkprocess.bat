
WMIC /OUTPUT:C:\ProcessList.txt PROCESS get Caption,Commandline,Processid

rem or

WMIC /OUTPUT:C:\ProcessList.txt path win32_process get Caption,Processid,Commandline
