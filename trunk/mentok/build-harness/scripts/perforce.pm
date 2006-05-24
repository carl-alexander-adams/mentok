### 
### Build scripts library - move commonly used functions and
### actions into here and abstract them enough to be reused
### by any and all
###

package perforce;
require Exporter;

@ISA       = qw(Exporter);

@EXPORT    = qw(
	        perforce_env perforce_getlog perforce_status 
	        perforce_co perforce_tag perforce_cleanup perforce_treerev
		perforce_treediff perforce_verbose perforce_dump
                perforce_cleanup
               );

@EXPORT_OK = qw();
$VERSION   = 1.10;

use lib qw(/home/builds/scripts);
use build;
use Cwd;

my $p4 = where('p4');
my $perforce_verbose = 0;

#####################################################################

sub perforce_status { }

sub perforce_log { }

#####################################################
###
###

sub perforce_env { 

   my $lref = shift; # this should be a specific piece, or top
                     # level. 

   # we've done the perforce stuff already, client spec is ready
   # for use. just set the env vars and return.
   if (defined ($lref->{'_P4CHECKED'}) ) {
      set_env_vars($lref);
      return 1;
   }

   # otherwise, continue on and setup our client spec.

   if (defined ($lref->{'_P4CLIENT'}) ) {

      ### This is the one item we can eval, for dynamic client specs. 
      ### This effectively nulls any use of caching, however. Only use
      ### this feature if you are not setting P4ROOT (template cache)

      my $clt = $lref->{'_P4CLIENT'};
      eval " \$clt = \"$clt\" ";
      $lref->{'_P4CLIENT'} = $clt; # and continue as normal.  

      $lref->{'_P4CLIENT'} = $lref->{'_P4CLIENT'} . "-" .
                             $lref->{'_P4TEMPLATE'};
   }

   my $template    = $lref->{'_P4TEMPLATE'};
   my $destdir;

   ### If P4ROOT is defined somewhere, then we're probably trying
   ### to take advantage of caching. 

   if (defined ($lref->{'_P4ROOT'})) {
      $destdir     = $lref->{'_P4ROOT'} . '/' . $lref->{'_P4TEMPLATE'}
   }
   elsif (defined $ENV{'P4ROOT'}) {
      $destdir     = $ENV{'P4ROOT'} . '/' . $lref->{'_P4TEMPLATE'};
   }
   # no caching? drop to current dir. 
   else {
      $destdir = '.';
   }

   # set this for _co to use to make a decision later. 
   # and to signify that we've done this step. 

   $lref->{'_P4CHECKED'} = $destdir;

   set_env_vars($lref); 

   my $envcmd = "$p4 -d $destdir client -t $template -o | $p4 -d $destdir client -i";

   if ( b_system("$envcmd ") ) {
      print get_stamp() . " +++ Perforce client init failed. $!\n";
      return 0;
   }

   return 1;

}

