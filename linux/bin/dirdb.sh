#!/bin/bash

#ls -l | sed 's/\s\s*/,/g' | tail -n +2
DIR=.

rm -f $DIR/create.sql $DIR/load.sql $DIR/files.db

ls -l | sed 's/\s\s*/,/g' | tail -n +2 > $DIR/import.csv

echo "CREATE TABLE FILES(perms text,
                         links int,
                         user text,
                         groups text,
                         bytes int,
                         mon text,
                         day int,
                         time_year text,
                         file text);" > $DIR/create.sql

sqlite3 -line files.db ".read $DIR/create.sql" 

echo -e ".separator \",\"\n" > $DIR/load.sql
echo -e ".import $DIR/import.csv FILES\n" >> $DIR/load.sql

sqlite3 -line files.db ".read $DIR/load.sql"


