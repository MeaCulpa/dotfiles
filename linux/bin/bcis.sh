sqlite3 -line /mnt/dev/work/db/bcis_sqlite3 "select * from FIRM_CODE where firm_id in ( select firm_id from FIRM_INFO where name = '$1');"
