#!/usr/local/bin/perl

use lib qw(/home/builds/scripts);
use Getopt::Long;
use build;

my $reqdir = '/home/builds/config';

eval { require "$reqdir/Defaults.pl"; };

if ( $@ ) {
   exit_err(1, "Error with configfile Defaults.pl: $!");
} 

my ($configfile, $debug, $silent, $user);
$configfile = $debug = $silent = $user = "";

my %cdlink = {};

GetOptions("config=s" => \$configfile, 
           "debug+"   => \$debug, );

unless ( $configfile ) {
   usage();
   exit_err(1, "Incorrect command line arguments\n");
}

eval { require $configfile; };

if ( $@ ) {
   exit_err(1, "Error with configfile $configfile: $!");
} 

### If we're not verbose, let's be quiet (probably from cron)

unless ( $debug ) {
   $silent = 1;
}

### We're called by system(), so let's output back into their STDOUT

print get_stamp() . " [buildreport.pl] Started.\n" unless $silent;

$today = scalar localtime(time());

### Leave this for now - REMINDER, set something up to watch this
### for you.

my $dfcmd = "df -k $buildroot | tail -1 | awk \'{print \$4,\$5}\'";

($diskleft, $diskusage) = split(/ /,`$dfcmd`);

open(OF, ">$outputfile") || do {
   exit_err(1, "Unable to open $outputfile");
};

print get_stamp() . " [buildreport.pl] Opened $outputfile\n" unless $silent;

select(OF); $| = 1;

###
### Template Toolkit this at some point. Let's get it neat first
###

my $stamp = get_stamp();

print <<EOF;

<HTML>
<HEAD>
<TITLE>Build Report for $projectname</TITLE>
</HEAD>
<DIV ALIGN=CENTER>

<TABLE>
<TR>
  <TD>Build Report for</TD><TD><B>$projectname</B></TD>
</TR>
<TR>
 <TD>Ran on</TD><TD>$stamp</TD>
</TR>
<TR>
 <TD>Build filesystem usage :</TD><TD>$diskusage</TD>
</TR>
<TR>
 <TD>Build filesystem kb left:</TD><TD>$diskleft</TD>
</TR>
<TR>
 <TD></TD><TD><A HREF='.'>Top level build logs</A></TD>
</TR>
</TABLE>

</DIV>
<HR>
<BR>

<TABLE BORDER=0 WIDTH=100%>
 <TR>
  <TD><B>host</B></TD>
  <TD><B>platform</B></TD>
  <TD><B>date</B></TD>
  <TD><B>status</B></TD>
  <TD COLSPAN=2><B>links</B></TD>
  <TD><B>cvs tag</B></TD>
  <TD><B>variant</B></TD>
  <TD><B>user</B></TD>
 </TR>
 <TR>
  <TD></TD>
 </TR>

EOF

print "<!-- DATA_START --> \n";

select(STDOUT); $| = 1;

my (@files, $file, $name, $dir, @dirs);

if ( ! opendir(DIR,"$buildroot") ) {
   exit_err(1, "Unable to open dir $buildroot: $!\n");
}

@files = readdir(DIR);

closedir(DIR);


