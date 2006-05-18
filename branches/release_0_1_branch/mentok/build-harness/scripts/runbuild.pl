#!/usr/local/bin/perl -w

######################################################

use lib qw(/home/builds/scripts);
use Getopt::Long;
use Benchmark;
use build;
use Cwd;

######################################################

$| = 1;

######################################################
###
### Source Defaults.pl 
###
######################################################

my $reqdir      = "/home/builds/config";
my $master_lock = "/home/builds/master.lck";

#############################################################
###
### Check if there is a master lock file
###
#############################################################
                                                                                                                                                            
if ( -f "$master_lock" ) {
   print get_stamp () . " Detected Build System Lock File\n";
   print get_stamp () . " This may happen do to scheduled maintenance. \n";
   print get_stamp () . " Contact RWC CM Team. \n";
   print get_stamp () . " To unlock, remove the file $master_lock \n";
   exit_err (1, "Build System Locked");
}

eval {
   require "$reqdir/Defaults.pl";
};

if ( $@ ) {
   print get_stamp() . " Error sourcing in defaults. \n";
   exit_err(1);
}

use vars qw($notify $platinfo $hostname);

### setup junk we need

my $builddate = scalar localtime(time());

### initialize states
my $error         = 0;
my $buildstatus   = 'skipped';
my $buildtime     = 'N/A';

my %buildtrack    = ();
my $buildseq      = 1;
my $user          = "";
$cvstag	  = "";
$ddir     = '';
$dodist	  = '';

my $packagestatus = 'skipped';

my ($tagname, $bomb, $strip, $debug, $disttag, $variant);
my ($special_gmake_args, $hostforce);

$tagname = $bomb = $strip = $debug = $disttag = $variant =
 $special_gmake_args = $hostforce = '';

GetOptions(
           "config=s"             => \$config,
           "r=s"                  => \$tagname,
           "ddir=s"               => \$ddir,
           "cvstag=s"		  => \$cvstag,
           "dist+"                => \$dodist,
           "bomb=s"               => \$bomb,
           "strip=s"              => \$strip,
           "debug=s"              => \$debug,
           "user=s"               => \$user,
           "DISTTAG=s"            => \$disttag,
	   "VARIANT=s"		  => \$variant,
           "special_gmake_args=s" => \$special_gmake_args,
           "host=s"               => \$hostforce,
          );

#############################################################
### Now we get our product defaults #########################
#############################################################

$user = $user || $ENV{'USER'} || "release";

unless ($config) {
   print get_stamp() . " Configfile not specified!\n";
   exit_err(1);
}

print get_stamp() . " Sourcing in configuration for project.\n\n";

eval { require "$config"; };

if ( $@ ) {
   print get_stamp() . " Error sourcing in $config values. $!.\n";
   exit_err(1);
}

#############################################################
### Double check to make sure things are defined ############
#############################################################

if ( (! $buildroot ) || (! $ddir ) || (! $projectname ) ) { 
   exit_err(1, "Don't run me directly! Use buildall whenever possible!\n");
}

### some product configs now refer to variables that
### we define here, so this is needed.

if (defined ($statusdir) ) {
   eval " \$statusdir = \"$statusdir\" ";
}
if (defined ($startdir) ) {
   eval " \$startdir = \"$startdir\" ";
}

if (defined ($hostforce) && $hostforce) {
   $host = $hostforce; # override the `hostname` call from configfile.
}

$statusdir = $statusdir || "$buildroot/status";
$tagname   = $tagname   || '';

#############################################################
### Lockfile ################################################
#############################################################

my $lockfile = "$buildroot/$host.lck";

#############################################################
### Construct last build file ###############################
#############################################################

my $lbuild;

if ( defined ( $tagname )  && $tagname ) {
   $lbuild = "$buildroot/lastbuild-" . $tagname;
} 
else {
   $lbuild = "$buildroot/lastbuild";
}

#############################################################
### Setup our directories and log files #####################
#############################################################

unless ( -d "$buildroot" ) {
   if ( b_system("$mkdir $buildroot") ) {
      exit_err(1, "Can't create $buildroot! $!");
   }
}

unless ( chdir ($buildroot) ) {
   exit_err(1, "Unable to chdir to $buildroot! $!");
}
     
if ( (! $ddir ) || (! -d $ddir ) ) {
   exit_err(1, "Either datedir was not defined or does not exist!");
}

#############################################################
### Logs ####################################################
### Moved down, since they depend on what $ddir is. #########
#############################################################

my $basedir     = "$buildroot/$ddir/$host";
my $logdir      = "$basedir/logs";

