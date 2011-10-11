#!/usr/bin/awk
# Get IBM Redbook info
# Usage: 
#       download:
#       wget -qO - "http://www.redbooks.ibm.com/cgi-bin/searchsite.cgi?query=aix&SearchOrder=4&SearchFuzzy=" | awk -f redbook.awk
#       try urls out:
#       wget -qO - "http://www.redbooks.ibm.com/cgi-bin/searchsite.cgi?query=aix&SearchOrder=4&SearchFuzzy=" | awk -f redbook.awk -vTEST=yes
#
# Maybe a wrapper.sh:
#       !/usr/bin/sh
#       wget -qO - "http://www.redbooks.ibm.com/cgi-bin/searchsite.cgi?query=$1&SearchOrder=4&SearchFuzzy=" | awk -f redbook.awk
#       

BEGIN { FS = "</?a>|\\?Open| HREF=\"" }
# filter lines we need
/\/abstracts.*Open\"/ {
    
    # For file names, substitute space with underline
    gsub(" ", "_", $4);
    
    # Dirty remover, fixing BAD filter regex :(
    gsub("\">", "", $4);
    
    # Deal with special chars
    gsub(/\/|\:/, "-", $4)
    
    # Array holding filename:page pair
    page[$4]="http://publib-b.boulder.ibm.com"$3"?Open"
    
    # Original file name
    gsub(/\/abstracts\/|\.html/, "", $3)
    

    # Array holding filename:url pair
    if ($3 ~ /^tips/)
        # technotes
        url[$4]=sprintf ("http://www.redbooks.ibm.com/technotes/%s.pdf", $3)
    else if ($3 ~ /^redp/)
        # redpapers
        url[$4]=sprintf ("http://www.redbooks.ibm.com/redpapers/pdfs/%s.pdf", $3)
    else
        # redbooks
        url[$4]=sprintf ("http://www.redbooks.ibm.com/redbooks/pdfs/%s.pdf", $3)
}

END {
    for (file in url)
        # Info Matrix
        # print file, "\t", url[file], "\t", page[file]

        # check url
        if (TEST=="yes"){
            printf("Target on %s: ", page[file])
            system("wget --spider "url[file]" 2>&1 | grep \"response\"")
        }
        # do download
        else
            system("wget "url[file]" -O "file".pdf\n")
}
