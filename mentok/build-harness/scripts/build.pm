### 
### Build scripts library - move commonly used functions and
### actions into here and abstract them enough to be reused
### by any and all
###

=head1 NAME

build module - commonly used functions throughout our build system

=head1 VERSION

Version 1.50

=head1 SYNOPSIS

This is a module where we've moved a lot of our common functions
out into, so we can re-use and maintain them separately. Our other
main modules, perforce.pm, vcs.pm, cvs.pm use functions from here
extensively. 

=cut

package build;
require Exporter;

@ISA       = qw(Exporter);

@EXPORT    = qw(send_email exit_err get_stamp lock_file send_to_log 
                get_build_date set_status get_status treerev treediff
                wallclock unlock_file lock_age 
	        gmake_errors eat_keep check_for_errors
	        write_keep get_build_date_next b_system dos2unix
                print_S print_V evaluate_hash where run_commands
               );

@EXPORT_OK = qw( get_stamp b_system print_S );
$VERSION   = 1.10;

=head1 REQUIREMENTS

We use the Net::SMTP, POSIX, Fcntl, and Benchmark modules in this
particular module, just to make things easier on us. 

=cut

use Net::SMTP;
use POSIX qw(strftime);
use Fcntl;
use Benchmark;

#################################################################
###
### function to send email in a sane way without relying on poor
### parsing or hardcoded values
###

=head1 FUNCTIONS

=cut

