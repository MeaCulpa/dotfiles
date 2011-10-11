#!/usr/bin/perl
use Date::Manip;

my $newdate = shift @ARGV;
my $olddate = shift @ARGV;
$date1 = ParseDate("$newdate");
$date2 = ParseDate("$olddate");
$delta = DateCalc($date1,$date2,\$err,1);
print "$delta\n";