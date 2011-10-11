echo %DATE%%TIME% >> F:\scisdbbackup\bk\log_bk.txt
xcopy /Y /E F:\scisdbbackup\scis\data\scis_data \\178.182.171.54\d$\scisdbbk_161\scis_data >> F:\scisdbbackup\bk\log_bk.txt
echo %DATE%%TIME% >> F:\scisdbbackup\bk\log_bk.txt
echo ----------------- >> F:\scisdbbackup\bk\log_bk.txt