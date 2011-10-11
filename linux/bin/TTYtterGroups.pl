####
## user group library written by @vkoser for TTYtter
## http://kosertech.com
## http://twitter.com/vkoser
## many thanks to @doctorlinguist for creating TTYtter

## Currenty this is the only configuration required
## change this to the directory where you would like
## to store your group files.
$Lib_path = "/home/inferno/.ttytter";


##### nothing to change beyond this point

$Lib_master = "$Lib_path/twt.bookmark";
if(open(S, $Lib_master)) {
        $Lib_id = 0+scalar(<S>);
        print $stdout "LIB: init last id: $last_id\n";
        close(S);
}

$addaction = sub {
    my @command = split(/ /);

    if($command[0] eq '/grouphelp'){
        print $stdout "Group commands are as follows.\n";
        print $stdout "/group [groupname]\n display stored tweets from group\n\n";
        print $stdout "/groups\n list the current groups on the filesystem\n\n";
        print $stdout "/grouplist [groupname]\n list the members of group [groupname]\n\n";
        print $stdout "/groupadd [groupname] [username]\n add [username] to group [groupname]\n\n";
        print $stdout "/groupdel [groupname] [username]\n delete [username] from group [groupname]\n\n";
        return 1;
    }    
    if ($command[0] eq '/group') {
        print $stdout "fetching group $command[1].\n";
        system("tail -20 $Lib_path/$command[1].twt");
        return 1;
    }
    if ($command[0] eq '/groups') {
        system("ls $Lib_path/*.lst  | awk -F'/' '{print \$NF}' | awk -F'.' '{print \$1}'");
        return 1;
    }
    if ($command[0] eq '/grouplist') {
        print "Group $command[1] contains:\n";
        system("/bin/cat $Lib_path/$command[1].lst");
        print "\n";
        return 1;
    }
    if ($command[0] eq '/groupdel') {
#pretty much a hack but works alright
        system("grep -v $command[2] $Lib_path/$command[1].lst > $Lib_path/$command[1].lsx");
        system("mv $Lib_path/$command[1].lsx $Lib_path/$command[1].lst");
        return 1;
    }
    if ($command[0] eq '/groupadd') {

        my $FOUND="false";

        if (-e "$Lib_path/$command[1].lst")
        {

        } 
        else{
            print("creating new group $command[1] !\n"); 
            system("touch $Lib_path/$command[1].lst"); 
            system("touch $Lib_path/$command[1].twt"); 
        }
        
        open(GROUP, "$Lib_path/$command[1].lst") || print("Couldn't open new group $Lib_path/$command[1].lst error!");


        my @array=<GROUP>;
        close (GROUP);
        my $line;
        foreach $line (@array){

            if ($line =~ /$command[2]/){
                print $stdout "User $command[2] already in group\n";
                $FOUND="true";
            }
        }
        
        if($FOUND eq "false"){
            open(GROUP,">>$Lib_path/$command[1].lst") || print("This group $Lib_path/$command[1].lst does not exist!");
            print GROUP "$command[2]\n";
            close(GROUP);
            print $stdout "User $command[2] added to group $command[1]\n";
        }

        return 1;
    }

    return 0;
};


$handle = sub {
    my $ref = shift;
    &defaulthandle($ref);
    
    my $screenname = &descape($ref->{'user'}->{'screen_name'});
    my $id = $ref->{'id'};

#if we're looking at an id lower than we have already handled
# then just exit out no need to evaluate
    if($Lib_id >= $id){
#        print "Already evaluated this tweet returning";
        return 1;
    }
    else{
        $Lib_id = $id;
    }


# evaluate the list of groups

    open(LSDIR,"ls $Lib_path/*.lst  | awk -F'/' '{print \$NF}' |") || die $!;
    @files =  <LSDIR>;
    close(LSDIR);
    
    @members = ();
    $fileIndex = 0;
    foreach $file (@files)
    {
        

        chomp($file); # lost whitespace off end

        next unless ($file =~ /([^\/]+)\.lst/);
        $group = $1;
        
        open(MEMBERS,"$Lib_path/$file") || die $!;
        @tmp = <MEMBERS>;
        close(MEMBERS);
        
        $count=0;
        foreach $member (@tmp)
        {
            # skip blank lines and lines starting with #
            next if(($member =~ /^\s*$/) || ($member =~ /^\s*\#/));
            push(@{$members[$fileIndex]},$member);
            $count++;
        }
        
        if($count == 0)
        {
            # membership file may be empty, create a placeholder if so
            $members[$fileIndex] = []; # empty list
        }
        
        $groupNames[$fileIndex++] = $group;
    }
    
    
    $x=0;
    foreach $arrRef (@members) { 

        foreach $data (@{$arrRef}) { 
            chomp($data);

            if($screenname eq $data){

                my $string = &wraptime(&descape($ref->{'created_at'})) .
                    " <$screenname> <" .
                    &descape($ref->{'user'}->{'name'}) .
                    "> " .
                    &descape($ref->{'text'}) . "\n";
                
                open(S, ">>", "$Lib_path/$groupNames[$x].twt") || print("can't open $Lib_path/$groupNames[$x] for append: $!\n");
                binmode(S, ":utf8") unless ($seven);
                print S $string;
                close(S);
            }

        }
        $x++;
    }
    
    return 1;
};

#update the bookmark file with the highest evaluated
#tweet ID , this should prevent us from grouping any
# tweets that have already been handled
$conclude = sub {

        if(open(S, ">$Lib_master")) {
                print S $Lib_id;
                close(S);
        } else {
                print $stdout "LIB: failure to write: $!\n";
        }
	&defaultconclude;
};
