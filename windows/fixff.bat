find -type f -name "*.sqlite" | sed "s/\(.*\)/sqlite3 &1\ VACUUM;/g" > indexer.bat
find -type f -name "*.sqlite" | sed "s/\(.*\)/sqlite3 &1\ REINDEX;/g" >> indexer.bat
rem ls -1 *.sqlite | sed "s/\(.*\)/sqlite3 &1\ VACUUM;/g" > indexer.bat
rem ls -1 *.sqlite | sed "s/\(.*\)/sqlite3 &1\ REINDEX;/g" >> indexer.bat