sub perforce_co { 

   ### string should be a cmd for checking out from a label
   my $string = shift;
   my $redir  = shift || "";
   my $scvar  = shift; 

   # revision at this point should be a label (like anyone in
   # santa monica uses labels ... )
   if (defined $scvar->{'revision'} && $scvar->{'revision'} ne ' ') {
      $revision = "@" . $scvar->{'revision'};
   }
   elsif ( ! defined $scvar->{'revision'} && $string && $string ne ' ') {
      $revision = "@" . $string;
   }
   else {
      $revision = ' ';
   }

   my ($tardir, $curdir) = '';
                                                                                
   if (defined $scvar->{'altdir'} && 
      $scvar->{'_P4CHECKED'} eq '.') {

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

   print get_stamp() . " ### Beginning Perforce checkout from $ENV{'P4PORT'} ". 
                       "$ENV{'P4CLIENT'} \n";

   if ( b_system("$p4 sync $revision $redir") ) {
      print get_stamp() . " +++ Perforce source code sync failed. $!\n";
      if ($tardir) { chdir $curdir; }
      return 0;
   }
   if ($tardir) { chdir $curdir; }

   if ($scvar->{'_P4CHECKED'} ne '.') {

      $fsrc   = $scvar->{'_P4CHECKED'};

      # copy to a subdir/other place or use working dir.
      if (defined ($scvar->{'altdir'})) {
         $altdir = $scvar->{'altdir'};
         b_system("mkdir -p $altdir 2>/dev/null");
      }
      else {
         $altdir = '.';
      }
      print get_stamp() . " Moving code from $fsrc/ to $altdir \n";
      b_system("cp -rp $fsrc/* $altdir");
   }

   return 1;

}

sub perforce_tag { 

   my $labelname = shift;
   my $redir     = shift;
   my $lref      = shift;
   my $template  = $ENV{'P4TEMPLATE'};

   ### Our label description file

   my $labelspec = "/tmp/$labelname.txt";

   if ( -f $labelspec ) {
      unlink($labelspec);
   }

   open (LABEL, ">$labelspec") ||  do {
      print get_stamp() . "Error opening $labelspec for write! $! $?\n";
      return 1;
   };

   select (LABEL); $| = 1;

   print <<EOF;
Label: $labelname
Owner: $ENV{'P4USER'}
Description:
	Created by perforce.pm perforce_label for piece $lref->{'name'}
        Template was $template
        Client was $ENV{'P4CLIENT'}
View:
EOF

   ### Go thru our have list and add files into 
   ### our label spec

   open (HAVE, "$p4 have |") || do {
      print get_stamp() . " Errors running '$p4 have' $! $?\n";
      return 1;
   };

   while (defined ($_ = <HAVE>)) {
      chomp;
      next if (/^$/);
      my ($lhs, $rhs) = split (/#/);
      if ($lhs =~ /.*\s.*/) {
         print "\t\"$lhs\"\n";
      } 
      else {
         print "\t$lhs\n";
      }
   }
   close (HAVE);

   ### Label spec is ready. Create our label

   select (STDOUT);

   if (b_system ("$p4 label -i < $labelspec")) {
      print get_stamp() . " Count not create $labelname from spec $labelspec\n";
      return 0;
   }

   ### Add our file revs to the label

   if (b_system ("$p4 labelsync -l $labelname") ) {
      print get_stamp() . " Count not run '$p4 labelsync -l $labelname'\n";
      return 0;
   }

   unlink($labelspec);

   print get_stamp() . " Successfully created $labelname from $labelspec \n";

   return 1;

}

sub perforce_cleanup {

   my $rev   = shift; # ignored
   my $redir = shift; # ignored (for now?)
   my $lref  = shift;

   ### Assuming that P4CLIENT is our client view, we need to get
   ### rid of it, because there's no real happy way to tell the
   ### server to forget where and what we checked out last time
   ### despite modifying our client view.
  
   # no longer doing this - save p4 clientspec so we can take 
   # advantage of caching. 

   # well, ONLY if we're not using caching. So we rely on our own
   # _P4ROOT setting. If this is set, we're trying to use caching,
   # so we save clientspec. Otherwise, delete it. 

   return 1, if defined ($ENV{'P4ROOT'}) ;

   my $p4view = $ENV{'P4CLIENT'};

   unless ( $p4view ) {
      print get_stamp() . " +++ Perforce P4CLIENT not set!\n";
      return 0;
   }

   if ( b_system("$p4 client -d $p4view") ) {
      print get_stamp() . " +++ Perforce client delete of $p4view failed.\n";
      return 0;
   }

   return 1;

}

sub perforce_treerev { 

   my $logfile = shift;
   my $redir   = shift; # don't care
   my $lref    = shift; 
   
   open(LF, ">>$logfile") || do {
      print get_stamp() . " Cannot open $logfile for treerev write. $!.\n";
      return 0;
   };

   if (defined ($lref->{'name'})) {
      print LF "# M:Perforce N:$lref->{'name'} C:$ENV{'P4CLIENT'}\n";
   }
   
   open(PHAVE, "$p4 have |") || do { 
      print get_stamp() . " +++ Perforce 'have' failed.\n";
      close(LF);
      return 0;
   };

   my ($line, $file, $ver, $revline);

   while ( defined ($line = <PHAVE>) ) {
      ($revline) = $line =~ m/^(.*?#\d+) - /;
      ($file, $ver) = split(/#/,$revline);
      print LF "$file:$ver\n";
   }

   close(PHAVE);
   close(LF);

   return 1;

}

##################################################################
###
### obsoleted
###

sub perforce_treediff {

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

   while(defined ($line = <F2>) ) {
      chomp($line);
      ($file, $rev) = split(':', $line);
      next unless ($file);
      if (defined($oldfiles{$file})) {
         $oldrev = $oldfiles{$file};
         print OF "$file: [$oldrev] vs [$rev]\n" if $perforce_verbose >= 3;
         delete $oldfiles{$file};
         if ($rev cmp $oldrev) {
            $changed{$file} = $rev;
            next;
         }
      }
      else {
         $added{$file} = $rev;
         next;
      }
   }
   close(F2);
   ### output our changes/additions/removals

   my $oldfh =  select(OF);

   print "Files changed:\n-------------\n";
   foreach (sort keys %changed) {
      print "$_:$changed{$_}\n";
      print perforce_getlog($_,$changed{$_}) if $perforce_verbose;
   }

   print "\n";

   print "Files added:\n-------------\n";
   foreach (sort keys %added) {
      print "$_:$added{$_}\n";
      print perforce_getlog($_,$added{$_}) if $perforce_verbose;
   }

   print "\n";

   print "Files removed:\n-------------\n";
   foreach (sort keys %oldfiles) {
      print "$_:$oldfiles{$_}\n";
   }

   close(OF);

   select $oldfh;
   return 1;

}

sub perforce_getlog {

   my $file = shift;
   my $rev  = shift;
   my $mrev = shift; ## optional

   my ($line, $comment);

   unless ( $mrev ) { $mrev = 1; }

   print get_stamp() . " Getting p4 filelog for ${file}#${rev}\n" if 
	$perforce_verbose >=2;

   open (PLOG, "$p4 filelog -l -m $mrev \"${file}#${rev}\" | ") || do {
      print get_stamp() . " [treediff] Unable to open perforce 'filelog' " .
                          "for $file and $rev\n";
      return;
   };

   ### this skips the first line (which is just an echo of $file)

   while (defined ($line = <PLOG>) ) {
      if ($line =~ /^\.\.\./) { 
         $comment .= $line;
         last;
      }
   }

   ### grab the rest of the comment

   while (defined ($line = <PLOG>) ) {
      $comment .= $line;
   }

   $comment .= "\n\n##\n\n";

   close(PLOG); 

   return ($comment);

}


{


sub set_env_vars {

   my $lref = shift;
   my ($var, $val);
   foreach (keys %{$lref}) {
      if ($_ =~ /^_(.*)/) {
         print "Setting $1 in ENV to $lref->{$_};\n" if $perforce_verbose >=3;
         $ENV{$1} = $lref->{$_};
      }
   }
}
                                                                                
                                                                                
}


sub perforce_verbose {

   my $verb = shift;

   $perforce_verbose = $verb;

   return $perforce_verbose;

}

######################################################
###
### all this just to spit out our clientspec into a file.
###


sub perforce_dump {


   my $outfile = shift; # well, not quite.
   my $lref    = shift; 


   if (defined ($lref->{'_P4CLIENT'})) { # could grab it from ENV, 
                                         # but should be same. 

      $client = $lref->{'_P4CLIENT'};
   }
   else { 
      print get_stamp() . " No P4CLIENT found in SCvar. \n";
      return 0;
   }

   ($outfile) = $outfile =~ m#(.*)\..*$#;
 
   unless ($outfile) {
      print get_stamp() . " I wasn't able to trunc $outfile into something" .
                          " to mangle.\n";
      return 0;
   }

   # if this is a fullpath, it should be fine.
   $outfile = $outfile . "-clientspec-" . $client . ".txt";


   open(OUTP,">$outfile") || do { 
      print get_stamp() . " Wasn't able to open $outfile for write. $!\n";
      return 0;
   };

   open(PER, "$p4 client -o | ") || do {
      print get_stamp() . " Wasn't able to pipe $p4 client -o data. $!\n";
      close(OUTP);
   };

   print get_stamp() . " Outputting p4 clientspec to $outfile\n";

   while(<PER>) { print OUTP $_; }
 
   close(PER);
   close(OUTP);

   return 1;

}




1;
