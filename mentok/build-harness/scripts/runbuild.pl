#!/usr/local/bin/perl -w

############################################################################
### this is runbuild - the script that takes some args, and actually 
### launches the build on the client-side host. 
############################################################################

use lib qw('.');
use warnings;
use Getopt::Long;
use Benchmark;
use Cwd;

use build;

$| = 1;

use vars qw(%run);

$run{'reqdir'}      = '/home/builds/config';
$run{'master_lock'} = '/home/builds/master.lck';

############################################################################
### check for master lock file - abort if found.
############################################################################

if ( -f "$run{'master_lock'}" ) {
   print_S "Detected Build System Lock File, $run{'master_lock'} ";
   print_S "Aborting build start.\n";
   exit_err(1, "Build System Locked.");
}

GetOptions("config|c=s"               => \$run{'configfile'},
           "cvstag|tag|label=s"       => \$run{'tag'},
           "email|e=s"                => \$run{'email'},
           "dist|d"                   => \$run{'dist'},
           "VARIANT|variant|var=s"    => \$run{'variant'},
           "DISTTAG|disttag=s"        => \$run{'disttag'},
           "user|u=s"                 => \$run{'user'},
           "special_gmake_args|sga=s" => \$run{'special_gmake_args'},
           "host|h=s"                 => \$run{'hostforce'},
           "suffix|s=s"               => \$run{'suffix'},
           "verbose|v"                => \$run{'verbose'},
           "ddir=s"                   => \$run{'ddir'},
         );

$run{'user'} = $run{'user'} || $ENV{'USER'} || 'buildsystem-default';

#######################################################################
### basic check for configfile and ddir - which is all we really need to
### get going
#######################################################################

if ( ( ! $run{'configfile'} ) || ( ! $run{'ddir'} ) ) {
   usage();
   exit_err(1, "Missing critical args.");
}

if ( (! $run{'buildroot'} ) ||  (! $run{'projectname'} ) ) {
   exit_err(1, "Don't run me directly! Use buildall whenever possible!\n");
}

#######################################################################
### source our defaults and our config file
#######################################################################

eval { require "$run{'reqdir'}/Defaults.pl"; };
if ($@) { exit_err(1, "Error with config Defaults.pl."); }

eval { require "$run{'reqdir'}/$run{'configfile'}"; };
if($@) { exit_err(1, "Errors with config files $run{'configfile'}, $@"); }

#######################################################################
### Combine them into a %run ##########################################
#######################################################################

if ( evaluate_hash(\%defaults, \%config, \%run) ) {
   print_S "Unable to validate / combine config vars into \%run hash";
   exit_err(1, "Errors making \%run hash - fatal exit.");
}

if ( (! $run{'buildroot'} ) ||  (! $run{'projectname'} ) ) {
   exit_err(1, " 'buildroot' and 'projectname' MUST be defined!\n");
}

######################################################################
### in case we are using CNAMEs or something
######################################################################

if (defined ($run{'hostforce'} ) && $run{'hostforce'} ) {
   $run{'host'} = $run{'hostforce'}; # override the `hostname` call from configfile.
}

### XXX last build stuff again. Need to see why runbuild even CARES about this

$run{'lockfile'} = "$run{'buildroot'}/$run{'host'}.lck";

######################################################################
### convenience defines
######################################################################

$run{'basedir'} = "$run{'buildroot'}/$run{'ddir'}/$run{'host'}";
$run{'logdir'}  = "$run{'basedir'}/logs";

$run{'runlog'}  = "$run{'logdir'}/runbuildlog.txt";
$run{'precmd'}  = "$run{'logdir'}/precmdlog.txt";
$run{'distlog'} = "$run{'logdir'}/distlog.txt";
$run{'breport'} = "$run{'logdir'}/buildreport.txt";

######################################################################
### final outputs before redirecting to our logs
######################################################################

print_S " [$run{'host'}] Getting into $run{'basedir'}\n";

unless ( chdir ( "$run{'basedir'}" ) ) {
   exit_err(1, "Unable to chdir to $run{'basedir'}! $!");
}

print_S " [$run{'host'}] Setting up my logfiles.\n";

unless ( -d 'logs' ) {
   unless ( mkdir ("logs", 0777) ) {
      exit_err(1, "Unable to make my logs dir! $!");
   }
}

unless ( -d "$run{'statusdir'}" ) {
   unless ( mkdir ("$run{'statusdir'}", 0777) ) {
      exit_err(1, "Unable to make my status dir! $!");
   }
}

print_S " [$run{'host'}] Redirecting to my log files.\n";

open(STDOUT, ">$run{'runlog'}") || do {
    print "Could not redirect STDOUT to $run{'runlog'}: $!\n";
};

open(STDERR, ">&STDOUT") ||  do {
    print "Could not redirect STDERR to $run{'runlog'}: $!\n";
};

select((select(STDERR), $| = 1)[0]);
select((select(STDOUT), $| = 1)[0]);


######################################################################
### from here on to our separate host logs
######################################################################

print_S "runbuild log opened for $run{'host'}\n";

print <<EOF;

Debug Output Follows :

config                  : $run{'configfile'}
ddir                    : $run{'ddir'}
cvstag                  : $run{'tag'}
dist                    : $run{'dist'}
user                    : $run{'user'}
DISTTAG                 : $run{'disttag'}
VARIANT                 : $run{'variant'}
special_gmake_args      : $run{'special_gmake_args'}
host                    : $run{'host'}

EOF


