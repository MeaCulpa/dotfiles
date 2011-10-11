#!/usr/bin/perl
use File::Find;
use File::Basename;

@ARGV=qw(.) if not @ARGV;
find(\&doit, @ARGV);

sub doit {
   $fpath=$File::Find::name;
   $fname=basename($fpath);
   print "$fname $fpath\n";
}
