@echo off
color 07
prompt $p$g
title Command Prompt Portable
cls
ver
cd\

echo "Populating VARS..."
SET HTTP_PROXY_RC=hkce01.hk.ibm.com:80
SET HTTPS_PROXY_RC=hkce01.hk.ibm.com:80
SET FTP_PROXY_RC=hkce01.hk.ibm.com:80

SET PATH=%PATH%;d:\Ruby192\bin;
SET PATH=%PATH%;C:\Program Files\Windows Resource Kits\Tools\;
SET PATH=%PATH%;C:\WINDOWS\system32;C:\WINDOWS;
SET PATH=%PATH%;C:\WINDOWS\System32\Wbem;
SET PATH=%PATH%;C:\Program Files\IBM\Infoprint Select;
SET PATH=%PATH%;C:\Notes;
SET PATH=%PATH%;C:\Program Files\XLView;
SET PATH=%PATH%;C:\lotus\compnent;
SET PATH=%PATH%;C:\Utilities;
SET PATH=%PATH%;C:\Program Files\Common Files\Lenovo;
SET PATH=%PATH%;C:\program files\ibm\personal communications\;
SET PATH=%PATH%;C:\Program Files\IBM\Trace Facility\;
SET PATH=%PATH%;D:\Bazaar;D:\aria2;
SET PATH=%PATH%;D:\gnuwin32\bin;
SET PATH=%PATH%;D:\Python27;
SET PATH=%PATH%;D:\ImageMagick;
SET PATH=%PATH%;C:\Program Files\Intel\WiFi\bin\;
SET PATH=%PATH%;C:\Program Files\ThinkPad\ConnectUtilities;
SET PATH=%PATH%;D:\Python27\Scripts;
SET PATH=%PATH%;D:\mingw\bin;
SET PATH=%PATH%;d:\MinGW32\bin;
SET PATH=%PATH%;d:\MinGW\bin;
SET PATH=%PATH%;D:\sqlte;
SET PATH=%PATH%;D:\nc;
SET PATH=%PATH%;D:\perl\c\bin;
SET PATH=%PATH%;D:\perl\perl\site\bin;
SET PATH=%PATH%;D:\perl\perl\bin;
SET PATH=%PATH%;d:\Nmap;
SET PATH=%PATH%;d:\putty\;
SET PATH=%PATH%;D:\bin;
SET PATH=%PATH%;D:\gnuwin32\bin
SET PYTHONPATH=%PYTHONPATH%;D:\wsbzr\auto\working\src


echo "...done"

gcal
