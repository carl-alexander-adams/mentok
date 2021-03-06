#!/usr/bin/perl -w

#########################################################################
### This is 'buildall' - which handles the directory creation, checking #
### out of code, and launching builds to various hosts. #################
#########################################################################

use lib qw('.'); 
use lib qw(/home/builds/scripts2);

### Some Standard Perl Modules.
use Getopt::Long;
use Benchmark;
use File::Path;
use File::Copy::Recursive qw(fcopy rcopy dircopy fmove rmove dirmove);;
use Net::Ping;

### Our perl modules.
use build;
use vcs;

#########################################################################
### These variables will come in from the various config files, mostly ##
### from the product config file ########################################
#########################################################################

use vars qw(%run %defaults %config);
use vars qw(%SCVar @precommands @postcommands);

#########################################################################
### set our final defaults, and then read command line
#########################################################################

$run{'reqdir'}      = '/home/builds/config2';
$run{'master_lock'} = '/home/builds/master.lck';

GetOptions("config|c=s"               => \$run{'configfile'},
           "cvstag|tag|label=s"       => \$run{'tag'},
           "email|e=s"                => \$run{'email'},
           "dist|d"                   => \$run{'dist'},
           "variant|var=s"            => \$run{'variant'},
           "user|u=s"                 => \$run{'user'},
           "special_gmake_args|sga=s" => \$run{'special_gmake_args'},
           "host|h=s"                 => \%{$run{'perhost'}},
           "suffix|s=s"               => \$run{'suffix'},
           "verbose|v"                => \$run{'verbose'},
         );

unless ( $run{'configfile'} ) {
   usage();
   exit_err(1, "Incorrect args. No config file.");
}

if ( -f "$run{'master_lock'}" ) {
   print_S "Detected Build System Lock File, $run{'master_lock'} ";
   print_S "Aborting build start.\n";
   exit_err(1, "Build System Locked.");
}

$run{'user'} = $run{'user'} || $ENV{'USER'} || 'buildsystem-default';

### Source config files. 

eval { require "$run{'reqdir'}/Defaults.pl"; };
if($@) { exit_err(1, "Errors with config Defaults.pl. $@"); }

if ( ! -f "$run{'configfile'}") {
   if ( ! -f "$run{'reqdir'}/$run{'configfile'}" ) {
      print_S "*** Error config file specified, but not found.\n";
      exit_err(1, "No configfile.");
   }
   else {
      $run{'configfile'} = "$run{'reqdir'}/$run{'configfile'}";
   }
}

eval { require "$run{'configfile'}"; };
if($@) { exit_err(1, "Errors with config files $run{'configfile'}, $@"); }

#######################################################################
### Combine them into a %run ##########################################
#######################################################################

if ( evaluate_hash(\%defaults, \%config, \%run) ) {
   print_S "Unable to validate / combine config vars into \%run hash";
   exit_err(1, "Errors making \%run hash - fatal exit.");
}

if ( ! defined ($run{'tag'}) ) { $run{'tag'} = ''; }

$run{'ddir'} = get_build_date_next(get_build_date(), "$run{'buildroot'}");

unless ( $run{'ddir'} ) {
   print_S "Unable to generate date_dir for our purposes!";
   exit_err(1, "Fatal error generating \$ddir for use.");
}

######################################################################
### Make the DDIR directory. #########################################
######################################################################

unless ( mkpath ("$run{'buildroot'}/$run{'ddir'}", 0, 0755 ) ) { 
   print_S "Problems creating $run{'ddir'} for in $run{'buildroot'}\n";
   exit_err(1, "Fatal error creating $run{'ddir'} for use.");
}

######################################################################
### Get ready with our log files. ####################################
### And our redirects ################################################
######################################################################

$run{'build_all_log'}  = "$run{'buildroot'}/$run{'ddir'}/buildall.txt";
$run{'revlog'}         = "$run{'buildroot'}/$run{'ddir'}/revlog.txt";
$run{'difflog'}        = "$run{'buildroot'}/$run{'ddir'}/difflog.txt";

$run{'redir_null'}     = "1>/dev/null 2>&1";
$run{'redir_co'}       = "1>>$run{'buildroot'}/$run{'ddir'}/checkoutlog.txt 2>&1";
$run{'redir_tag'}      = "1>>$run{'buildroot'}/$run{'ddir'}/taglog.txt 2>&1";
$run{'redir_pre'}      = "1>>$run{'buildroot'}/$run{'ddir'}/precmd.txt 2>&1";
$run{'redir_post'}     = "1>>$run{'buildroot'}/$run{'ddir'}/postcmd.txt 2>&1";

