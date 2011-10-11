rem WARNING! Backup before doing this!!

rem mask private info strings before publishing
rem find -type f -name "*" -exec grep "%1" {} ;
find -type f -name "*" -exec sed -i "s/%1/XXXXXXXXX/g" {} ;
