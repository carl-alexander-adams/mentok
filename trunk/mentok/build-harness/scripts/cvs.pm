### 
### Build scripts library - move commonly used functions and
### actions into here and abstract them enough to be reused
### by any and all
###

package cvs;
require Exporter;

use Cwd;

@ISA       = qw(Exporter);

@EXPORT    = qw(
	        cvs_env cvs_log cvs_status cvs_getlog
	        cvs_co cvs_tag cvs_cleanup cvs_treerev cvs_treediff
                cvs_verbose cvs_dump
               );

@EXPORT_OK = qw();
$VERSION   = 1.10;

use lib qw(.);
use build;

my $cvs = where('cvs');
my $cvs_verbose = 0;

#############################################################
###
### cvs_status - Get the cvs status of a file, makes the
### assumption that the correct CVSROOT and CVS_RSH envs
### are set, we should make this part of a cvs perl lib at
### some point
###
### REQUIRES file
### RETURNS Revision plus checkin history

sub cvs_status {

   my $file = shift;

   my $cstat;
   my $rev;
   my $clog;

   return undef, unless ($file);

   open(CS, "cvs status $file 2>&1 | ") || do {
      print get_stamp() . "Can't cvs status $file! $! \n";
      return undef;
   };

   while (defined ($cstat = <CS>) ) {
      ($rev = $1) if ( $cstat =~ m#Working revision:\s+(\d+[\.\d+]*)\s*# );
   }
   close(CS);

   if ( defined($rev) && ($rev) ) {
      $clog = cvs_log($file, $rev);
      return "CVS log of last check-in of $file :\n\n $clog";
   }

}

###################################################################
###
### cvs_log - grab the cvs log output from a particular file
###
### REQUIRES file and rev
### RETURNS checkin history

sub cvs_log {

   my $file = shift;
   my $rev  = shift;

   my $ret;
   my $clog;

   return undef unless ($file && $rev);

   open (CLOG, "cvs log -N -r$rev $file 2>&1 | " ) || do {
      return "Unable to get CVS log of file $file! $!\n";
   };

   while ( defined ($clog = <CLOG>) ) {
      $ret .= $clog;
   }
   close(CLOG);

   return $ret;

}

##########################################################
###
### cvs_env 
### This is just a stub now, ENV work is done elsewhere. 
###

sub cvs_env {

   return 1; 

}

sub cvs_co { 

   my $revision = shift;
   my $redir    = shift || ""; 
   my $scvar    = shift;

   my $cmd = "$cvs co ";

   # at this point, a hardcoded revision overrides any passed
   # revisions. You put it in the conf file for a reason, right? 

   # Later include a lookup to a revision table, with 
   # name->revision ... SCVar should have a 'name' field.

   if (defined $scvar->{'revision'}) {
      $cmd .= "-r $scvar->{'revision'} "; 
   }
   elsif ($revision) {
      $cmd .= "-r $revision "; 
   }   
   if (defined $scvar->{'cvsmod'}) {
      $cmd .= "$scvar->{'cvsmod'} ";
   }
   else {
      $cmd .= ". ";
   }

   my ($tardir, $curdir) = '';

   if (defined $scvar->{'altdir'}) {
      $tardir = $scvar->{'altdir'};
      $curdir = getcwd();
      # Just keep trying despite failure.
      b_system("mkdir -p $tardir 2>/dev/null");
      print get_stamp() . " Changing to $tardir for checkout.\n";
      unless ( chdir($tardir) ) {
         print get_stamp() . " Unable to chdir to altdir $altdir for co\n";
         if ($tardir) { chdir $curdir; }
         return 0;
      }
   }

   print get_stamp() . " ### Beginning CVS Checkout from $ENV{'CVSROOT'}\n";

   if ( b_system("$cmd $redir") ) {
      print get_stamp() . " +++ CVS co of source failed. \n";
      if ($tardir) { chdir $curdir; }
      return 0;
   }

   if ($tardir) { chdir $curdir; }

   return 1;

}

sub cvs_tag { 

   # tag is also stupid, but in a way we like. Just turn it loose
   # top level, and it will tag appropriately, recursively.
   # EXCEPT when you bury a cvs co underneath another one - then it
   # gets confused. 

   my $args  = shift;
   my $redir = shift;
   my $lref  = shift; 

   my ($tardir, $curdir) = '';
                                                                                
   if (defined $lref->{'altdir'}) {
      $tardir = $lref->{'altdir'};
      $curdir = getcwd();
      unless ( chdir($tardir) ) {
         print get_stamp() . " Unable to chdir to altdir $altdir for co\n";
         return 0;
      }
   }
   
   if ( b_system("$cvs tag $args $redir") ) {
      print get_stamp() . " +++ CVS tag of source failed. \n";
      if ($tardir) { chdir $curdir; }
      return 0;
   }
                                                                                
   if ($tardir) { chdir $curdir; }

   return 1;

}

sub cvs_cleanup { 

   ### CVS doesn't need to cleanup after itself.

   return 1;

}

############################################################
### cvs_treerev - find the revisions of all files in the 
### source tree.
### At this point we hope we're in the top level dir.

sub cvs_treerev {

   my $logfile = shift;
   my $empty   = shift; ## compat'ing with code_work from vcs.pm
   my $lref    = shift;

   my $root;

   ### This should grab the path from cvsroot
   ### assuming :ext:foo@bar:/cvs/root/foo

   ($root) = $ENV{'CVSROOT'} =~ m#:(/\S+)$#;

   if ( ! $root ) {
      print get_stamp() . " [cvs_treerev] Root not set.\n";
      return 0;
   }

   if ( ! $logfile ) {
      print get_stamp() . " [cvs_treerev] Logfile not specified!\n";
      return 0;
   }

   if (-f "$logfile") { 
      print get_stamp() . " [cvs_treerev] Opening logfile for APPEND\n";
   }

   open (LF, ">>$logfile") || do {
      print get_stamp() . " [cvs_treerev] Unable to open $logfile! $!\n";
      return 0;
   };

   # Drop this hint line to our revlog output.

   if (defined ($lref->{'name'})) {
      print LF "# M:CVS N:$lref->{'name'}\n"; 
   }

   if (defined ($lref->{'altdir'})) { $altdir = $lref->{'altdir'}; }
   if($altdir) { $origdir = getcwd(); chdir ($altdir); }

   open(CSTAT,"$cvs -q status |") || do {
      print get_stamp() . " [cvs_treerev] Could not run cvs status: $!\n";
      if($altdir) { chdir ($origdir); }
      return 0;
   };

   my ($line, $rev, $file, %files, $cvsmod);
   my (@moddirs, @filedirs, $fail, $i);

   while( defined($line = <CSTAT>) ) {
      next unless ($line =~ /Working revision:\s+(\d+[\.\d+]*)\s*/);
      $rev  = $1;
      $line = <CSTAT>;
      next unless ($line =~ /Repository revision:\s+(\d+[\.\d+]*)\s+(.+)/);
      $file = $2;

      ### trim off the ,v
      $file =~ s/\,v$//;

      ### CVSROOT is different? Wrong set of files. 
      ### cvs status is blind and stupid.
      @moddirs = split(/\//,$root);
      @filedirs = split(/\//,$file);
      $fail = 0;
      for ($i = 0; $i <= $#moddirs; $i++) {
         if ( $moddirs[$i] ne $filedirs[$i] ) {
            $fail = 1;
         }
      }
      if ($fail) { next; }

      ### trim off the root
      $file =~ s/^$root//;
      
      ### trim off the leading slash (for proper treediff)
      $file =~ s#^/##;
      
      ### Trim Attic - should leave file where it WAS. (for cvs log later)
      ### Issues with moved/deleted files on trunk vs. diff on branch.
      $file =~ s#Attic/##;

      ### cvs status is blind and stupid.
      if ( defined ($lref->{'cvsmod'}) && ($lref->{'cvsmod'} ne '.') ) {
          $cvsmod = $lref->{'cvsmod'};
          @moddirs = split(/\//,$cvsmod);
          @filedirs = split(/\//,$file);
          $fail = 0;
          for ($i = 0; $i <= $#moddirs; $i++) {
              if ( $moddirs[$i] ne $filedirs[$i] ) {
                 $fail = 1;
              }
          }
          if ($fail) { next; } 
      }

      ### avoid strange dups...
      next if (defined($files{$file}));

      $files{$file}++;

      print LF "$file:$rev\n";
   }
   close(CSTAT);
   close(LF);
   
   if($altdir) { chdir ($origdir); }

   return 1;

}

############################################################
###
### this is obsoleted and work is done at the vcs level now.
###

sub cvs_treediff {
   my $file_1  = shift;
   my $file_2  = shift;

   my $outfile = shift;

   if (! $file_1 ) {
      print get_stamp() ." [treediff] First file was not defined!";
      return 0;
   }
   if (! $file_2 ) {
      print get_stamp() . " [treediff] Second file was not defined!";
      return 0;
   }

   if (! $outfile ) {
      print get_stamp() . " [treediff] Outputfile was not defined!";
      return 0;
   }

   open(F1, "<$file_1") || do {
      print get_stamp() . " [treediff] Could not read $file_1: $!\n";
      return 0;
   };

   open(F2, "<$file_2") || do {
      print get_stamp() . " [treediff] Could not read $file_2: $!\n";
      return 0;
   };

   open(OF, ">$outfile") || do {
      print get_stamp() . " [treediff] Unable to open $outfile! $!\n";
      return 0;
   };
   print get_stamp() . " [treediff] Diffing $file_1 and $file_2\n";

   my ($file, $rev, $oldrev, $line, %added, %changed, %oldfiles);

   ### file 1, the old file
   while(defined($line = <F1>) ) {
      chomp($line);
      next if ($line =~ /^#/);
      ($file,$rev) = split(':', $line);
      next unless ($file);
      $oldfiles{$file} = $rev;
   }
   close(F1);

   ### file 2, the new file.
   open(F2, "$file_2") || do {
      print get_stamp() . " [treediff] Could not read $file_2: $!\n";
      return 0;
   };

   # New change, we have to do our output inline, since we will be
   # changing CVS root's on the fly (possibly). 

   my ($COUT, $AOUT);

   $COUT = "Files changed:\n-------------\n";
   $AOUT = "Files added:\n-------------\n";

   while(defined ($line = <F2>) ) {
      chomp($line);
      if ($line =~ /^#/) {
         ($meth, $cvsmod, $projname, $cvsroot, $cvsrsh) = $line =~ 
           /M:(\S+) M:(\S+) M:(\S+) (\S+) (\S+)/;
         if ($meth && $meth eq "CVS") {
            $ENV{'CVSROOT'} = $cvsroot;
            $ENV{'CVS_RSH'} = $cvsrsh;
         }
         next;
      } 
      ($file, $rev) = split(':', $line);
      next unless ($file);
      if (defined($oldfiles{$file})) {
         $oldrev = $oldfiles{$file};
         print OF "$file: [$oldrev] vs [$rev]\n" if $cvs_verbose >= 3;
         delete $oldfiles{$file};
         if ($rev cmp $oldrev) {
            $COUT .= "$file:$rev\n";
            $COUT .= cvs_getlog($file,$rev) if $cvs_verbose;
            next;
         }
      }
      else {
         $AOUT .= "$file:$rev\n";
         $AOUT .= cvs_getlog($file,$rev) if $cvs_verbose;
         next;
      }
   }
   close(F2);
   my $oldfh =  select(OF);

   print $COUT, "\n";
   print $AOUT, "\n";

   print "Files removed:\n-------------\n";
   foreach (sort keys %oldfiles) {
      print "$_:$oldfiles{$_}\n";
   }

   close(OF);

   select $oldfh;
   return 1;

}


sub cvs_getlog {

   my ($file, $rev) = @_;
   my ($line, $comment);


   print get_stamp() . "Getting cvs filelog for ${file}#${rev}\n" if
      $cvs_verbose >=2;

   open(LOG, "cvs -q log -r$rev $file|") || do {
      print get_stamp() .
         " [treediff] Unable to open cvs log for rev $rev and file $file\n";
      return;
   };

   while(defined ($_ = <LOG>) ) {
      last if (/^description:/);
   }
   while(defined ($line = <LOG>) ) {
      if ($line =~ /^====/) {
         $comment .= "\n";
         last;
      }
      $comment .= $line;
   }
   close(LOG);

   return $comment;
}

sub cvs_verbose {

   my $verb = shift;

   $cvs_verbose = $verb;

   return $cvs_verbose;

}

sub cvs_dump {
 
   return 1;

}

1;