my $runlog      = "$logdir/runbuildlog.txt";
my $hostlog     = "$logdir/buildhostinfo.txt";
my $revlog      = "$logdir/revlog.txt";
my $difflog     = "$logdir/difflog.txt";
my $prelog      = "$logdir/precmdlog.txt";

my $gdistlog    = "$logdir/distlog.txt";

my $breportlog  = "$logdir/buildreport.txt";

##############################################################
### Time to get into our dir. ################################
### /product/build_id/host
##############################################################

print get_stamp() . " [$host] Getting into $basedir \n\n";

unless ( chdir($basedir) ) {
   exit_err(1, "Unable to chdir to $basedir! $!");
}

print get_stamp() . " [$host] Setting up logfiles. \n\n";

unless ( -d 'logs' ) {
   if ( b_system("$mkdir logs") ) {
      exit_err(1, "Unable to make dir 'logs'! $!");
   }
}

unless ( -d "$statusdir" ) {
   if ( b_system("$mkdir $statusdir") ) {
      exit_err(1, "Unable to mkdir $statusdir! $!");
   }
} 

##############################################################
### Redirect all output to the build logs. ###################
##############################################################

print get_stamp() . " [$host] Redirecting to my log files.\n\n";

open(STDOUT, ">$runlog") || do {
    print "Could not redirect STDOUT to $logdir/runbuildlog.txt: $!\n";
};

open(STDERR, ">&STDOUT") ||  do {
    print "Could not redirect STDERR to $logdir/runbuildlog.txt: $!\n";
};

##############################################################
### make STDOUT/STDERR autoflush ##############################
##############################################################

select((select(STDERR), $| = 1)[0]);
select((select(STDOUT), $| = 1)[0]);

print get_stamp() . " [$host] runbuild log opened.\n\n";

print <<EOF;
                                                                                
Debug Output Follows :
                                                                                
config			: $config
r			: $tagname
ddir			: $ddir
cvstag			: $cvstag
dist			: $dodist
bomb			: $bomb
strip			: $strip
debug			: $debug
user			: $user
DISTTAG 		: $disttag
VARIANT 		: $variant
special_gmake_args      : $special_gmake_args
host 			: $hostforce 

EOF

##############################################################
### create the status hash for passing to [set|get]_status ####
##############################################################

my %statusvar = ( 'host'      => $host, 
                  'statusdir' => $statusdir,
                  'ddir'      => $ddir,
                  'arch'      => $arch,
                  'user'      => $user,
                );

##############################################################
### Check for machine-specific lockfile ######################
##############################################################

unless ( lock_file($lockfile) ) {

   unless (lock_age($lockfile) > 2) {
      set_status(\%statusvar, "failed: already running - lockfile present");
      exit_err(1, "Already running on $hostname or stale lockfile ($lockfile)");
   }
   else {
      print get_stamp() . " Lockfile age exceeds 2 hours - proceeding.\n";
      unlock_file($lockfile);
      if ( ! lock_file($lockfile) ) {
         set_status(\%statusvar, "failed: unable to relock lockfile");
         exit_err(1, "Cannot lock my lockfile ($lockfile)");
      }
   }
}

###############################################################
### HERE WE GO ################################################
###############################################################

###############################################################
### Copy difflog and revlog from ddir to logs/
###############################################################

if ( -f "$buildroot/$ddir/revlog-${ddir}.txt" ) {
   b_system ("cp $buildroot/$ddir/revlog-${ddir}.txt $revlog");
}

if ( -f "$buildroot/$ddir/difflog-${ddir}.txt" ) {
   b_system ("cp $buildroot/$ddir/difflog-${ddir}.txt $difflog");
}

###############################################################
### examine/save machine config ###############################
###############################################################

print get_stamp() . " [$host] Examining build host configuration.\n\n";

if ( b_system("$platinfo 1>$hostlog 2>&1") ) {
   print get_stamp() . " Errors running build host config script. \n";
}

################################################################
### run the build ##############################################
# Change in strategy our code will be checked out into
##############################################################

print get_stamp() . " [$host] Building $projectname\n\n";

my $cwd  = Cwd::getcwd ();

if ($startdir) {
   print get_stamp() . " [$host] Start dir defined as $startdir \n";
   print get_stamp() . " [$host] Starting in $startdir \n";
   if ( ! chdir($startdir) ) {
      cleanup_and_exit(2, "Unable to chdir to $startdir! $!\n");
   }
} else {
   if (! chdir ("src")) {  # start dir is not defined, try src
      print get_stamp () . " Unable to chdir to src (hardcoded) \n";
      print get_stamp () . " Will try \".\" \n";  
      $startdir = ".";
   } else { print get_stamp () . " [$host] Starting in " .  Cwd::getcwd() . "\n"; }
}
      

