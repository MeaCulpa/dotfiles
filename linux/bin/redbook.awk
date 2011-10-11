#!/usr/bin/awk
# Get IBM Redbook info
# Usage: wget -qO - "http://www.redbooks.ibm.com/cgi-bin/searchsite.cgi?query=aix&SearchOrder=4&SearchFuzzy=FALSE" | awk -f redbook.awk

BEGIN { FS = "</?a>|\?Open| HREF=\"" }
# filter lines we need
/\/abstracts.*Open\"/ {
    
    # For file names, substitute space with underline
    gsub(" ", "_", $4);
    
    # Dirty remover, fixing BAD filter regex :(
    gsub("\">", "", $4);
    
    # Array holding filename:page pair
    page[$4]="http://publib-b.boulder.ibm.com"$3"\?Open"
    
    # Original file name
    gsub(/\/abstracts\/|\.html/, "", $3)
    
    # Array holding filename:url pair
    url[$4]=sprintf ("http://www.redbooks.ibm.com/redbooks/pdfs/%s.pdf", $3)
}

END {
    for (file in url) 
        print file, "\t", url[file], "\t", page[file]
}
