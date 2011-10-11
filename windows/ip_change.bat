 rem netsh interface ip add dns "Local Area Connection" 8.8.4.4 index=2

 cls  
 @echo off  
 color 0B  
 echo **************************************  
 echo *IP Configuring Script  
 echo **************************************

 rem Chinese System
 rem set INTERFACE=本地连接
 rem set INTERFACEW=无线网络连接
 rem English System
 set INTERFACE=Local Area Connection
 set INTERFACEW=Wireless Network Connection


 rem home settings
 set IP=192.168.11.10 
 set MASK=255.255.255.0  
 set GATEWAY=192.168.11.1  
 set DNS=192.168.11.1


 rem on-site settings
 set IPO=XXX.XXX.XXX.XXX  
 set MASKO=255.255.255.0  
 set GATEWAYO=XXX.XXX.XXX.XXX  
 set DNSO=8.8.8.8

 rem home wlan settings
 set IPW=192.168.11.11 
 set MASKW=255.255.255.0  
 set GATEWAYW=192.168.11.1  
 set DNSW=192.168.11.1



 :MENU  
 echo.  
 echo For static IP settings press 1
 echo For dynamic DHCP settings press 2  
 echo For wireless settings press 3  
 echo.  
 echo To quit, press any other key  
 echo.  
 set /p KEY= [Entedr thy choise:]  
 if %KEY% == 1 (goto HOME)  
 if %KEY% == 2 (goto DHCP)  
 if %KEY% == 3 (goto WLAN)
 else goto END  
 @echo on  
 :DHCP  
 echo.  
 echo Going DHCP...
 echo.  
 netsh interface ip set address "%INTERFACE%" dhcp  
 netsh interface ip set dns "%INTERFACE%" dhcp  
 echo IP via DHCP configured!  
 goto END  
 :HOME  
 echo.  
 echo Going HOME settings...  
 echo.  
 echo Configuring IP......  
 netsh interface ip set address name="%INTERFACE%" source=static addr=%IP% mask=%MASK%  
 echo Configuring Gateway......  
 netsh interface ip set address name="%INTERFACE%" gateway=%GATEWAY% gwmetric=1  
 echo Configuring DNS......  
 netsh interface ip set dns name="%INTERFACE%" source=static addr="%DNS%"
 netsh interface ip add dns "%INTERFACE%" 8.8.8.8 index=2
 netsh interface ip add dns "%INTERFACE%" 8.8.4.4 index=3
 echo IP configured to %IP%!  
 goto END  
 :WLAN  
 echo.  
 echo Going wireless settings
 echo.  
 echo Configuring IP......  
 netsh interface ip set address name="%INTERFACEW%" source=static addr=%IPW% mask=%MASKW%  
 echo Configuring Gateway......  
 netsh interface ip set address name="%INTERFACEW%" gateway=%GATEWAY1% gwmetric=1  
 echo Configuring DNS......  
 netsh interface ip set dns name="%INTERFACEW%" source=static addr=%DNSW%%  
 echo IP configured to %IP1%! 
 goto END  
 :END  
 echo.

 rem current settings:
 rem netsh -c interface dump

 pause  

