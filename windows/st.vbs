DIM objShell
set objShell=wscript.createObject("wscript.shell")
iReturn=objShell.Run("tor.exe -f torrc", 0, TRUE)