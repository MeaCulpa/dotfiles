rem post img to immio
curl -s --form image=@%1 --form submit=OK http://imm.io/store/ | awk -F "\"[:,]\"" "{print $4}"

