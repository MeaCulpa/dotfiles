BEGIN {
    FS="[\\(|\\)|\\[|\\]]";
    enc_dmg = 0;
    enc_starttic = 0;
    enc_endtic = 0;
    enc_target = "";
    enc_highhit = 0;
    enc_starttime = "";
    enc_endtime = "";

    ansi_color = 1;
}

$5 ~ /^ YOU.*for .* damage\./ {
    
    # Category
    if ( match($5, "YOU.* for [0-9]+") ) {
        art = substr($5,RSTART,RLENGTH);
        sub(" hit .*", "", art);
        sub(" hits .*", "", art);
        sub(" attack .*", "", art);

        sub("YOUR", "", art);
        sub("YOU", "", art);
        sub("^ +", "", art);
        if (art == "") {
            art = "Auto Atk";
        }
        else if (art == "multi") {
            art = "Multi Atk";
        }

        #print "ART: "art;
    }


    match($5, "(multi attack|hit|hits) .* for");
    #print 
    target = substr($5,RSTART,RLENGTH);
    
    sub(" for.*", "", target);
    sub("hit ", "", target);
    sub("hits ", "", target);
    sub("multi attack ", "", target);
    #print "target: "target;
    enc_target = target;
    # Encounter dmg
    match($5, "for [0-9]+");
    dmg = substr($5,RSTART+4,RLENGTH-4);
    #print "dmg: "dmg;
    if ( dmg > enc_highhit ) {
        enc_highhit = dmg;
        hitart[enc_highhit] = art;
    }
    enc_dmg += dmg;
    if ( enc_starttic == 0 ) enc_starttic = $2;

    n=split($4, a_time, " ");
    if ( enc_starttime == "" ) enc_starttime = a_time[2]""a_time[3]" "a_time[5]": "a_time[4];
}

$5 ~ / have killed / {
    # killed a mob
    n=split($4, a_time, " ");
    #enc_endtime = a_time[2]""a_time[3]" "a_time[5]": "a_time[4];
    # Shorten version but not handling midnight
    enc_endtime = a_time[4];

    killed = sub(".* killed ", "", $5);
    killed = sub("\\.", "", $5);
    #print "killed: "$5;
    #print "Encounter DMG: "enc_dmg;
    #print $2;
    enc_dur = $2 - enc_starttic;
    #print "encounter duration: "enc_dur;
    if (enc_dur == 0) enc_dur = 1;
    enc_dps = enc_dmg / enc_dur;
    printf("[%s - %s]: Enc [%s] DPS: [%s] Duration: [%ss] Highist Hit: [%s: %s]\n ", enc_starttime, enc_endtime, enc_target, enc_dps, enc_dur, hitart[enc_highhit], enc_highhit);

    enc_dmg = 0;
    enc_starttic = 0;
    enc_target = "";
    enc_highhit = 0;
    hitart[enc_highhit] = "";
    enc_starttime = "";
    enc_endtime = "";
}

END {
    print "";
}
