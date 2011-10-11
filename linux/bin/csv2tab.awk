#!/bin/awk -f
# A simple CSV comma -> tab extractor
{
    $0=$0",";                           # yes, cheating
    while($0){
        match($0,/[^,]*,| *"[^"]*" *,/);            
        wf=f=substr($0,RSTART,RLENGTH); # save what matched in sf
        gsub(/^ *"?|"? *,$/,"",f);      # remove extra stuff
        printf("%s\t",f);               # tab delim 
        sub(wf,"");                     # wipe out matched
    }
    printf("\n")
}