unless ( lock_file("$run{'lockfile'}") ) {

   unless (lock_age("$run{'$lockfile'}") > 2) {
      set_status(\%statusvar, "failed: already running - lockfile present");
      exit_err(1, "Already running on $run{'host'} or stale lockfile ($run{'lockfile'})");
   }
   else {
      print get_stamp() . " Lockfile age exceeds 2 hours - proceeding.\n";
      unlock_file("$run{'lockfile'}");
      if ( ! lock_file("$run{'lockfile'}") ) {
         set_status(\%statusvar, "failed: unable to relock lockfile");
         exit_err(1, "Cannot lock my lockfile ($lockfile)");
      }
   }
}

print_S "Building $run{'projectname'}\n";

my $cwd  = Cwd::getcwd ();

if ("$run{'startdir'}") {
   print_S "Start dir defined as $run{'startdir'} \n";
   unless ( chdir("$run{'startdir'}") ) {
      cleanup_and_exit(2, "Unable to chdir to $run{'startdir'}! $!\n");
   }
} 
else {
   unless ( chdir ('src') ) {  # start dir is not defined, try src
      print get_stamp () . " Unable to chdir to src (hardcoded) \n";
      print get_stamp () . " Will try \".\" \n";
      $run{'startdir'} = '.';
   } 
   else { 
      print_S "Starting in " . Cwd::getcwd() . "\n"; 
   }
}

######################################################################
### start forming up the commandline
######################################################################

$run{'makeargs'} = '';

if (defined ($run{'special_gmake_args'}) && $run{'special_gmake_args'}) { 
   $run{'makeargs'} .= " $run{'special_gmake_args'}"; 
}

if (defined ($run{'variant'}) && $run{'variant'} ) { 
   $run{'makeargs'} .= " VARIANT=$run{'variant'}"; 
}

if ($run{'makeargs'}) { 
   print_S "make args are : $run{'makeargs'}\n";
}

if ( ! @client_build_sequence ) {
   print_S "Client Command Sequence not found.\n";
   cleanup_and_exit(1);
}


######################################################################
### run our client_build_sequence commands and output to log files
######################################################################

if ( ! run_commands (\%run, \@client_build_sequence, \@fail_criteria, 'rb') ) {
   print_S "Error running runbuild commands - please see the logs.\n";
   ### XXX cleanup and exit?
}


######################################################################
### now we push a binary package (library, tarball, etc) to our dist
### (distribution) area in case other builds need to pick it up
######################################################################

if ( $run{'dist'} ) {

###   set_status(\%statusvar, 'disting');

   print_S "Building distribution / dist'ing\n";

   my $suffix  = ''; my $disttag = '';

   if ($run{'tag'}) { if ($run{'disttag'}) { $run{'disttag'} .= "_" . $run{'tag'}; } 
                      else { $run{'disttag'} = $run{'tag'}; }
   }

   if ($run{'variant'}) { if ($run{'disttag'}) { $run{'disttag'} .= "_" . $run{'variant'}; }
                          else { $run{'disttag'} = $run{'variant'}; } 
   }

   if ($run{'disttag'}) {  $run{'suffix'} = "DISTTAG=$run{'disttag'}"; }

   $t0 = new Benchmark;

   if ( defined (@altdist) && @altdist ) {

     ### XXX altdist is now treated like a cbs
     ### XXX DOC @dist_fail_criteria 
      if ( ! run_commands(\%run, \@altdist, \@dist_fail_criteria, 'ad') ) {
         print_S "Error running altdist commands - please see the logs.\n";
         ### XXX cleanup and exit?
      }
   }
   else {
      $run{'distcmd'} = "$run{'gmake'} $run{'makeargs'} $run{'suffix'} dist";
      if ( b_system("$run{'distcmd'} dist 1>$run{'distlog'} 2>&1") ) {
         print get_stamp() . " Error with dist'.\n";
      }
   }

   $t1 = new Benchmark;

   $disttime = wallclock($t1, $t0);
   print_S "Dist completed. [$disttime]\n";

###   $buildtrack {$buildseq++} = [ "$gmake $makeargs $suffix dist ", "$disttime" ] ;

}

cleanup_and_exit(0);

######################################################################

### XXX come back and fix this up - need to work on where we log / how
### XXX we parse logs. 

sub cleanup_and_exit {

   my $error = shift;
   my $mesg  = shift;

   my $ndate = scalar localtime(time());
   my $oldfh; my $status;
   my ($l, $m, $p, $r, $i);
   my $berr = 0;  my $perr = 0;

   my $buildstatus = "completed";

   ### write up some brief status reports

   print get_stamp() . " Runbuild shutting down.\n";

   if ($error) {
      unlock_file($lockfile);
      print get_stamp() . " Exiting: $mesg\n";
      exit $error;
   }

   ### print get_stamp() . " Generating build report.\n";

   ### XXX out_file points at the last file processed from the old cbs 
   ### sequence - should this be moved to run_Command and only run for
   ### make ? 
#   if ( gmake_errors($out_file) ) {
#      $buildstatus .= " (errors detected in $out_file)";
#      $berr++;
#   }

#   if ( $berr ) {
#
#      ### form the args to pass to wbtb.pl
#      $l = "-log $out_file";     $m = "-mailto \"$notify\"";
#      $p = "-proj $projectname"; $r = "-mach $host";
#      $i = "-plat \"$arch\"";
#
#      ### Run wbtb if there were errors detected ################
#      print get_stamp() . " Running wbtb:\n";
#      print get_stamp() . " $wbtb $l $m $p $r $i \n";
#
#      if ( b_system("$wbtb $l $m $p $r $i ") ) {
#         print get_stamp() . " Error running wbtb.\n";
#      }
#
#   }
#
#   ### XXX Need to set host's final status here somehow.
#
   unlink($lockfile);

   exit ($error);

}


