cd E:\portable\FirefoxPortable
find -type f -name "*.sqlite" | sed "s/\(.*\)/sqlite3 &1\ VACUUM;/g" > indexer.bat
find -type f -name "*.sqlite" | sed "s/\(.*\)/sqlite3 &1\ REINDEX;/g" >> indexer.bat
call indexer.bat

cd E:\portable\ThunderbirdPortable
find -type f -name "*.sqlite" | sed "s/\(.*\)/sqlite3 &1\ VACUUM;/g" > indexer.bat
find -type f -name "*.sqlite" | sed "s/\(.*\)/sqlite3 &1\ REINDEX;/g" >> indexer.bat
call indexer.bat
