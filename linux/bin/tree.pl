
$no_of_args = @ARGV;
$expand_size = 5;
$max_width = 10;

if(($no_of_args == 0) || ($no_of_args == 2))
{
  print "ERROR: Insufficient argument\n";
  goto help;
}
elsif($no_of_args == 3)
{
  if($ARGV[1] !~ "-width")
  {
    print "ERROR: Invalid argument\n";
    goto help;
  }
  elsif(($ARGV[2] > $max_width) || ($ARGV[2] < 2))
  {
    print "ERROR: Width should not lie outside 2 to $max_width.\n";
    goto help;
  }
  else
  {
    $expand_size = $ARGV[2];
  }
}
$dir_path = $ARGV[0];
if(!(-d $dir_path))
{
  print "ERROR: $dir_path doesn't exist\n";
  goto help;
}

if(($dir_path =~ /^\.$/) || ($dir_path =~ /^\.\/$/))
{
  $string = `pwd`;
  $dir_name = `basename $string`;
}
else
{
  $dir_name = `basename $dir_path`;
}

@array = `find $dir_path/*`;
$array_size = @array;
$line_count = 0;

print "+----$dir_name";
while($line_count < $array_size)
{
  $array[$line_count] =~ s/^$dir_path/  /;
  $array[$line_count] =~ s/.[^\/]*\//--/g;
  $line_count++;
}

$line_count = 0;
while($line_count < $array_size)
{
  $array[$line_count] = "\|\-".$array[$line_count];
  $string = " " x ($expand_size - 1);
  while($array[$line_count] =~ /--/)
  {
    $array[$line_count] =~ s/--//;
    $array[$line_count] =~ s/\|\-/|$string|-/;
  }
  $string = "-" x ($expand_size - 1);
  $array[$line_count] =~ s/\-/$string/;
  $array[$line_count] =~ s/\|$string/\+$string/;
  $line_count++;
}

@cross = 0;
$line_count = 0;
while($line_count < $array_size)
{
  $line = $array[$array_size - $line_count - 1];
  @line_array = split(//, $line);
  $no_of_char = @line_array;
  $char_count = 0;
  while($char_count < $no_of_char)
  {
    if($line_array[$char_count] =~ /\+/)
    {
      $cross[$char_count] = 1;
    }
    elsif($line_array[$char_count] =~ /\|/)
    {
      if($cross[$char_count] == 0)
      {
        $line_array[$char_count] = " ";
      }
    }
    else
    {
      $cross[$char_count] = 0;
    }
    $char_count = $char_count + $expand_size;
  }
  
  $array[$array_size - $line_count - 1] = join("", @line_array);
  $line_count++;
}

print @array;
exit;

help:
printf("#####################################################################\n");
printf("# To run the script,\n");
printf("# perl tree.pl <PATH> -width <width_no>\n");
printf("#    e.g. \"perl tree.pl . \" displays tree view of current dir\n");
printf("# \"-width\" expand or compress the tree. Max = $max_width, Min = 2\n");
printf("# Default width = 5\n");
printf("#####################################################################\n");