=item B<send_email($server, $sender, $rcpt, $subject, $body>

We use this function to send a email notification of when a build
is done. $server should be an IP or a hostname, port 25 is assumed.
It will try for the connection 3 times, and attempt to send to your
$rcpt list. The mail will be considered sent even if it only goes
to one of your $rcpt list. $rcpt should be a comma separated list
of email addresses. 

=cut

### XXX for some reason i reversed the returns here.

sub send_email {

   my ($server, $sender, $rcpt, $subject, $body) = @_;

   my $tries = 3; my $count = 0; my $smtp;

   while (! ($smtp = Net::SMTP->new($server, Timeout => 60 )) ) {
      $count ++;
      last if ($count >= $tries);
   }
  
   if(! $smtp ) {

      print get_stamp() . " Initial connection failed, attempting debug.\n";
      $count = 0;

      while ( ! ($smtp = Net::SMTP->new($server, Timeout => 60,
                                        Debug   =>  1,
                                        Hello   => 'localhost', ) ) ) {
         $count ++;
         last if ($count >= $tries);
      }
      if (! $smtp ) {
         print get_stamp() . " Unable to connect to $server for mail! $!\n";
         return 0;
      }
   }

   if( ! $smtp->mail($sender) ) {
      print get_stamp() . " Unable to set sender to $sender! $! \n";
      return 0;
   }

   ### rcpt should be a comma delimited list
   $rcpt =~ s/ //g;

   my @rcptlist = split(/,/, $rcpt);

   foreach my $targ (@rcptlist) {

      next unless $targ;

      if( ! $smtp->to($targ) ) {
         print get_stamp() . " Unable to set recipients as $targ! $! \n";
      }
      else {
         $success++;
      }

   } 

   ### If we get one or more right, we'll keep sending
   if( ! $success ) {
       return 0;
   }

   if( ! $smtp->data() ) {
      print get_stamp() . " Unable to enter DATA mode with $server! $! \n";
      return 0;
   }

   if( ! $smtp->datasend("To: $rcpt\nSubject: $subject\n\n$body\n") ) {
      print get_stamp() . " Unable to send body of message! $! \n";
      return 0;
   }

   if(! $smtp->dataend() ) {
      print get_stamp() . " Server did not take message! $! \n";
      return 0;
   } 

   return 1;
}

#####################################################################
###
### exit_err - exit and toss out a final parting word
###

=item B<exit_err($err_code, $err_mesg, $silent)>

This is our final stop on exiting - with a specific error code,
error message, or nothing at all if $silent is set. 

=cut

sub exit_err {

   my ($err_code, $err_mesg, $silent);

   ($err_code, $err_mesg, $silent) = @_;

   ### Stupid Uninitialized Warnings

   $silent   = $silent   || "";
   $err_code = $err_code || 0;
   $err_mesg = $err_mesg || "";

   unless ( $silent ) {
      print STDERR get_stamp() . " [$0] Exiting ($err_code). $err_mesg\n";
   }

   exit $err_code;

}

####################################################################

=item B<lock_file($lockfile, $lockmesg)>

We use this function to drop a lockfile, in a semi-sane sort of way. 
This function checks for the lockfile, creates it, drops $lockmesg
into the file, and returns 1 on success. If we are not able to make
this lockfile, we return 0. 

=cut

sub lock_file {

   my $lockfile = shift;
   my $lockmesg = shift;
   my $locked    = 0;
   my $tries     = 0;
   my $max_tries = 10;

   return 0 if -e $lockfile;

   foreach ($tries .. $max_tries) {
      if ( sysopen(HANDLE, $lockfile, O_WRONLY|O_CREAT|O_EXCL, 0666) ) {
         $locked = 1;
         last;
      }
      else {
         sleep 1;
      }
   }

   if ( ! $lockmesg ) { $lockmesg = ""; }

   if ( $locked ) {
      $lockmesg = "$$ " . localtime(time) . "\n$lockmesg\n";
      syswrite(HANDLE,$lockmesg);
      close(HANDLE);
      return 1;
   }

   return 0;

}

#####################################################################

## return lock age in terms of hours - leave to programmer to decide
## to break lock

=item B<lock_age($lockfile)> 

Return the age, in hours, since the lockfile was created. Leave it
to the programmer if we decide to break the lockfile with unlock_file()

=cut

sub lock_age {

   my $lockfile = shift;
   my @filestat = stat($lockfile);
   my $mtime    = $filestat[9];
   my $curtime  = time(); 
   
   return ( int ( ($curtime - $mtime) / (60 * 60) ) );

}

#####################################################################
###
### craft up a properly formated time string and return it
###

=item B<get_stamp()>

Probably the most called function in our code - it returns a 
'timestamp', prettified, suitable for printing out to our logfiles.
The format is 
 
 [hour:min:sec mon/day/year] 

With "0"'s appropriately padded.

=cut

sub get_stamp {

   my($sec, $min, $hour, $mday, $mon, $year);

   ($sec,$min,$hour,$mday,$mon,$year) = localtime(time());

   ($hour < 10) ? $hour = "0" . $hour : 0;
   ($min < 10)  ? $min  = "0" . $min  : 0;
   ($sec < 10)  ? $sec  = "0" . $sec  : 0;

   $mon++; $year += 1900;

   ($mon  < 10) ? $mon = "0" . $mon : 0;
   ($mday < 10) ? $mday = "0" . $mday : 0;

   return "[$hour:$min:$sec $mon/$mday/$year]";

}

####################################################################
###
### send to named file, using file.lck as the lockfile
###

=item B<send_to_log($data, $file)>

Send $data to a $file, using our existing locking mechanism to
hopefully not stomp on anything else that might be getting sent
there. Returns 1 on success, 0 otherwise.

=cut

sub send_to_log {

   my $data      = shift;
   my $file      = shift; 

   if ( ! lock_file("$file.lck") ) { 
      print STDERR "Unable to lock $file.lck file!\n";
      return 0;
   }

   open(FILE, ">>$file") || do  {
      print STDERR "Unable to open up $file for append! $!\n";
      return 0;
   };

   my $tstamp = get_stamp();

   print FILE "$tstamp $data\n";

   close(FILE);

   unlock_file("$file.lck");

   return 1;

}

####################################################################

=item B<unlock_file($lockfile)>

Forcibly remove the lockfile, if it exists. Returns 1 on success
or if the logfile does not exist. 0 otherwise.

=cut

sub unlock_file {

   my $lockfile = shift;
   if ( -f "$lockfile" ) {
      unless ( unlink($lockfile) ) {
         print get_stamp() . " Unable to remove old lockfile $lockfile. $!\n";
         return 0;
      }
      return 1;
   }

   print get_stamp() . " Lockfile, $lockfile does not exist! Return success.\n";
 
   return 1;
   
} 

####################################################################
### 
### quicky to return a proper build date, letting strftime do
### the work
###


sub get_build_date {

   my $today = strftime "%Y-%m-%d", localtime;

   return $today;

}

##################################################################
###
### diff between trees using the output from treerev
###

### vcs will only work well with the new SCvar / stuff, it won't
### function well on files to treediff that require anything other
### than just raw file compares. 

sub treediff {

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

   unless ($outfile eq 'STDOUT') {
      open(OF, ">$outfile") || do {
         print get_stamp() . " [treediff] Unable to open $outfile! $!\n";
         return 0;
      };
   }

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

   while(defined ($line = <F2>) ) {
      chomp($line);
      next if ($line =~ /^#/);
      ($file, $rev) = split(':', $line);
      next unless ($file);
      if (defined($oldfiles{$file})) {
         $oldrev = $oldfiles{$file};
#         print OF "$file: [$oldrev] vs [$rev]\n" if $verbose;
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

   unless ($outfile = 'STDOUT') { my $oldfh =  select(OF); }

   print "Files changed:\n-------------\n";
   foreach (sort keys %changed) {
      print "$_:$changed{$_}\n";
   }

   print "\n";

   print "Files added:\n-------------\n";
   foreach (sort keys %added) {
      print "$_:$added{$_}\n";
   }

   print "\n";

   print "Files removed:\n-------------\n";
   foreach (sort keys %oldfiles) {
      print "$_:$oldfiles{$_}\n";
   }

   unless ($outfile = 'STDOUT') { close(OF); select $oldfh; }
   return 1;

}

###########################################################
###
### set the status.
###

=item B<set_status($statusvar, $status)>

This function just writes out to a file a hash of information.
It requires a '$statusdir' to be defined in the $statusvar, and will 
write to a status file of '$statusdir/$host_$ddir'. We use this in 
runbuild so the child builds can write to their own status files and keep
track of how they are doing (or we can debug where they died).
Pass in $status to simply change the status and write out any other
changes that may have happened to $statusvar (a hash reference). 
Valid fields currently include :

 host
 arch
 ddir
 tagname
 statusdir
 logs
 report
 package
 user
 result
 ebid
 code_time
 total_build

=cut

sub set_status {

   my ($statusvar) = shift;
   my ($status)    = shift;

   my $host        = $statusvar->{'host'}        || '';
   my $arch        = $statusvar->{'arch'}        || '';
   my $ddir        = $statusvar->{'ddir'}        || '';
   my $tagname     = $statusvar->{'tagname'}     || '';
   my $statusdir   = $statusvar->{'statusdir'}   || '';
   my $logs        = $statusvar->{'logs'}        || '';
   my $report      = $statusvar->{'report'}      || '';
   my $package     = $statusvar->{'package'}     || '';
   my $user        = $statusvar->{'user'}        || '';
   my $result      = $statusvar->{'result'}      || '';
   my $ebid        = $statusvar->{'ebid'}        || '';
   my $code_time   = $statusvar->{'code_time'}   || '';
   my $total_build = $statusvar->{'total_build'} || '';

   ## Make statusdir

   if (! $statusdir ) {
      print get_stamp() . " [set_status] Statusdir is not defined!\n";
      return 0;
   }

   if (! -d $statusdir ) {
      unless ( mkdir ("$statusdir", 0777) ) {
         print get_stamp() . " [set_status] Unable to create $statusdir! $!\n";
         return 0;
      }
   }

   my $sfile = "$statusdir/$host" . '_' . $ddir;

   open(SFILE, ">$sfile") || do {
      print get_stamp() . " [set_status] Can't open $sfile to write status\n";
      return 0;
   };

   print SFILE "status: $status\n";
   print SFILE "host: $host\n";
   print SFILE "date: $ddir\n";
   print SFILE "arch: $arch\n";
   print SFILE "user: $user\n";

   if ( $ebid ) {
      print SFILE "ebid: $ebid\n";
   }

   if ( $logs ) {
      print SFILE "logs: $logs\n";
   }

   if ( $report ) {
      print SFILE "report: $report\n";
   }
   
   if ( $tagname ) {
      print SFILE "tag: $tagname\n";
   }
  
   if ( $package ) {
      print SFILE "package: $package\n";
   } 

   if ( $result ) {
      print SFILE "result: $result\n";
   } 

   if ( $code_time ) {
      print SFILE "code_time: $code_time\n";
   } 

   if ( $total_build ) {
      print SFILE "total_build: $total_build\n";
   } 

   close(SFILE);
  
   return 1;
}

#######################################################
###
### return the status of a client from the statusdir/
### $host_$ddir file
###

=item B<get_status($statusvar)>

This returns the current status from a statusfile (found in
$statusdir/$host_$ddir) and returns it or 'undef' if it is
not found.

=cut

sub get_status {

   my ($statusvar) = shift;

   my ($host)      = $statusvar->{'host'};
   my ($ddir)      = $statusvar->{'ddir'};
   my ($statusdir) = $statusvar->{'statusdir'};

   my $sfile = "$statusdir/$host" . '_' . $ddir;

   open(SFILE, "<$sfile") || do {
      print get_stamp() . " [get_status] Unable to open $sfile for read\n";
      return 0;
   };

   while(<SFILE>) {
       if (/^status: (.*)/) {
          close(SFILE);
 	  return $1;
       }
   }

   close(SFILE);

   return 'undef';

}

#########################################################
###
### return just the seconds (wallclock) from a timestr
### and timediff
###

=item B<wallclock($t1, $t0)>

Given 2 Benchmark items ( $t0 = new Benchmark; $t1 = new Benchmark; )
we want to return the difference in a readable, pretty format. We use
this for timing how long certain actions take to complete. It will 
return a string in a 

 XX hour(s) XX minute(s) XX second(s) 

format

=cut

sub wallclock { 

   my $t1 = shift;
   my $t0 = shift;

   my $str = timestr(timediff($t1, $t0));

   my ($secs, $hours, $mins) = ""; my $pretty;

   ($secs) = $str =~ /(\S+) wallclock/;

   if ( ( $secs == 0 ) || ($secs) ) {

      if ($secs > 60) {
         $mins   = int ($secs / 60);
         $secs   = $secs - ($mins * 60);
         $pretty = "$mins minute"      . ($mins > 1 ? "s" : "") .
                   " and $secs second" . ($secs > 1 ? "s" : "");
      } 

      else { 
         $pretty = "$secs second" . ($secs > 1 ? "s" : "");
      }

      if ($mins && ( $mins > 60 ) ) {
         $hours  = int ($mins / 60);
         $mins   = $mins - ($hours * 60);
         $pretty = "$hours hour"    . ($hours > 1 ? "s" : "") .
                   ", $mins minute" . ($mins  > 1 ? "s" : "") .
                   ", $secs second" . ($secs  > 1 ? "s" : "");
      } 

      return ($pretty);
   }

   return $str;

} 

##########################################################
###
### gmake_errors 
### move the simple logic of just scanning for a [g|m]ake 
### error into here.
###

=item B<gmake_errors($file)>

This is a simple function to look for 

 'Error \d+' 

or a 

 [gmake|make].*Stop\. 

pattern, which indicates that gmake or make has decided that it
no longer wishes to contiune. Returns the number of errors found.

=cut

sub gmake_errors {

   my $file = shift;

   my $line; my $err = 0;
   my $make_pat = qr/[gmake|make]/;


   open(FILE, "<$file") || do {
      print get_stamp() . " Unable to open $file for parse. $!.\n";
      return;
   };

   while(defined ($line = <FILE>)) {
      if ( ($line =~ m#Error \d+#) || ($line =~ m#$make_pat.*Stop\.# ) ) {
         $err++;
      }
   }

   close(FILE);

   return $err;

}

=item B<eat_keep($file)>

This will 'eat' a .keep file, which we typically use to tag or name
our builds with a bit of info so they don't get 'pruned' (deleted) by
our auto-pruning scripts. Valid fields in this .keep file, are 1 entry
per line of the following:

 state: <state>
 name: <name>
 owner: <owner>
 date: <date>

The return value is an array of '$state, $name, $owner, $date'.

=cut

sub eat_keep {

   my ($file) = shift;
   my ($state,$name,$owner,$date,$line);
   open (FILE, "$file") || do {
      return 0;
   };

   $state='keep';

   while(defined ($line = <FILE>) ) {

      chomp($line); next unless $line;

      if ($line =~    /^state: (.+)/) {
         $state = $1;
      }
      elsif ($line =~ /^name: (.+)/) {
         $name = $1;
      }
      elsif ($line =~ /^owner: (.+)/) {
         $owner = $1;
      }
      elsif ($line =~ /^date: (.+)/) {
         $date = $1;
      }

  }

  close(FILE);

  return ($state, $name, $owner, $date);

}

### write_keep needs the mkkeep shell script - install
### later.

sub write_keep { 

   my $path = shift; 
   $file = "$path/.keep";

   open(KEEP, ">$file" ) || do { 
      print get_stamp() . " Unable to touch $file into place!\n";
      return 0;
   };
   close(KEEP);

   ### XXX chown and chmod for web system to manipulate

}



=item B<get_build_date_name($ddir,$dir)>

Taking a raw $ddir value (YYYY-MM-DD) we then iterate and look for the
first available build dir that is not used, of form (YYYY-MM-DD_XX) in
the directory $dir. Revs less than 10 are padded. 

=cut

sub get_build_date_next {

   my $ddir = shift;
   my $dir  = shift;

   my @files;
   my $file;
   my $highest = "00";

   opendir(DIR, "$dir") || do {
      return 0;
   };

   @files = readdir DIR;

   closedir(DIR);

   foreach $file (@files) {
      if ($file =~ /^${ddir}_(\d+)/) {
         if ($1 > $highest) {
            $highest = $1;
         }
      }
   }

   $highest++;

   if ( ($highest < 10) && ($highest !~ /^0/) ) {
      $highest = "0" . $highest;
   }

   return ($ddir . "_" . $highest)

}

#####################################################
###
### We're going to wrap system calls a little tighter
### in order to insure more accurate error grabbing, etc.
###

=item B<b_system(@args)>

Another popular function, we use this before calling out to 'system'
so we can trap for error codes and see exactly what we're running in
our logfiles. Returns the error code of whatever the system call
produced.

=cut

sub b_system {

   my @args = @_;

   print get_stamp() . " ___ running " . join (' ', @args) . "\n";

   my $rc   = system(@args);
   my $a_rc = $rc >> 8;

   if ($a_rc != 0) {
      print get_stamp() . " System call failed. Exit_val: [$a_rc]\n";
   }

   return $a_rc;

} 

######################################################
###
### check_for_errors
###
### Take a log file and a reference to an array
### with some fail criteria and return reference to 
### a hash with errors if errors are found and 
### 0 if not.
###

=item B<check_for_errors($file, $fail_criteria)>

This is a more generic 'search for failure' function. $file is the
logfile to parse through, $fail_criteria is actually an array ref,
where each pattern or string to match is a single element of the
array. 

 check_for_errors ("$out_file", \@fail_criteria);

Where @fail_criteria is something like:

 @fail_criteria = (
      "FAILED: [1-9]+",
      "Errors: [1-9]+",
      "BUILD FAILED",
 );

The return is a hash of error messages, keyed in order
numerically. If no errors are found, 0 is returned.

=cut

sub check_for_errors {

   my $file            = shift;
   my $fail_criteria   = shift;   

   my $lines           = 25;
   my $pattern         = join ('|', @{$fail_criteria});

   my $errors          = 0;
   my $count           = 0;
   my $buff            = '';

   my %error_msgs      = ();

   open (LOG, "<$file") || do {
      print get_stamp () . " Could not open $file \n";
      return 0;
   };

   while (defined ($_ = <LOG>)) {
      if (/$pattern/) { ## error detected
         $buff .= $_;
         $error_msgs{++$errors} = "$buff";
      } 
      else {
         if ($count > $lines) {
            $buff = '';
            $count = 0;
         } 
         else {
            $buff .= "$_";
            $count ++;
         }
      }
   }

   close (LOG);

   if ($errors) {
      return \%error_msgs ;
   } 

   return 0; 

}

################################################################
###
### dos2unix
### Takes an input file, converts it to unix format
### (i.e remove ^Ms)
###


=item B<dos2unix($file)>

This uses /bin/dos2unix to convert a file from $file to $file.UNIX and
then move that file into place as the original $file. Returns 1 on
success, 0 otherwise.

=cut

sub dos2unix {
   
   my $file 		= shift;
   my $dos2unix		= where("dos2unix");

   if (! $file || ! -f $file) {
      print get_stamp () . " dos2unix: Input file not specified" .
                           " or does not exist!\n";
      return (0);
   }

   if (! -x "$dos2unix") { 
      print get_stamp() . " dos2unix does not found\n";
      return 0;
   }

   if (b_system ("$dos2unix $file > $file.UNIX")) {
      print get_stamp () . " dos2unix: $dos2unix returned error.\n";
      return (0);
   }   

   unless ( rename("$file.UNIX", "$file")) {
      print get_stamp () . " dos2unix: rename $file.UNIX $file error.\n";
      return (0);
   }

   return (1);

}

sub print_S {

   my $arg;
 
   while (@_) { $arg .= shift; }

   chomp($arg);

   print get_stamp() . " $arg" . "\n";

   return 0;

}

### defaults, config, smush these together into run, taking
### run over config over defaults

sub evaluate_hash {

   my $def_ref = shift;
   my $con_ref = shift;
   my $run_ref = shift; 

   my %lrun; 

   foreach my $key (sort keys %{$def_ref}) {
      $lrun{$key} = $def_ref->{$key};
   }

   foreach $key ( sort keys %{$con_ref}) {
      $lrun{$key} = $con_ref->{$key};
   }

   foreach $key ( sort keys %{$run_ref}) {
      if ( defined ($run_ref{$key}) && $run_ref{$key} ) {
         $lrun{$key} = $run_ref->{$key};
      }
   }

   foreach $key ( sort keys %lrun ) {
      $run_ref->{$key} = $lrun{$key};
   }

   return 0;   

}

### # client_build_sequence

# RUNDIR|USER|COMMAND|ARGS|TARGETS|IGNOREERROR|ENVS|ARBLOGFILE|FAIL_REF

#
# @client_build_sequence = ( [ "","", "$gmake", "-f Makefile.build", "", "", "", "", ], );
#

### XXX clean this up

sub run_commands {

   my $run_ref = shift;
   my $ar_ref  = shift; 

   ### fail criteria array
   my $fail_ref = shift; 

   ### more of a prefix of a name to uniquely set off log files
   my $postfix = shift || ''; 

   my ($run_dir, $eff_user, $command, $args, $target,
       $out_err, $cline, $bs_cline, $out_file, $command_basename);
    
   my ($starttime, $endtime);

   my ($set_status, $sref);
   
   my $host     = $run_ref->{'host'} || '';
   my $makeargs = $run_ref->{'makeargs'};
   my $logdir   = $run_ref->{'logdir'};

   if (defined ($run_ref->{'statusref'})) { 
      $set_status = 1;
      $sref = $run_ref->{'statusref'};
   }

   if ( ! $logdir ) {
      print_S "Logdir is not defined - needs to be set!\n";
      return 1;
   }
    
   print_S "[$host] Current directory is "; print Cwd::getcwd() . "\n";

   my $iter = "00";

   foreach ( @{$ar_ref} ) {

      my $stored_command = $_;

      $run_dir = $eff_user = $command = $args = $target = $ignore_errors = 
         $check = $out_err = $cline = $bs_cline = $out_file = 
	 $command_basename = "";
   
      # Directory where command will run
      if ($stored_command->[0]) {
         $run_dir = "$stored_command->[0]";
         eval " \$run_dir = \"$run_dir\" ";
      }

      # Effective user of the command (sudo)
      if ($stored_command->[1]) { 
         $eff_user = $stored_command->[1]; 
         eval " \$eff_user = \"$eff_user\" ";
      }
   
      # Command name
      if ($stored_command->[2]) {
         $command = $stored_command->[2];
         eval " \$command = \"$command\" ";
      } 
      else { # this is an impossible situation to deal with
         print get_stamp () . "Build System: FATAL: Stored command missing \n";
         return 1;
      }
   
      # Command arguements
      if ($stored_command->[3]) {
         if ($command =~ /make/) {
            if ($makeargs) {
               $args = "$makeargs $stored_command->[3]";
            } else { $args = "$makeargs $stored_command->[3]"; }
         } else { $args = $stored_command->[3]; }
         eval " \$args = \"$args\" ";
      } else { $args = "$makeargs" if ($command =~ /make/); }
   
      # Any targets (make style)
      if ($stored_command->[4]) {
         $target = $stored_command->[4];
         eval " \$target = \"$target\" ";
      }

      # ignore errors bit
      if (defined ( $stored_command->[5] ) ) {
         $ignore_errors = $stored_command->[5];
      }

      # Dynamic ENV variables, set these before running cmd
      # Expect 'VAR=baz:bar|VAR=foo|VAR=xyzzy' input
      if ($stored_command->[6]) {
         @envs = split(/\|/, $stored_command->[6]);
         foreach $ea (@envs) {
            ($e,$a) = split(/=/,$ea);
            eval " \$a = \"$a\" ";
            $ENV{$e} = $a;
         }
      }
 
      # arbitrary log file, use this for logfile name.
      if ($stored_command->[7]) {
         $logf = $stored_command->[7];
         eval " \$logf = \"$logf\" ";
         $out_file = $logdir . "/" . $iter . "_" . $postfix . "_" . $logf;
      }
      else {
         ($command_basename) = $command =~ /^(\S+)/;
         chomp ($command_basename = `basename $command_basename`);
 
         if ($target) {
            my $buff = $target; $buff =~ s#/#_#g;
            $out_file = $logdir . "/" . $iter . "_" . $postfix . "_" . 
			$command_basename . "_" .  $buff . ".txt";
         }
         else {
            $out_file  = $logdir . "/" . $iter . "_" . $postfix . "_" . 
			$command_basename . "_" . ".txt";
         }
      }
   
      $out_err = " > $out_file " . "2>\&1";

      $cline = "$eff_user $command $args $target";

      eval " \$cline = \"$cline\" ";
   
      $bs_cline = "$cline $out_err";
   
      set_status($sref, "running $command $target") if $set_status;
   
      $starttime = new Benchmark;

      my $run_cwd = Cwd::getcwd();

      if ($run_dir) {
         print get_stamp () . " [$host] Run dir specified as $run_dir \n";
         unless (chdir ("$run_dir")) {
            print_S  "[$host] : Could not chdir to $run_dir \n";
            print get_stamp() . " [$host] Currently in " . Cwd::getcwd() . "\n";
            return 1;
         } 
         else { 
           print get_stamp() . " [$host] Currently in " . Cwd::getcwd() . "\n";
         }
      }

      if ( $check = b_system ("$bs_cline") ){
         print get_stamp () . " [$host] command failed.\n";
         if ($ignore_errors) { 
            print get_stamp() . " [$host] Ignore error set, continuing.\n";
         }
      }
   
      $endtime = new Benchmark;

      $buildtime = wallclock($endtime, $starttime);
   
      print_S  "[$host] $command $target finished. [$buildtime] [RC: $check]\n";

      # If product config specifies a fail_criteria, check the log file
      # for errors. If we find errors in the log files, we stop right here.

      if ( $check && defined ($fail_ref) && @{$fail_ref}) {
         my $errors = check_for_errors ("$out_file", $fail_ref); 
         if ($errors) {
            print get_stamp () . " WARNING: Errors detected in $out_file. \n";
            foreach my $k (keys %{$errors}) {
               print "++++++++++ ERROR $k ++++++++++ \n\n";
               print "$errors->{$k} \n";
            }
            print get_stamp () . " ERRORS DETECTED IN BUILD LOG \n";
#            b_system ("/bin/touch $buildroot/$ddir/$host/ERRORS ");
#            foreach $fc (@fail_criteria) { 
#               ### XXX Redo this into perl
#	       b_system ("/bin/grep -n '$fc' $out_file >> $buildroot/$ddir/$host/ERRORS "); 
#            }
         }
      }
      elsif ($check) { # errors, but no @fail_criteria 
         print_S "*** Warning: Not checking for errors in log file.\n";
      }

      unless (chdir ("$run_cwd")) {
         print get_stamp () . " [$host] Could not chdir back to $run_cwd.\n";
         return 1;
      }

      if ( $check ) { # error checking set, error encountered, do not ignore
         return 1;
      }
   
   # Record command run time in our buildtrack hash
   ### XXX $buildtrack{$buildseq++} = ["$eff_user $command $args $target", "$buildtime"];
   
   set_status($sref, "finished $command $target") if $set_status;

   $iter++;

   }

   return 0;

}

sub where {

   $targ = shift;

   my $found = 0;

   if ( ! -x $targ ) {
      my @paths = split(/:/,$ENV{'PATH'});
      foreach (@paths) {
         if ( -x "$_/$targ" ) {
            return ("$_/$targ");
         }
      }
   }
   else { return $targ; }

   return 0;

}


1;