######################################################################
### set a status dir to output text files that contain status info ###
### for other things to read / parse #################################
######################################################################
      
$run{'statusdir'} = "$run{'buildroot'}/$run{'ddir'}/statusdir";

unless ( mkpath ("$run{'statusdir'}", 0, 0755 ) ) { 
   print_S "Problems creating $run{'statusdir'} in $run{'buildroot'}\n";
   exit_err(1, "Fatal error creating $run{'statusdir'} for use.");
}

######################################################################
### with that set, time to setup our status variable for our host ####
######################################################################

my (%statusvar); 

$statusvar{'host'}      = $run{'host'};
$statusvar{'ddir'}      = $run{'ddir'};
$statusvar{'statusdir'} = $run{'statusdir'};

$run{'statusref'} = \%statusvar;

set_status(\%statusvar, "Redirecting to my log files");

######################################################################
### Time to redirect our output. #####################################
######################################################################

print_S("Build for $run{'projectname'} initialized. Using DDIR $run{'ddir'}\n");

print_S("Redirecting to my logfiles at this moment.\n");

open(BLOG, ">$run{'build_all_log'}") || do {
   print_S "Failed to open $run{'build_all_log'}.";
   exit_err(1, "Cannot open my logfile! $! $?");
};

open(STDOUT, ">&BLOG") || do {
   exit_err(1, "Cannot dup STDOUT to BLOG ($run{'build_all_log'}) $!");
};

open(STDERR, ">&BLOG") || do {
   exit_err(1, "Cannot dup STDERR to BLOG ($run{'build_all_log'}) $!");
};

select(BLOG); $| = 1;

print_S("Log file $run{'build_all_log'} successfully opened.\n");
print_S("This build was launched by - $run{'user'}\n");

set_status(\%statusvar, "Redirected to my logfiles");

######################################################################
### Attempt to prohibit other builds from attempting to build the ####
### same project at the same time. ###################################
######################################################################

print_S("Attempting to lock [$run{'projectname'}].\n");

$run{'lock'} = "$run{'buildroot'}/$run{'projectname'}.lck";

if ( ! lock_file($run{'lock'})) {

   open(LFILE, "<$run{'lock'}") || do {
      exit_err(1, "Can't get lock or read on $run{'lock'}! $!\n");
   };

   my @lockinf = <LFILE>;
   close(LFILE);

   splash_message("$run{'projectname'} is LOCKED by another process.");
   print_S "Lockfile information to follow :\n\n"; print "@lockinf"; print_S "";

   exit_err(1, "Unable to lock build for $run{'projectname'}");

}

set_status(\%statusvar, "Locked for $run{'projectname'}");

### Project is locked. Proceed. #####################################

#####################################################################
### Any exit's from here on should call cleanup so we at the bare ###
### minimum remove our lock file ####################################
#####################################################################

print_S("Project - $run{'projectname'} - locked.\n");
print_S("Using dir - $run{'ddir'} \n");

#####################################################################
### Now we set our checkout root where we put the pristine ##########
### checkout for our use ############################################
#####################################################################

$run{'coderoot'} = "$run{'buildroot'}/$run{'ddir'}/template";

#####################################################################
### Make our template dir, and cd into there ########################
#####################################################################

unless ( mkpath ( "$run{'coderoot'}", 0, 0755) ) { 
   cleanup(1);
   exit_err(1, "Unable to mkpath for source code! $!");
}

unless ( chdir ("$run{'coderoot'}") ) {
   cleanup(1);
   exit_err(1, "Unable to chdir into $run{'coderoot'} $!");
}

#####################################################################
### Check out our code, from the defined SCVar<X> in the SCVar ######
#####################################################################

set_status(\%statusvar, "Beginning Code ENV");

print_S "Beginning ENV initialization of code checkout.\n";

unless ( code_env(\%SCVar) ) {
   print_S "Failed ENV init!\n";
   cleanup(1);
   exit_err(1,"Initialization of code_env failed");
}

set_status(\%statusvar, "Code ENV Complete");

#####################################################################
### Drop a TAGBUILD or VARIANT file as appropriate for the build ####
#####################################################################

if (defined ($run{'tag'}) && $run{'tag'} ) {
   if ( open (TAGFILE, ">$run{'buildroot'}/$run{'ddir'}/TAGBUILD") ) {
      print TAGFILE "$run{'tag'}\n";
      close(TAGFILE);
   }
   else {
      print_S "*** Warning : Unable to mark build as a TAGBUILD! $!\n";
   }
}

