#!/bin/bash

## Author: Richard S.W. Palusaar
## E-mail: mysqldumper@sublogic.se
## GTalk: generic477@gmail.com
## MSN: generic477@hotmail.com
## GoogleWave: generic477@gmail.com
## www: www.sublogic.se
## IRC: lazarus477 freenode.net
## YY-MM-DD
## 2009-10-10

#
# Module name:  MySQL Dumper
# This script backs up MySQL databases to indevidual files with
# file names matching the indevidual databases along with a .sql
# suffix appended: database.sql.
#
# The script will backup all databases to which the current user
# executing this script has access to.
#

# Settings

# Directory to dump databases to:
BACKUPDIR=./backups


## Internal variables

# Script arguments.
ARGS=("$@")
PNAME="MySQL Dumper"
PVER=1.0

# Databases to dump.
DBASES=(`mysql --batch --skip-column-names -e "show databases"`)

# Number of databases to dump.
NDBASES=${#DBASES[@]}


####### Function definitions ############


# Outputs a message and the text OK in color along with a new line.
# Arg 1 is message to print.

pok ()
{
	
	printf "%s" ${1}
	tput setaf 2
	printf " OK\n"
	tput sgr0

	return 0

}

pfailed ()
{
	
	printf "%s" ${1}
	tput setaf 1
	printf " FAILED!\n"
	tput sgr0

	return 0

}

# Checks if program arg1 is available and returns 0 if found or -1 if not.
chkprog () {

	if type -P ${1} > /dev/null; then pok ${1}; return 0; else pfailed ${1}; return -1; fi

}

# Checks if directory arg1 exsists. Returns 0 if found or -1 if not. A message describing the purpus of the
# directory is passed as arg2.
chkdir () {

	if [ -e "${1}" ] && [ -d "${1}"  ]; then pok "${2}"; return 0; else pfailed "${2}"; return -1; fi

}

######## Start of execution #############

## Clear terminal
clear


## Print welcome text

if which tput &> /dev/null; then tput setaf 2; fi

if which figlet &> /dev/null
	then figlet -t $PNAME
	printf "\n"
	else
	printf "%s" "$PNAME\n"
fi
tput sgr0

printf "\nversion %s\n\n" "$PVER"


## Do checks and and display results.
printf -- "--Performing-checks-------------------------\n"

chkprog "mysqldump"
chkdir "$BACKUPDIR" "backup directory"


# Print settings
echo
echo --Settings----------------------------------
echo Backup directory: "$BACKUPDIR"

# Do backups
echo
echo --Backing up MySQL databases----------------
echo
echo There are a total of $NDBASES databases to backup.
echo

for (( i=0; i < $NDBASES; i++ ))
	do
		dbase=${DBASES[$i]}
		printf "dumping: %s - " "$dbase"
		if mysqldump --opt $dbase > "$BACKUPDIR/$dbase".sql; then tput setaf 2; printf "ok"; else tput setaf 1; printf "faild!"; fi
		printf "\n"
		tput sgr0
	done
