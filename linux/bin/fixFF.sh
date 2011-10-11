find ~/.mozilla -type f -name "*.sqlite" -exec sqlite3 {} VACUUM \;
find ~/.mozilla -type f -name "*.sqlite" -exec sqlite3 {} REINDEX \;
find ~/.thunderbird -type f -name "*.sqlite" -exec sqlite3 {} VACUUM \;
find ~/.thunderbird -type f -name "*.sqlite" -exec sqlite3 {} REINDEX \;

