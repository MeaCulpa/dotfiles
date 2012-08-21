NF == 1 {
    # Device
    # The "default" line.
    if ($0 == "default:") {
        dev = "default";
        power[dev] = "none";
        type[dev] = "default";
        seq[dev] = "0";
        subseq[dev] = "";
        head[dev] = "default:";
        next;
    }
    
    # Device name, trim "r" and ":".
    dev = substr($0, 2, length($0)-2);

    # Get powerpath device replacements: rhdisk => rhdiskpower.
    cmd = "powermt display dev="dev" 2>&1";
    cmd | getline s; match(s, "=");
    if (RLENGTH == 1) {
        power[dev] = dev = substr(s,RSTART+RLENGTH);
    }
    else {
        power[dev] = "none";
    }
     
    close(cmd);
  
    # Extract device type, name, sequence, subsequence ("hdisk XX :").
    match (dev, "[0-9]+")
    type[dev] = substr(dev,1,RSTART-1);
    seq[dev] = substr(dev,RSTART,RLENGTH);
    subseq[dev] = substr(dev,RSTART+RLENGTH);
  
    # De-trim
    head[dev] = "r"dev":";
    # Initialize Spec
    spec[dev] = ""
} 
  
NF > 1 {
    # All the parameters, using "|" for a tmp delimiter over newlines.
    spec[dev] = sprintf("%s|%s", spec[dev], $0);
} 
  
END {
    # Output.
    for (d in head) {
        # Raw IOs
        if (head[d] ~ /^rhd/) {
            print type[d], power[d], seq[d], subseq[d], head[d], spec[d], "|";
        }
        # FileSys IOs
        else if (head[d] ~ /^rjfs/) {
            print type[d], power[d], seq[d], subseq[d], head[d], spec[d], "|";
        }
        # Out Of Scope
        else {
            ;
        }
    }
} 