if (defined ($run{'variant'}) && $run{'variant'} ) {
   if ( open (VARFILE, ">$run{'buildroot'}/$run{'ddir'}/VARIANT" ) ) {
      print VARFILE "$run{'variant'}\n";
      close(VARFILE);
   }
   else {
      print_S "*** Warning : Unable to mark build as a VARIANT! $!\n";
   }
}

#####################################################################
### Time to check out the source code ###############################
#####################################################################

set_status(\%statusvar, "Checking out code");

print_S("Checking out source template.\n");

my $t0 = new Benchmark;

unless (code_co(\%SCVar, "$run{'tag'}", "$run{'redir_co'}") ) {
   cleanup(1);
   exit_err(1, "There were errors during code checkout process. $!");
}

my $t1 = new Benchmark;

$run{'code_co_time'} = wallclock($t1, $t0);

print_S("Code checkout complete [ $run{'code_co_time'} ] \n");

set_status(\%statusvar, "Code checkout complete");

#####################################################################
### If "dist" is specified, meaning we are pushing ourselves from a #
### package form to a specified repository for binaries, then we ####
### want to make sure we are tag'ed for reproducibility #############
#####################################################################

if ( $run{'dist'} ) {

   $run{'disttag'}  = "$run{'projectname'}-dist-$run{'ddir'}";
   $run{'distfile'} = "$run{'buildroot'}/$run{'ddir'}/.dist";
  
   if ($run{'variant'}) { $run{'disttag'} .= "_" . $run{'variant'}; }

   print_S "Applying tag ($run{'disttag'})\n";

   unless ( code_tag(\%SCVar, "$run{'disttag'}", "$run{'redir_tag'}") ) {
      cleanup(1);
      exit_err(1, "Unable to tag source with $run{'disttag'}");
   }

   if ( open (DIST, ">$run{'distfile'}") ) {
      print DIST "TAG: $run{'tag'}\n"; print DIST "DDIR: $run{'ddir'}\n";
      print DIST "PROD: $run{'projectname'}\n";
      print DIST "VARIANT: $run{'variant'}" if $run{'variant'};
      close(DIST);
   }
   else {
      print_S "*** Warning : Unable to drop .dist file. $!\n";
   }

}


#####################################################################
### Time for treerev, which will show us our revisions of what ######
### we just checked out #############################################
#####################################################################

print_S("Running tree revision for $run{'projectname'}\n");

unless ( code_treerev(\%SCVar, "$run{'revlog'}") ) {
   print_S "*** Warning : Errors running treerev for $run{'projectname'}\n";
}
else {
   print_S "Revision dump for $run{'projectname'} is complete\n";
}

#####################################################################
### Now we need to compare our treerev with whatever our last build #
### of same tag/branch was so we can see what files changed #########
#####################################################################

$run{'lastbuildfile'}  = "$run{'buildroot'}/lastbuild";
$run{'lastbuildfile'} .= "-$run{'tag'}" if $run{'tag'};

if ( -f "$run{'lastbuildfile'}" ) {
   if ( open(LB, "<$run{'lastbuildfile'}") ) {
      while( <LB> ) { chomp; $run{'lb'} = $_; } 
      close(LB);
      $run{'prerevlog'} = "$run{'buildroot'}/$run{'lb'}/revlog.txt";   
      code_treediff(\%SCVar, "$run{'prerevlog'}", "$run{'revlog'}", "$run{'difflog'}");
   }
   else {
      print_S "*** Warning: Couldn't open $run{'lastbuildfile'} lastbuild\n";
   }
}

if ( open(LB, ">>$run{'lastbuildfile'}") ) {
   print LB "$run{'ddir'}\n";
   close(LB);
}
else {
   print_S "*** Warning: Couldn't write back to $run{'lastbuildfile'}\n";
}

#####################################################################
### Now we're at the post-checkout phase, right before we actually ##
### launch builds - so now we run our precmd's ######################
#####################################################################

if ( defined ( @precommands) ) { 
   unless ( run_commands ( \%run, \@precommands, '', 'pre' ) ) {
      print_S "Errors running precommands.\n";
      exit_err(1, "Errors with precommands - exiting.");
   }
}

#####################################################################
### Now we copy the template dir into the host dir, and then launch #
### the build to that host with its own pristine copy of the src ####
#####################################################################

my %pids = (); my %cstat = (); my $pid;
my ($enable, $eargs);
my $local_special;

