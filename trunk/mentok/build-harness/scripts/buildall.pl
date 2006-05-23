#!/usr/local/bin/perl -w

#########################################################################
### This is 'buildall' - which handles the directory creation, checking #
### out of code, and launching builds to various hosts. #################
#########################################################################

use lib qw('.'); 

use warnings;
use Getopt::Long;
use Benchmark;
use File::Path;
use File::Copy::Recursive;

use build;
use vcs;

use vars qw(%run);

$run{'reqdir'}      = '/home/builds/config';
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
if($@) { exit_err(1, "Errors with config Defaults.pl."); }

eval { require "$run{'reqdir'}/$run{'configfile'}"; };
if($@) { exit_err(1, "Errors with config files $run{'configfile'}, $@"); }

#######################################################################
### Combine them into a %run ##########################################
#######################################################################

if ( evaluate_hash(\%defaults, \%config, \%run) ) {
   print_S "Unable to validate / combine config vars into \%run hash";
   exit_err(1, "Errors making \%run hash - fatal exit.");
}

$run{'ddir'} = get_build_date_next(get_build_date(), $run{'buildroot'});

unless ( $run{'ddir'} ) {
   print_S "Unable to generate date_dir for our purposes!";
   exit_err(1, "Fatal error generating \$ddir for use.");
}

######################################################################
### Make the DDIR directory. #########################################
######################################################################