$buildstatus = 'failed';
$error       = 0;


###############################################################
### gmake #####################################################
### We still need this to support CLI
### Special arg processing based on CLI
###############################################################

my $makeargs = "";

if ($bomb && $bomb eq "ON")      { $makeargs  = "BOMB=1"; }
elsif($bomb && $bomb eq "OFF")   { $makeargs  = "BOMB=0"; }

if ($debug && $debug eq "ON")    { $makeargs .= " DEBUG=1"; }
elsif($debug && $debug eq "OFF") { $makeargs .= " DEBUG=0"; }

if ($strip && $strip eq "ON" )   { $makeargs .= " STRIP=1"; }
elsif($strip && $strip eq "OFF") { $makeargs .= " STRIP=0"; }

if ($special_gmake_args)         { $makeargs .= " $special_gmake_args"; }
if ($config_gmake_args)          { $makeargs .= " $config_gmake_args"; }
if ($variant)			 { $makeargs .= " VARIANT=$variant"; }

print get_stamp () . " [$host] make args are : $makeargs \n";

###############################################################
### This is where we actually o thru the client_build_sequence
### and run each command listed in it (Defaults.pl/product.pl)
###############################################################

set_status(\%statusvar, 'building');

if (! @client_build_sequence) {
   print get_stamp () . " [$host] Client Command Sequence not found \n";
   cleanup_and_exit (1);
}

my ($run_dir, $eff_user, $command, $args, $target,
    $out_err, $cline, $bs_cline, $out_file, $command_basename);
    
my ($starttime, $endtime, $ruletime, $disttime);

my $depth = 0;
my @subs = ();
    
print get_stamp () . " [$host] Current directory is " . Cwd::getcwd () . "\n";

my $iter = "00";