foreach my $host ( sort @{$run{'buildhosts'}} ) {

   $enable = 1; $eargs = ''; 
   $local_special = $run{'special_gmake_args'};

   if ( defined ( $run{'perhost'}{$host} ) ) {
      ($enable, $eargs) = split(/|/, $run{'perhost'}{$host});
      if ( $enable == 0 ) {
         print_S "Host '$host' disabled. Skipping.\n";
         next;
      }
      $local_special .= " $eargs";
   }

   eval { 
      my $p = Net::Ping->new("syn") || die "nosyn"; 
      $p->{'port_num'} = $run{'transport_port'};
      $p->ping($host);
      unless ($p->ack) {  
         print_S "$host does not appear to be reachable - skipping.\n";
         die "nohost";
      }
   };

   if ($@ =~ /nosyn/) {
      if ($run{'ping'}) { 
         unless ( b_system("$run{'ping'} $host") ) {
            print_S "$host does not appear to be reachable - skipping.\n";
            next;
         }
      }
      else {
         print_S "*** Warning - skipping host up check for $host\n";
      }
   }

   if ( $pid = fork() ) {
      ### parent

      $pids{$pid} = $host;

   }
   elsif (defined ($pid)) {
      ### child

      $statusvar{'host'} = $host;

      print_S "Copying source for [$host]\n";
    
      unless ( mkpath ("$run{'buildroot'}/$run{'ddir'}/$host", 0, 0755) ) {
         exit_err(1, "[$host child] Unable to mkpath source dir. $!");
      }

      unless ( chdir ("$run{'buildroot'}/$run{'ddir'}/$host") ) {
         exit_err(1, "[$host child] Unable to chdir to my host directory. $!");
      }

      ### Duplicate the template dir that we checked out to here as toplevel. 
      ### dircopy from File::Copy::Recursive
 
      unless ( dircopy("$run{'coderoot'}/*", ".") ) {
         exit_err(1, "[$host child] Unable to copy template dir into host dir. $!"); 
      }

      unless ( -d 'logs' ) {
         unless ( mkpath ('logs', 0, 0755) ) { 
            exit_err(1,"[$host child] Unable to make my logs dir! $!");
         }
      }

      set_status(\%statusvar, "Launching to $host");

      my $cmdline = $run{'cmdline'};

      $cmdline .= ' -dist' if $run{'dist'};

      $cmdline .= " --config=$run{'configfile'}";
      $cmdline .= " --user=$run{'user'}";
      $cmdline .= " --host=$host";
      $cmdline .= " --VARIANT=$run{'variant'}" if $run{'variant'};
      $cmdline .= " --cvstag=$run{'tag'}" if $run{'tag'};
      $cmdline .= " --special_gmake_args=$local_special" if $local_special;
      $cmdline .= " --ddir=$run{'ddir'}";

      eval " \$cmdline = \"$cmdline\" ";

      print_S "[$host child] Launching to $host with '$cmdline'\n";

      exec("$run{'transport'} $host '$cmdline'");

   }
   else {
      ### fork error

      print_S "Error forking build for $host : $!\n";
      next;

   }

   sleep(5);

} 
      
$SIG{'ALRM'} = \&handle_alarm;
alarm($run{'alarmwait'});

#######################################################################
### At this point, we sit around and wait for builds to complete ######
#######################################################################

while ( $pid = wait() ) {
   last if ($pid == -1);

   $statusvar{'host'} = $pids{$pid};
   my $status = get_status(\%statusvar);
   print_S "Build on host $pids{$pid} has completed [ $status ]\n";
   $cstat{$pids{$pid}} = $status;

   delete($pids{$pid});
}

alarm(0);

#######################################################################
### Now we run any post commands that were defined ####################
#######################################################################

if ( defined ( @postcommands) ) {
   unless ( run_commands ( \%run, \@postcommands, '', 'post' ) ) {
      print_S "Errors running postcommands.\n";
      exit_err(1, "Errors with postcommands - exiting.");
   }
}

#######################################################################
### Now we launch our buildreport script so that it makes a simple ####
### html status page ##################################################
#######################################################################

print_S "Generating build report from buildall\n";
### XXX buildreport needs fixing
#b_system("$run{'buildreport'} --config=$run{'config'}");
print_S "Done generating build report\n";

#######################################################################
### Cleanup ###########################################################
#######################################################################

cleanup(0);

maildone(\%run, \%cstat);

exit(0);

##############################################################################


##############################################################################