foreach my $date (@files) {

   next unless ($date =~ /\d+\-\d+\-\d+_\d+/);
   next unless (-d "$buildroot/$date");

   $builds_online{$date}++;

   $name = "";

   ### Grab the name if it has been 'keeped' #######################
   if (-f "$buildroot/$date/.keep") {
      if ( open(KEEP,"$buildroot/$date/.keep") ) {
         while(<KEEP>) {
            if (/^name: (.+)/) { $name = $1; }
         }
         close(KEEP);
      }
      else {
         print get_stamp() .
         " [buildreport.pl] Unable to open .keep for read! $!\n" unless $silent;
      }
   }

   ### If we're a tag build, grab the appropriate tag ##############
   my $tag = 'trunk';
   if (-f "$buildroot/$date/TAGBUILD") {
      if ( open(TAG, "<$buildroot/$date/TAGBUILD") ) {
         $tag = <TAG>; chomp($tag); close(TAG);
      }
      else {
         print get_stamp() . 
		" [buildreport.pl] Unable to open TAGBUILD for $file! $!\n" 
                 unless $silent;
      }
   }

   ### Likewise check to see if we're a variant build ##############
   my $variant = 'RELEASE';
   if (-f "$buildroot/$date/VARIANT") {
      if ( open(VARFILE, "<$buildroot/$date/VARIANT") ) {
	 $variant = <VARFILE>; chomp($variant); close(VARFILE);
      }
      else {
	 print get_stamp() .
		" [buildreport.pl] Unable to open VARIANT for $file! $!\n"
		unless $silent;
      }
   }
    

   opendir(BDIRS,"$buildroot/$date");
   @dirs = readdir(BDIRS);
   closedir(BDIRS);

   foreach my $host (@dirs) {

      $user = '';
      next unless (-d "$buildroot/$date/$host");

      next if ($host =~ /^\./);
      next if ($host =~ /^cdimage/);    
      next if ($host eq 'package');    
      next if ($host eq 'template');
      next if ($host eq 'scripts');
      next if ($host eq 'reports');
      next if ($host eq 'status');
      next if ($host eq 'stage');
      next if ($host eq 'change_descriptions');
      next if ($host eq 'emit');

      print get_stamp() . " [buildreport.pl] Processing $date/$host\n"
                 unless $silent;


      ### Set log dir for viewing logs ############################
      if (-d "$buildroot/$date/$host/logs") {
         $logs = "<A HREF='$urlprefix/$date/$host/logs'>logs</a>";
      } 
      else {
         $logs = 'N/A';
      }

      ### Set platform type #######################################
      if (defined($platforms{$host})) {
         $arch = $platforms{$host};
      } 
      else {
         $arch = 'unknown';
      }

      if (-d "$buildroot/$date/$host/src/package-$variant" ) {
	 $pkgdir = "$date/$host/src/package-$variant"; 
      } elsif (-d "$buildroot/$date/$host/$projectname/package-$variant" ) {
	 $pkgdir = "$date/$host/$projectname/package-$variant";
      } elsif (-d "$buildroot/$date/$host/src/package" ) {
	 $pkgdir = "$date/$host/src/package";
      } else {
         $pkgdir = "$date/$host/package/$arch_OBJ";
      }

      ### If we set $variant to RELEASE for the above to work, we
      ### now want to set it back to nothing to avoid an ugly-lookin'
      ### page.
      if ( $variant =~ /RELEASE/ ) { 
	 $htmlvariant = "";
      } 
      else {
         $htmlvariant = $variant;
      }

      ### The download link #######################################
      if (-d "$buildroot/$pkgdir") {
         $dl = "<A HREF='$pkgdir'>download</A>";
         if (-f "$buildroot/$file/$dir/$gui") {
            $dl .= " (<A HREF='$urlprefix/$file/$host/$gui'>gui</A>)";
         }
      } 
      else {
         $dl = '';
      }

      ### Get the user who ran the build #################################

      my $statusfile = "$buildroot/status/$host\_$date";

      if ( open(LF, "<$statusfile") ) {
            while ( defined ( $_ = <LF> ) ) {
               if (/user: (.*)$/) {
                  $user = $1;
                  last;
               }
            }
            close(LF);
      } else {
            unless ( $silent ) {
               print get_stamp() . " [buildreport.pl] Unable to open status";
               print "$statusfile log! $!\n";
            }
      }

      ### CD Image Link #####################################

      if ( -d "$buildroot/$date/stage" ) {
         $cdlink{$date} = "<A HREF=\"$date/stage\">CD Image</A>";
      }

      ### The status  #######################################

      $status = "";

      if ( $name ) {
         $status = "<font color=green>$name</font>";
      } 

      else {
         my $longfile = "$buildroot/$date/$host/logs/buildreport.txt";

         if ( open(LF, "<$longfile") ) {
            while ( defined ( $line = <LF>) ) {
               if ($line =~ /^Build was unsuccessful/) {
                  $status = "<font color=red>failed</font>";
                  last;
               }
               elsif($line =~ /^Finished at/) {
                  $status = "<font color=green>success</font>";
                  last;
               }
            }
            close(LF);
         }
         else {
            unless ( $silent ) {      
               print get_stamp() . " [buildreport.pl] Unable to open $date";
               print "/$host buildreport log! $!\n";
            }
         }


         if ( ! $status ) {
            ### try for top level status file

	    my $longfile = "$buildroot/status/$host\_$date";
 
            if ( open(LF, "<$longfile") ) {
               while ( defined ( $line = <LF> ) ) {
                  if ($line =~ /status: (.*)$/) {
                     $status = "<font color=orange>$1</font>";
                     last;
                  }
               }
               close(LF);
            }
            else {
               unless ( $silent ) {
                  print get_stamp() . " [buildreport.pl] Unable to open status";
                  print "/$longfile log! $!\n";
               }
            }
         }

         if (! $status ) {
            $status = '<font color=orange>unknown</font>';
            $dl     = 'N/A';
         }
      } 

      $line =<<EOF;

<!-- NEW_ROW -->
<TR>
<TD>$host</TD>
<TD>$arch</TD>
<TD>$date</TD>
<TD>$status</TD>
<TD>$logs</TD>
<TD>$dl</TD>
<TD>$tag</TD>
<TD>$htmlvariant</TD>
<TD>$user</TD>
</TR>
   
EOF

    $output{$date}{$host} = $line;

   } # end foreach host dir
} # end foreach date dir

select(OF);

foreach my $id ( reverse ( sort bydate (keys(%output) ) ) ) {
   foreach $host ( sort ( keys %{$output{$id}} ) ) {
      print $output{$id}{$host};
   }
   if ($cdlink{$id}) { print "
<TR>
<TD></TD>
<TD></TD>
<TD>$id</TD>
<TD></TD>
<TD></TD>
<TD>$cdlink{$id}</TD>
<TD></TD>
<TD></TD>
</TR>
";
   }
   
   print "<TR><TD>&nbsp;</TD></TR>\n";
}

print "<!-- DATA_END --> \n";

print <<EOF;

</TABLE>
<HR>
<DIV ALIGN=CENTER>
<FONT SIZE=-1>problems/questions, send mail to $re</FONT></DIV>
</BODY>
</HTML>

EOF

close(OF);

select (STDOUT);

print get_stamp() . " [buildreport.pl] Closed $outputfile\n" unless $silent;

exit_err(0, "", 1);

###################################################################

sub bynum {
   my($ay,$am,$ad) = split('-',$a);
   my($by,$bm,$bd) = split('-',$b);
   return ( ($ay <=> $by) || ($am <=> $bm) || ($ad <=> $bd) );
}

###################################################################

sub bydate {

  my ($ay,$am,$ad,$an) = split(/\D+/,$a);
  my ($by,$bm,$bd,$bn) = split(/\D+/,$b);

  return ( ($ay <=> $by) || ($am <=> $bm) || ($ad <=> $bd) || ($an <=> $bn) );

}

####################################################################

sub usage {

   print <<EOF;

$0 -config configfile.pl

Draws in config variables from configfile.pl, in particular \$outputfile,
and generates a report based on the \$buildroot/builddate existance and
the hosts within. 


EOF

}
