SET str=: ���ݿ�ʼ��
echo %DATE%%str%%TIME% >> C:\kwikscore_log\log_backup.txt
mkdir \\178.182.171.161\f$\scisdbbackup\tuscore\%DATE:~0,10%
copy /Y .\Log\*.log \\178.182.171.161\f$\scisdbbackup\tuscore\%DATE:~0,10%\ >> C:\kwikscore_log\log_backup.txt
mkdir .\Log\bak\%DATE:~0,10%
move /Y .\Log\*.log .\Log\bak\%DATE:~0,10%\ >> C:\kwikscore_log\log_backup.txt
SET str=: ���ݽ�����
echo %DATE%%str%%TIME% >> C:\kwikscore_log\log_backup.txt
echo ----------------- >> C:\kwikscore_log\log_backup.txt