sub handle_alarm {

   print_S "More than $run{'alarmwait'} seconds have passed\n";
   print_S "Generating report and exiting\n";

   foreach my $k (keys(%pids)) {
      print_S " ...  $pids{$k} is still running\n";
      $statusvar{'host'} = $pids{$k};
      set_status(\%statusvar, 'failed: timeout');
   }
   print "\n";

### XXX buildreport needs fixing.
#   b_system("$run{'buildreport'} --config=$run{'configfile'}");

   cleanup();

   exit(-1);

}

##############################################################################

sub cleanup {

   my $err = shift;

   splash_message ("Beginning cleanup");

   unless ( chdir("$run{'buildroot'}") ) {
      print_S "Unable to chdir to $run{'buildroot'}: $! - Cleanup Aborted\n";
      return;
   }

   ### Clean up any rev. control related stuff (delete P4 clients ..etc)
   print_S  "Beginning cleanup routine for Source Control.\n";

   unless ( code_cleanup(\%SCVar) ) {
      print_S "Cleanup routine for Source Control failed!\n";
   }
   print_S "Finished cleanup routine for Source Control.\n";
   print_S "Removing Lock file $run{'lock'}\n";

   unless ( unlock_file("$run{'lock'}") ) {
      print_S "*** Warning : Unable to remove my lockfile\n";
   }

   splash_message ("Cleanup done");

}

##############################################################################

sub splash_message {

   my $message = shift;

   print_S "#############################################################################\n";
   print_S "SPLASH - $message \n";
   print_S "#############################################################################\n";

}

##############################################################################

sub get_cstat {

   my $run_ref = shift;
   my $c_ref   = shift;

   my $cs_retval = 'SUCCESS';
   my $FAILPLATS;

   foreach my $cs ( keys %{$c_ref} ) {
      next if ($c_ref->{"$cs"} =~ /^success$/);
      $FAILPLATS .= "\t$cs: $run_ref->{'platforms'}{$cs}\n";
      $cs_retval = 'FAILED';
   }

   return ($cs_retval, $FAILPLATS);

}


sub usage {

   print <<EOF;

$0 - Spin a build.

        --config=<configfile>		[REQUIRED]
        --cvstag|tag|label=<tag>	[OPTIONAL]
        --email="addy1,addy2"		[OPTIONAL]
        -dist|d				[OPTIONAL]
        --special_gmake_args="X=Y"      [OPTIONAL]
	--variant=<VAR>			[OPTIONAL]
	--user=<user>			[OPTIONAL]
	--host <host>="<X>|<ARGS>"	[OPTIONAL]
	--verbose|v			[OPTIONAL]

Ex:

$0 --config=/home/builds/config/manhunt.pl --email="someone\@somewhere.com" -dist


EOF

}

##############################################################################

sub maildone {

   my $run_ref = shift; 
   my $c_ref   = shift; 

   my $server  = $run_ref->{'mailserver'} || 'mail';
   my $sender  = $run_ref->{'sender'}     || 'Automated Build Mail <root>';
   my $name    = 'Build Notice';

   my $compstat;
   my $FAILPLATS;

   ($compstat, $FAILPLATS) = get_cstat($run_ref, $c_ref);

   my $subject = "$run_ref->{'projectname'} Build ($run_ref->{'ddir'})";
   $subject   .= " completed: $compstat";

   my $rcpt    = "";

   if ( defined ( $run_ref->{'notify'} ) && $run_ref->{'notify'} ) {
      $rcpt = $run{'notify'};
   }

   if ( defined ( $run_ref->{'bcnotify'} ) && $run_ref->{'bcnotify'} ) {
      $rcpt .= ",$run{'bcnotify'}";
   }

   if ( defined ( $run_ref->{'email'} ) && $run_ref->{'email'} ) {
      $rcpt .= ",$run{'email'}";
   }

   my $body .= get_stamp() . "\n\nBuild was spun from";

   if (defined ($run_ref->{'tag'}) && $run_ref->{'tag'}) {
      $body .= " tag: $run_ref->{'tag'}. \n\n";
   }
   else {
      $body .= " Trunk. \n\n";
   }

   $body .= "Build was spun by $run_ref->{'user'}. \n\n\n";
   $body .= "Build failed on:\n$FAILPLATS\n" if ($compstat =~ /^FAILED$/);

   if ( ! send_email($server, $sender, $rcpt, $subject, $body) ) {
      print_S "Error sending buildreport mail. Dumping STDOUT\n";
      print $body;
   }

   return;
}