foreach (@client_build_sequence) {

   my $stored_command = $_;
   $run_dir = $eff_user = $command = $args = $target = $ignore_errors = 
      $out_err = $cline = $bs_cline = $out_file = $command_basename = "";
   
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
   } else { # this is an impossible situation to deal with
      print get_stamp () . "Build System: FATAL: Stored command missing \n";
      cleanup_and_exit (1);
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
      $out_file = $logdir . "/" . $iter . "_" . $logf;
   }
   else {
      ($command_basename) = $command =~ /^(\S+)/;
      chomp ($command_basename = `basename $command_basename`);
 
      if ($target) {
         my $buff = $target; $buff =~ s#/#_#g;
         $out_file = $logdir . "/" . $iter . "_" . $command_basename . "_" .
                $buff . ".txt";
      }
      else {
         $out_file  = $logdir . "/" . $iter . "_" . $command_basename . "_" . ".txt";
      }
   }

   if ($target =~ /package/) {
      $packagestatus = 'starting';
   }
   
   $out_err = " > $out_file " . "2>\&1";

   $cline = "$eff_user $command $args $target";

   eval " \$cline = \"$cline\" ";
   
   $bs_cline = "$cline $out_err";
   
   set_status(\%statusvar, "running $command $target");
   
   $starttime = new Benchmark;

   # If a dir was specified for the command, 
   # count the depth and cd to the dir before 
   # running our command 

   my $run_cwd = Cwd::getcwd ();

   if ($run_dir) {
      print get_stamp () . " [$host] Run dir specified as $run_dir \n";
      if (! ($run_dir =~ m#^/#) ) {
         @subs = split (/\//, $run_dir);
         $depth = scalar(@subs);
         $run_dir = "./$run_dir";
      }
      unless (chdir ("$run_dir")) {
         print get_stamp() . " [$host] : Could not chdir to $run_dir \n";
         print get_stamp() . " [$host] Currently in " . Cwd::getcwd() . "\n";
         cleanup_and_exit (1);
      } else { 
        print get_stamp() . " [$host] Going $depth level(s) to $run_dir \n"; 
        print get_stamp() . " [$host] Currently in " . Cwd::getcwd() . "\n";
      }
   }

   
   if (b_system ("$bs_cline") ){
      print get_stamp () . " [$host] $bs_cline failed.\n";
      if ($ignore_errors) { 
         print get_stamp() . " [$host] Ignore error set, continuing.\n";
      }
      if ( (! $ignore_errors)  && $command_basename ne "makeInstall.sh") {
         cleanup_and_exit (1);
      }
   }
   
   $endtime = new Benchmark;

   $buildtime = wallclock($endtime, $starttime);
   
   print get_stamp () . " [$host] $command $target finished. [$buildtime] \n\n";

   # If product config specifies a fail_criteria, check the log file
   # for errors. If we find errors in the log files, we stop right here.

   if (defined (@fail_criteria)) {
      my $errors = check_for_errors ("$out_file", \@fail_criteria); 
      if ($errors) {
         print get_stamp () . " WARNING: Errors detected in $out_file. \n";
         foreach my $k (keys %{$errors}) {
            print "++++++++++ ERROR $k ++++++++++ \n\n";
            print "$errors->{$k} \n";
         }
         print get_stamp () . " ERRORS DETECTED IN BUILD LOG \n";
         b_system ("/bin/touch $buildroot/$ddir/$host/ERRORS ");
         foreach $fc (@fail_criteria) { 
	   b_system ("/bin/grep -n '$fc' $out_file >> $buildroot/$ddir/$host/ERRORS "); }
         # cleanup_and_exit (1);
      }
   }

   unless (chdir ("$run_cwd")) {
      print get_stamp () . " [$host] Could not chdir back to $run_cwd.\n";
      cleanup_and_exit (1);
   }
   
   # Record command run time in our buildtrack hash
   $buildtrack{$buildseq++} = ["$eff_user $command $args $target", "$buildtime"];
   
   if ($target =~ /package/) {
      $packagestatus = 'success';
   }
   
   set_status(\%statusvar, "finished $command $target");

   $iter++;

}


################################################################
### allow additional post-package rules ########################
###
### NIDS is used to this, so we'll leave this alone for now.
### We need to see how often extra targets are run
### If thats frequently run, then create a separate component 
###

my $rule = "";

if ( defined ( $targets ) ) {

   $t0 = new Benchmark;

   print get_stamp() . " Post package rules specified\n";
   print get_stamp() . " Using rules == $targets\n";

   foreach $rule ( (split(/,/,$targets)) ) {

      print get_stamp() . " Running rule == $rule\n";
      set_status(\%statusvar, "running $gmake $makeargs $rule");

      if ( b_system("$gmake $makeargs $rule 1>$logdir/$rule.txt 2>&1") ) {
         print get_stamp() . " Errors running '$gmake $rule'. $!\n";
         next; ### fallthrough?
      }
      else {
         print get_stamp() . " Ran $gmake $rule. Logs in $logdir/$rule.txt\n";
         set_status(\%statusvar, "finished $gmake $makeargs $rule");
      }

   }

   $t1 = new Benchmark;
   $ruletime = wallclock($t1, $t0);
  
   print get_stamp() . " Rules completed. [$ruletime]\n";

   $buildtrack {$buildseq++} = [ "$gmake $makeargs $rule", "$ruletime" ] ;

}

################################################################
### build/push any external distributions ######################
### NIDS specific, leave alone
###

if ( $dodist ) {

  set_status(\%statusvar, 'disting');
  print get_stamp() . " Building distribution\n";
  my $diststatus = 'complete';

  my $suffix = "";

  ## For attack-detection component only, if cvstag is specified
  ## in user input, extract the version from cvstag (i.e extract
  ## 10 if ad_10_branch is specified as cvstag) and use that
  ## as disttag. Requirement from Vijay S.
  if ($cvstag) {
     if ($disttag) {
        $disttag .= "_" . $cvstag;
     } 
     else {
        $disttag = $cvstag;
     }
  } 
  if ($variant) {
      if ($disttag) {
	$disttag .= "_" . $variant;
      } 
      else {
	$disttag = $variant;
      }
  }
  
  if ($disttag) {  $suffix = "DISTTAG=$disttag"; }


  $t0 = new Benchmark;

  if ( defined (@altdist) && @altdist ) {
     # use it raw - escape other items if you want things like
     # $makeargs / $suffix, etc, in scope.
     $dir = $altdist[0]; $cmd = $altdist[1];
     eval " \$dir = \"$dir\" ";
     eval " \$cmd = \"$cmd\" ";

     my $run_cwd = Cwd::getcwd ();
                                                                                
     if ($dir) {
        print get_stamp () . " [$host] Dist Run dir specified as $dir\n";
        unless (chdir ("$dir")) {
           print get_stamp() . " [$host] : Could not chdir to $dir \n";
           cleanup_and_exit (1);
        } 
        else {
           print get_stamp() . " [$host] Going $depth level(s) to $run_dir \n";
           print get_stamp() . " [$host] Currently in " . Cwd::getcwd() . "\n";
        }
     }

     if ( b_system("$cmd 1>$gdistlog 2>&1") ) {
        print get_stamp() . " Error with dist cmd.\n";
        $diststatus = 'failed';
     }

     if ($dir) {
        unless( chdir("$run_cwd") ) {
           print get_stamp() . " [$host] : Could not chdir back to $run_cwd\n";
        }
     }
  } # endif @altdist

  else {
     if ( b_system("$gmake $makeargs $suffix dist 1>$gdistlog 2>&1") ) {
        print get_stamp() . " Error with $'gmake dist'.\n";
        $diststatus = 'failed';
     }
  }

  $t1 = new Benchmark;

  $disttime = wallclock($t1, $t0);
  print get_stamp() . " Dist completed. [$diststatus] [$disttime]\n";

  $buildtrack {$buildseq++} = [ "$gmake $makeargs $suffix dist ", "$disttime" ] ;

}

cleanup_and_exit(0);


##############################################################
##############################################################
##############################################################

sub cleanup_and_exit {

   my $error = shift;
   my $mesg  = shift;

   my $ndate = scalar localtime(time());
   my $oldfh; my $status;
   my ($l, $m, $p, $r, $i);
   my $berr = 0;  my $perr = 0;

   $buildstatus = "completed";

   ### write up some brief status reports

   print get_stamp() . " Runbuild shutting down.\n";

   if ($error == 2) {
      unlock_file($lockfile);
      print get_stamp() . " Exiting: $mesg\n";
      exit $error;
   }
      
   print get_stamp() . " Generating build report.\n";

   if ( gmake_errors($out_file) ) {
      $buildstatus .= " (errors detected in $out_file)";
      $berr++;
   }

   if ( $berr ) {

      ### form the args to pass to wbtb.pl
      $l = "-log $out_file";     $m = "-mailto \"$notify\"";
      $p = "-proj $projectname"; $r = "-mach $host";
      $i = "-plat \"$arch\"";

      ### Run wbtb if there were errors detected ################
      print get_stamp() . " Running wbtb:\n";
      print get_stamp() . " $wbtb $l $m $p $r $i \n";

      if ( b_system("$wbtb $l $m $p $r $i ") ) {
         print get_stamp() . " Error running wbtb.\n";
      }

   }


   # Generic reporting mechanism, go thru our buildtrack hash 
   # and print the command (key) and time it took (value)
   # to run the command.
 
   if ( open(BR,">$breportlog") ) {

      $oldfh = select(BR); $| = 1;

      print "Build Report for [$projectname]\n";
      print "Ran on: $builddate\n\n";

      if ($error || $berr || $perr ) {
         print "Build was unsuccessful\n";
         set_status(\%statusvar, 'failed');
         $status = 'failed';
      } 
      else {
         print "Build was successful\n";
         set_status(\%statusvar,'success');
         $status = 'success';
      }

      print "\nBuild Status : $buildstatus \n"; 
      print "Finished at  : $ndate       \n\n"; 

      foreach (keys %buildtrack) {
         print "--------------------------------------------------------- \n";
         print "Process        : $_ \n";
         print "Command Line   : $buildtrack{$_}->[0] \n";
         print "Time           : $buildtrack{$_}->[1] \n";
         print "--------------------------------------------------------- \n\n";
      }
   

      close(BR);
      select $oldfh;
      print get_stamp() . " Report is in $breportlog\n";
   }
   else { 
      print get_stamp() . " Was unable to open $breportlog! $!\n";
   }

   ### machine parsable results (orig comment)
   ### like we ever set up anything to parse it later 
   ### Need to clean this up, we'll come back later

   $statusvar{'report'}  = "$ddir/$host/logs/buildreport.txt";
   $statusvar{'tagname'} = "$tagname";
   $statusvar{'logs'}    = "$ddir/$host/logs";

   if ( ( ! $error )  && ( ! $berr )  ) {
      $statusvar{'package'} = "$ddir/$host/$startdir/\.\./package/${arch}_OBJ";
   }
   else {

      ### Some may argue that packageing failures aren't _real_ failures -
      ### but whatever.

      $status = 'failed';
      unless ($packagestatus =~ /success/) {
         $statusvar{'package'} = "Build was unsuccessful";
      }
   }

   set_status(\%statusvar, $status);
 
   ### Remove the machine-specific lockfile
   unlink($lockfile);

   exit ($error);

}


##################################################################