unless ( mkdir ( "$run{'buildroot'}/$run{'ddir'}", 0777 ) ) {
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

print_S "Redirecting to my logfiles at this moment.\n";

######################################################################
### Time to redirect our output. #####################################
######################################################################

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

print_S "Log file $run{'build_all_log'} successfully opened.\n";
print_S "This build was launched by - $run{'user'}\n";

### XXX Status updates and status for hosts / launcher ###############

######################################################################
### Attempt to prohibit other builds from attempting to build the ####
### same project at the same time. ###################################
######################################################################

print_S "Attempting to lock [$run{'projectname'}].\n";

$run{'lock'} = "$run{'buildroot'}/$run{'projectname'}.lck";

if ( ! lock_file($run{'lock'})) {

   open(LFILE, "<$run{'lock'}") || do {
      exit_err(1, "Can't get lock or read on $run{'lock'}! $!\n");
   };

   my @lockinf = <LFILE>;
   close(LFILE);

   splash_message("$run{'projectname'} is LOCKED by another process.");
   print_S "Lockfile information to follow : \n\n"; print "@lockinf"; print_S "";

   exit_err(1, "Unable to lock build for $run{'projectname'}");

}

### Project is locked. Proceed. #####################################

#####################################################################
### Any exit's from here on should call cleanup so we at the bare ###
### minimum remove our lock file ####################################
#####################################################################

print_S "Project - $run{'projectname'} - locked.\n";
print_S "Using dir - $run{'ddir'} \n";

#####################################################################
### Now we set our checkout root where we put the pristine ##########
### checkout for our use ############################################
#####################################################################

$run{'coderoot'} = "$run{'buildroot'}/$run{'ddir'}/template";

### XXX Do the lastbuild- newest- links in a separate script

#####################################################################
### Make our template dir, and cd into there ########################
#####################################################################

unless ( mkdir ("$run{'coderoot'}", 0777 ) ) {
   cleanup(1);
   exit_err(1, "Unable to mkdir for source code! $!");
}

unless ( chdir ("$run{'coderoot'}") ) {
   cleanup(1);
   exit_err(1, "Unable to chdir into $run{'coderoot'} $!");
}


#####################################################################
### Check out our code, from the defined SCVar<X> in the SCVar ######
#####################################################################

print_S " Beginning ENV initialization of code checkout.\n";

unless ( code_env() ) {
   print_S "Failed ENV init!\n";
   cleanup(1);
   exit_err(1,"Initialization of code_env failed");
}

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

print_S "Checking out source template.\n";

my $t0 = new Benchmark;

unless (code_co("$run{'tag'}", "$run{'redir_co'}") ) {
   cleanup(1);
   exit_err(1, "There were errors during code checkout process. $!");
}

my $t1 = new Benchmark;

$run{'code_co_time'} = wallclock($t1, $t0);

print_S "Code checkout complete [ $run{'code_co_time'} ] \n";


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

   unless ( code_tag("$run{'disttag'}", "$run{'redir_tag'}") ) {
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

print_S "Running tree revision for $run{'projectname'}\n";

unless ( code_treerev("$run{'revlog'}") ) {
   print_S "*** Warning : Errors running treerev for $run{'projectname'}\n";
}
else {
   print_S "Revision dump for $run{'projectname'} is complete\n";
}

#####################################################################
### Now we need to compare our treerev with whatever our last build #
### of same tag/branch was so we can see what files changed #########
#####################################################################

### XXX Do our treediff in here - need to figure out last build of
### XXX lasttag - maybe we should do that here. OR change how we
### XXX do it - update a file perhaps? rather than having to move and
### XXX remove symlinks?

#####################################################################
### Now we're at the post-checkout phase, right before we actually ##
### launch builds - so now we run our precmd's ######################
#####################################################################

### XXX Need to make function to run things in client_build_seq
### XXX style

#####################################################################
### Now we copy the template dir into the host dir, and then launch #
### the build to that host with its own pristine copy of the src ####
#####################################################################

my %pids = (); my $pid;
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

   my $p = Net::Ping->new("syn");
   $p->{'port_num'} = $run{'transport_port'};
   unless ($p->ack) {  
      print_S "$host does not appear to be reachable - skipping.\n";
      next;
   }

   if ( $pid = fork() ) {
      ### parent

      $pids{$pid} = $host;

   }
   elsif (defined ($pid)) {
      ### child

      print_S "Copying source for [$host]\n";
    
      unless ( mkdir ("$run{'buildroot'}/$run{'ddir'}/$host", 0777) ) {
         exit_err(1, "[$host child] Unable to mkdir source dir. $!");
      }

      unless ( chdir ("$run{'buildroot'}/$run{'ddir'}/$host") ) {
         exit_err(1, "[$host child] Unable to chdir to my host directory. $!");
      }

      ### Duplicate the template dir that we checked out to here as toplevel. 
      ### dircopy from File::Copy::Recursive
 
      unless ( dircopy("$run{'coderoot'}/*", ".") ) {
         exit_err(1, "[$host child] Unable to copy template dir into host dir. $!"); 
      }

      ### XXX why set these? they are lost soon. purely for setting our status?

      $run{'statusdir'} = "$run{'buildroot'}/$run{'ddir'}/$host/statusdir";
      $run{'logdir'} = "$run{'buildroot'}/$run{'ddir'}/$host/logs";

      unless ( -d 'logs' ) {
         unless ( mkdir ('logs', 0777) ) {
            exit_err(1,"[$host child] Unable to make my logs dir! $!");
         }
      }

      unless ( -d 'statusdir' ) {
         unless ( mkdir ('statusdir', 0777) ) {
            exit_err(1, "[$host child] Unable to make my statusdir. $!");
         }
      }

      ### XXX Set our status. 

      print_S "[$host child] Launching myself to $host.\n";

      ### XXX Need to eval
      my $cmdline = $run{'cmdline'};

      $cmdline .= ' -dist' if $run{'dist'};

      ### I have removed the maincmd stuff here - we can do it all in the single
      ### config file to pickup correct client_build_sequences 

      $cmdline .= " --config=$run{'configfile'}";
      $cmdline .= " --user=$run{'user'}";
      $cmdline .= " --host=$host";
      $cmdline .= " --VARIANT=$run{'variant'}";
      $cmdline .= " --cvstag=$run{'tag'}" if $run{'tag'};
      $cmdline .= " --special_gmake_args=$local_special" if $local_special;
      $cmdline .= " --ddir=$run{'ddir'}";

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

### XXX Copy ourselves to appropriate lastbuild stuff
### XXX Symlink to latest? 

#######################################################################
### At this point, we sit around and wait for builds to complete ######
#######################################################################

while ( $p = wait() ) {
   last if ($p == -1);

   ### XXX More status redo stuff

   # $statusvar{'host'} = $pids{$p};
   # my $status = get_status(\%statusvar);
   # print_S "Build on host $pids{$p} has completed [ $status ]\n";
   # $cstat{$pids{$p}} = $status;

   delete($pids{$p});
}

alarm(0);

#######################################################################
### Now we launch our buildreport script so that it makes a simple ####
### html status page ##################################################
#######################################################################

print_S "Generating build report from buildall\n";

b_system("$run{'buildreport'} --config=$run{'config'}");

print_S "Done generating build report\n";

#######################################################################
### Now we run any post commands that were defined ####################
#######################################################################

### XXX Again, the client_build_sequence like runner function of this
### XXX item

#######################################################################
### Cleanup ###########################################################
#######################################################################

cleanup(0);

maildone();

exit(0);












##############################################################################
sub handle_alarm {

   print_S "More than $run{'alarmwait'} seconds have passed\n";
   print_S "Generating report and exiting\n";

   foreach my $k (keys(%pids)) {
      print_S " ...  $pids{$k} is still running\n";
### XXX More status fixups
#      $statusvar{'host'} = $pids{$k};
#      set_status(\%statusvar, 'failed: timeout');
   }
   print "\n";

   b_system("$run{'buildreport'} --config=$run{'configfile'}");

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

   unless ( code_cleanup() ) {
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

### XXX Fix maildone to fix up the status hash, etc. 

sub maildone {

   my $server  = $run{'mailserver'};
   my $sender  = $run{'sender'}; 
   my $name    = 'Build Notice';
   my $baseurl = $run{'baseurl'};

   my $compstat;
   my $FAILPLATS;

   ($compstat, $FAILPLATS) = get_cstat();

   my $subject = "$projectname Build ($run{'ddir'}) completed: $compstat";
   my $rcpt    = "";

   if ( $run{'notify'} ) {
      $rcpt = $run{'notify'};
   }

   if ( $run{'bcnotify'} ) {
      $rcpt .= ",$run{'bcnotify'}";
   }

   if ( $run{'email'} ) {
      $rcpt .= ",$run{'email'}";
   }

   my $body .= get_stamp() . "\n\nBuild was spun from";

   if ($run{'tag'}) {
      $body .= " tag: $run{'tag'}. \n\n";
   }
   else {
      $body .= " Trunk. \n\n";
   }

   $body .= "Build was spun by $run{'user'}. \n\n\n";

   $body .= "Build failed on:\n$FAILPLATS\n" if ($compstat =~ /^FAILED$/);
   $body .= "Details of this build are available at : \n\n";
   $body .= "$baseurl/$projectname/summary.html\n";

   if ( ! send_email($server, $sender, $rcpt, $subject, $body) ) {
      print get_stamp() . " Error sending buildreport mail. Dumping STDOUT\n";
      print $body;
   }

   return;
}


