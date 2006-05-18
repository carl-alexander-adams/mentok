#!/usr/local/bin/perl

#############################################################
### buildall.pl 
### This takes the initial step of building, and launches it
### across the platforms/machines. We'll leave this as a
### fairly straightforward script, since it hasn't all that
### much to accomplish
###

use lib qw(/home/builds/scripts);
use Getopt::Long;
use build;
use vcs;
use Benchmark;

my $reqdir = "/home/builds/config";

#############################################################
###
### Our master lock file. If this exists, we just exit.
### 
#############################################################

my $master_lock = "/home/builds/master.lck";

#############################################################
### We have to pull most of this in from the webform off ###
### of eng/bother.  ########################################
#############################################################

my ($configfile, $email,  $dist);
my ($bomb,       $debug,  $suffix, $strip);
my ($build_suffix, $special_gmake_args);
my ($user);
my (%perhost);

# tag needs to be available elsewhere. (like a config file)
use vars qw($tag); $tag = "";

$configfile = $email  = $dist  =  
      $bomb = $debug  = $suffix = $strip = 
      $build_suffix = $special_gmake_args = $user = "";

GetOptions("config=s"                => \$configfile,
           "cvstag=s"                => \$tag,
           "email=s"                 => \$email,
           "dist+"                   => \$dist,
           "bomb=s"                  => \$bomb,
           "debug=s"                 => \$debug,
           "strip=s"                 => \$strip,
           "suffix=s"                => \$suffix,
	   "variant=s"		     => \$variant,
           "user=s"                  => \$user,
           "build_suffix=s"          => \$build_suffix,
           "special_gmake_args=s"    => \$special_gmake_args,
           "host=s"		     => \%perhost,
          );

if ( ! $configfile ) {
   usage();
   exit_err(1, "Incorrect args. No config file.");
}


#############################################################
###
### Check if there is a master lock file
###
#############################################################

if ( -f "$master_lock" ) {
   print get_stamp () . " Detected Build System Lock File\n";
   print get_stamp () . " This may happen do to scheduled maintenance. \n";
   print get_stamp () . " Contact RWC CM Team. rwd_release\@symantec.com\n";
   print get_stamp () . " CM Team: \n";
   print get_stamp () . " To unlock, remove the file $master_lock \n";
   exit_err (1, "Build System Locked");
}

#############################################################
### Who is running us ?
#############################################################

$user = $user || $ENV{'USER'} || "release";

#############################################################
### And where are we?
#############################################################

chomp (my $groundcontrol = `hostname`);

#############################################################
### Source our config file for the given product ############
#############################################################

eval   { require "$reqdir/Defaults.pl"; };
if($@) { exit_err(1, "Errors with config file Defaults.pl\n"); }

eval   { require $configfile; };
if($@) { exit_err(1, "Errors with config file $configfile, $@\n"); }
 
#############################################################
### Figure out our build date ###############################
#############################################################

$ddir = get_build_date_next(get_build_date(), $buildroot);

unless ($ddir) {
   print get_stamp() . " Unable to generate date_dir! \n";
   exit_err(1, "Fatal error generating $ddir for use.");
}

if ($build_suffix) { $ddir = $ddir . "-" . "$build_suffix"; }

#############################################################
### Setup our logfiles for use ##############################
#############################################################

if ( b_system("$mkdir $buildroot/$ddir") ) {
   print get_stamp() . " Problems creating $ddir in $buildroot\n";
   exit_err(1, "Fatal error creating $ddir for use.");
}

my $build_all_root = "$buildroot"; # from config.
my $build_all_log  = "$build_all_root/$ddir/buildall-${ddir}.txt";
my $build_gui_log  = "$build_all_root/$ddir/guibuild-${ddir}.txt";

my $revlog     = "$build_all_root/$ddir/revlog-${ddir}.txt";
my $difflog    = "$build_all_root/$ddir/difflog-${ddir}.txt";

### eval'ing to pick up embedded code from configfile.

eval "\$statusdir= \"$statusdir\"";

#############################################################
### Redirect my output, take the onus off other programs(shell)
### to do it for me. Make command lines less ass. ###########
#############################################################

open(BLOG, ">$build_all_log") || do {
   print get_stamp() . " Failed to open $build_all_log\n";
   exit_err(1, "Cannot open my logfile! $!");
};

open(STDOUT, ">&BLOG") || do {
   exit_err(1, "Cannot dup STDOUT to BLOG ($build_all_log)! $!");
};

open(STDERR, ">&BLOG") || do {
   exit_err(1, "Cannot dup STDERR to BLOG ($build_all_log)! $!");
};

select(BLOG); $| = 1;

#################################################################

print get_stamp() . " Log file successfully opened.\n";
print get_stamp() . " This build was spun by $user.\n";

#################################################################
### Redirs for system commands ##################################
#################################################################

my $redir_null = "1>/dev/null 2>&1";
my $redir_co   = "1>>$buildroot/$ddir/checkoutlog-${ddir}.txt 2>&1";
my $redir_tag  = "1>>$buildroot/$ddir/taglog.txt 2>&1";
my $redir_pre  = "1>$buildroot/$ddir/precmd-${ddir}.txt 2>&1";
my $redir_post = "1>$buildroot/$ddir/postcmd-${ddir}.txt 2>&1";

#################################################################
### Set up my statusvar struct that gets passed around ##########
### This now sets one for the server process as per    ##########
### buildall_liveupdate.pl                             ##########
#################################################################

my %statusvar = ( 'host'      => "$groundcontrol",
                  'statusdir' => $statusdir,
                  'ddir'      => $ddir,
                  'arch'      => "",
                  'user'      => $user,
                );


#################################################################
###### Ok, here we go. ##########################################
#################################################################

splash_message ("Running buildall.pl");
print get_stamp() . " Attempting to lock [$projectname].\n";

#################################################################
### Lock the product tree. ######################################
#################################################################

my $lock     = "$buildroot/$projectname.lck";
my $rc;

my @lockinf = ();

if (! lock_file($lock) ) {

   open(LFILE, "<$lock") || do {
      exit_err(1, "Can't get lock, and can't read $lock! $!\n");
   }; 

   @lockinf = <LFILE>;
   close(LFILE);

   splash_message ("$projectname is LOCKED by another build process");
   print "Here is the lockfile\n";
   print "information:\n\n@lockinf";
   exit_err(1, "Unable to lock build for $projectname. Life sucks.");

}

print get_stamp() . " $projectname locked.\n";
print get_stamp() . " Using dir $ddir.\n";

#################################################################
### VARIABLE CODE #################################################
#################################################################

### CVS just needs 2 vars set beforehand. This is handled by the
###  set_method_vars function.
### Perforce needs a dynamically set Root: in the client view, so
###  we will set things here. 

my $coderoot = "$buildroot/$ddir/template";
#my $codemeth = get_method();
my $envvar;

my ($lbuild, $string, $nlink);

#my $cvsroot = "";
#my $cvsmod  = "";

#################################################################
### Set our placeholders for this build, and what the last #####
### build should have been. ####################################
#################################################################

if ( $tag ) {
   $lbuild = "$buildroot/lastbuild-" . $tag;
   $nlink = "newest-$tag";
}
else {
   $lbuild = "$buildroot/lastbuild";
   $nlink = "newest";
}

#################################################################
### Checkout source template for $projectname ###################
### Make the directories we'll need #############################
#################################################################

if ( b_system("$mkdir $buildroot/$ddir/template") ) {
   cleanup(1);
   exit_err(1, "Unable to mkdir for source code! $!");
}
unless ( chdir("$buildroot/$ddir/template") ) {
   cleanup(1);
   exit_err(1, "Unable to chdir to $buildroot/$ddir/template: $!");
}

#################################################################
### Check out source ############################################
#################################################################

print get_stamp() . " Final ENV initialization.\n";

unless ( code_env() ) {
   print get_stamp() . " Failed final ENV init!\n";
   cleanup(1);
   exit_err(1, "Initialization of code_env failed");
}

#################################################################
### Mark the build directory as a TAGBUILD (from a label/tag) ####
#################################################################

if ( defined($tag) && $tag ) {
   if ( open(TAGFILE,">$buildroot/$ddir/TAGBUILD") ) {
      print TAGFILE "$tag\n";
      close(TAGFILE);
   }
   else {
      print get_stamp() . " Unable to mark build as a TAGBUILD! $!\n";
   }
}

################################################################
### Mark the build directory as a VARIANT if appropriate     ###
################################################################

if ( defined($variant) && $variant ) {
   if ( open(VARFILE,">$buildroot/$ddir/VARIANT") ) {
      print VARFILE "$variant\n";
      close(VARFILE);
   }
   else {
      print get_stamp() . " Unable to mark build as a VARIANT $!\n";
   }
}


#################################################################
print get_stamp() . " Checking out source template.\n";
set_status (\%statusvar, "Checking out source template.");

### $string will be extra cmds/arguments to the appropriate
### checkout fucntion. 

my $t0 = new Benchmark;

unless ( code_co("$tag", "$redir_co") ) {
   cleanup(1);
   exit_err(1, "Error checking out master source copy. $!");
}

my $t1 = new Benchmark;

my $code_co_time = wallclock ($t1, $t0);

print get_stamp () . " Code Checkout complete [ $code_co_time ] \n";

#################################################################
### dont push if we cant tag ##################################
#################################################################

if ( $dist ) {

   ### More specific - labels must be super unique under perforce
   my $disttag = "${projectname}-dist-${ddir}";

   if ( $suffix ) {
      $disttag .= "_" . $suffix;
   } elsif ( $variant ) {
      $disttag .= "_" . $variant;
   }
        
   # print get_stamp() . " Applying " . get_method() . " tag ($disttag).\n";
   print get_stamp() . " Applying tag ($disttag).\n";

   if ( ! code_tag("$disttag", "$redir_tag") ) {
      cleanup(1);
      exit_err(1, "Unable to tag source with dist-$ddir");
   }

   if ( open(DISTFILE,">$buildroot/$ddir/.dist") ) {
      print DISTFILE "CVSTAG: $disttag\n";
      print DISTFILE "DDIR: $ddir\n";
      print DISTFILE "PROD: $projectname\n";
      print DISTFILE "VARIANT: $variant\n" if $variant;
      print DISTFILE "SUFFIX: $suffix\n" if $suffix;
      close(DISTFILE);
   }
   else {
      print get_stamp() . " Unable to drop .dist file $!\n";
   }

}

#################################################################
#### do the change diff stuff ##################################
#################################################################

print get_stamp() . " Running treerev for [$projectname].\n";

if ( ! code_treerev( "$revlog" ) ) {
   print get_stamp() . " Errors running treerev for [$projectname].\n";
}
else {
   print get_stamp() . " treerev complete for [$projectname].\n";
}

#################################################################
#### Set status treediff ########################################
#### We examine the revlog.txt from this ddir and the last ddir##
#################################################################

my ($olddir, $orevlog); 

if ( open (BT, "$lbuild") ) {
   $olddir = <BT>; chomp($olddir); close(BT);
   print get_stamp() . " Last build was [$olddir].\n";
}
else {
   print get_stamp() . " Can't read in last builddir [$lbuild]: $!\n";
}

if ( defined ( $olddir ) ) {
   $orevlog = "$buildroot/$olddir/revlog-${olddir}.txt";

   print get_stamp() . " Running treediff comparing builds.\n";

   if ( ! code_treediff($orevlog, $revlog, $difflog) ) {
      print get_stamp() . " Errors running treediff.\n";
   }
   else {
      print get_stamp() . " treediff complete.\n";
   }
}
else {
   print get_stamp() . " Diff did not work this time (no \$olddir)\n";
}

splash_message ("Finished checking out source template");

if ( defined (@precmd) ) {
   foreach my $pre (@precmd) {
      eval "\$pre= \"$pre\"";
      print get_stamp() . " Executing $pre\n";
      set_status (\%statusvar, "Executing $pre");
      if ( b_system("$pre $redir_pre") ) {
         print get_stamp() . " Error with precmd. Not continuing.\n";
         last;
      }
   }
}


#################################################################
### Copy template and Run builds ###############################
#################################################################

my %pids = (); my $pid; 
my ($enable, $eargs);

set_status (\%statusvar, "Running platform builds.");

foreach my $host (@buildhosts) {

   $enable = 1; $eargs = '';

   if (defined $perhost{$host}) {
      ($enable, $eargs) = split(/|/, $perhost{$host});
      if ($enable == 0) {
         print get_stamp() . " Host '$host' disabled. \n";
         next;
      }
      $special_gmake_args .= " $eargs";
   }
   
   $statusvar{'host'} = $host; $statusvar{'arch'} = $platforms{$host};

   if ( b_system("$ping $host $redir_null") ) {
      print "$host does not appear to be up, skipping\n";
      set_status(\%statusvar, 'failed: host is not available');
      next;
   }

   if ( $pid = fork() ) {
      ### parent
      $pids{$pid} = $host;
   } 
   elsif (defined $pid) {
      ### child
      ### Update status

      print get_stamp() . " Copying source for [$host]\n";

      set_status(\%statusvar, 'copying');

      ### make directories

      if ( b_system("$mkdir $buildroot/$ddir/$host") ) {
         cleanup (1);
         exit_err(1, "[$host child] Unable to mkdir source dir. $!");
      }

      ### chdir to host root
      if ( ! chdir("$buildroot/$ddir/$host") ) {
         cleanup (1);
         exit_err(1, "[$host child] Unable to chdir to my host directory. $!");
      }

      ### duplicate over the template dir
      ### If code_loc is defined, we need to copy the src code
      ### into that dir, else, copy the src code to host root.

      if( b_system("$cp -Rp $buildroot/$ddir/template/\* . $redir_null") ) {
         set_status(\%statusvar, 'failed: copy');
         cleanup (1);
         exit_err(1, "[$host child] Unable to copy src! $!");
      }
   
      ### make my log dir and my status dir 
      if ( ! -d 'logs' ) { 
         if ( b_system("$mkdir logs") ) {
            print "[$host] Unable to make my logs dir. $!";
         }
      } 
     
      my $logdir = "$buildroot/$ddir/$host/logs";

      if (! -d "$statusdir" ) {
         if ( b_system("$mkdir $statusdir") ) {
            print "[$host child] Unable to make my status dir. $!";
         } 
      } 

      ### run build ###############################################

      ### first, reset the status
      set_status(\%statusvar,'starting build');

      my $platform = $platforms{$host};

      print get_stamp() . " Launching build on $host [$platform]\n";

      eval " \$cmdline = \"$cmdline\" ";

      $cmdline .= ' -dist' if $dist;

      ### If configfile is in an alternative, hidsbuild later
      ### refers to this as $reqdir/$config - we need to address
      ### that later. For now, buildall's use full path. 

      if ( (defined (%maincmd)) && (defined ($maincmd{$host})) ) {

          $configfile = $maincmd{$host};

          if ( ! -f "$configfile" ) { 
             if ( ! -f "$reqdir/$configfile" ) {
                if ( ! -f "$reqdir/${configfile}.pl" ) {
                   print get_stamp() . " No '$configfile' for $host! \n";
                   next; 
                }
                else { 
                   $configfile = "$reqdir/${configfile}.pl"; 
                }
             }
             else { 
                $configfile = "$reqdir/$configfile"; 
             }
          } 
      } # End of hidsbuild compat to pickup last thing we didn't have.

      $cmdline .= " -config $configfile";

      $cmdline .= " -user $user";
 
      # Make it possible to use CNAME's and other trickery.  
      $cmdline .= " -host $host";

      $cmdline .= " -bomb $bomb"       if $bomb;
      $cmdline .= " -debug $debug"     if $debug;
      $cmdline .= " -strip $strip"     if $strip;
      $cmdline .= " -DISTTAG $suffix"  if $suffix;
      $cmdline .= " -VARIANT $variant" if $variant;
      $cmdline .= " -cvstag $tag"      if $tag;
      $cmdline .= " -special_gmake_args \"$special_gmake_args\"" if 
                   $special_gmake_args;

      $cmdline .= " -ddir $ddir";

      ### sanity echo

      print get_stamp() . " Launch: $ssh $host '$cmdline'\n";
 
      ### launch ssh process

      exec("$ssh $host '$cmdline'");

   } 
   else {
      ### fork error - when's the last time you saw one of those? ###

      print get_stamp() . " Error forking build for $host:$!\n";
      set_status(\%statusvar, 'failed: unable to launch build');

      next;
   }

   ### give it a moment so we can see startup errors

   sleep(5);

}

### When the platform builds are finished, I want the set_status
### notes to go back to $groundcontrol's status file.
$statusvar {'host'}	= $groundcontrol;

#################################################################
### set an alarm so we dont wait for pids forever #################
#################################################################

$SIG{'ALRM'} = \&handle_alarm;
alarm($alarmwait);

#################################################################
### as children exit, make note of who ############################
#################################################################

print get_stamp() . " All copies started\n";

### Dump our ddir to the lastbuild file, for treediff #############

if ( open(BT, ">$lbuild.new" ) ) {
   print BT $ddir;
   close(BT);
} 
else {
   print get_stamp() . " Could not write date to $lbuild.new. $!";
}

#################################################################
### Link to current build because jeremy is lazy ################
#################################################################

if ( -e $nlink && -l _) {
   unlink($nlink) || do {
      print get_stamp() . " Unable to remove old $nlink\n";
   };
   if ( b_system("ln -s $ddir $nlink") ) {
      print get_stmap() . " Unable to set symlink [$nlink -> $ddir]. $!\n";
   }
}

my %cstat = (); my $p;

while( $p = wait() ) {

   last if ($p == -1);

   $statusvar{'host'} = $pids{$p}; 
   $statusvar{'arch'} = $platforms{$pids{$p}};

   my $status = get_status(\%statusvar);

   print get_stamp() . " Build on host $pids{$p}";
   print " has completed [" . $status . "]\n";

   $cstat{$pids{$p}} = $status;
  
   if ($status eq 'starting build') {
      set_status(\%statusvar, 'failed: unable to launch build');
   }

   delete($pids{$p});

}

alarm(0);

print get_stamp() . " Generating build report from $0\n";
print get_stamp() . "\targs: $buildreport -config $configfile\n";

b_system("$buildreport -config $configfile");

print get_stamp() . " Done generating build report\n";

#################################################################
### Create additional links if requested ######################
#################################################################

if ( defined (%archlinks) && keys(%archlinks) ) {

   print get_stamp() . " Creating additional target links.\n";

   foreach my $xlnk ( keys ( %archlinks ) ) {
      print "$xlnk", " -> ", "$archlinks{$xlnk}";
      print " - FAILED", 
         unless symlink("$archlinks{$xlnk}", "$buildroot/$ddir/$xlnk");
      print "\n";
   }

}

#################################################################
### Run a post-compile/project command ######################
#################################################################

if ( defined (@postcmd) ) {
   foreach my $post(@postcmd) {
      eval "\$post= \"$post\"";
      print get_stamp() . " Executing $post\n";
      set_status(\%statusvar, "Executing $post"); 
      if ( b_system("$post $redir_post") ) {
         print get_stamp() . " Error with postcmd. Not continuing.\n";
         last;
      }
   }
}

##################################################################

($passfail,$failedplats) = get_cstat ();
$statusvar {'host'}	= $groundcontrol;
$statusvar {'result'}	= "$passfail";
$statusvar {'ddir'}	= "$ddir";

set_status (\%statusvar, "$passfail");

#################################################################
### Cleanup #################################################
#################################################################

cleanup(0);

#################################################################
### Send email ##############################################
#################################################################

maildone();

exit(0);

#################################################################
#################################################################


#################################################################
sub cleanup {

   my $err = shift;

   splash_message ("Beginning cleanup");

   if ( ! chdir("$buildroot") ) {
      print get_stamp() . " Unable to chdir to $buildroot: $!\n";
      print get_stamp() . " Cleanup aborted\n";
      return;
   }

   ### Clean up any rev. control related stuff (delete P4 clients ..etc)
   print get_stamp() . " Beginning cleanup routine for Source Control.\n";

   unless ( code_cleanup() ) {
      print get_stamp() . " Cleanup routine for Source Control failed!\n";
   }
   print get_stamp() . " Finished cleanup routine for Source Control.\n";

   print get_stamp () . " Removing Lock file $lock \n";
   b_system("/bin/rm -f $lock");

   ### Only move/remove if we are exiting on success.
   if ( ! $err ) {
      b_system("/bin/mv -f $lbuild.new $lbuild");
   }

   splash_message ("Cleanup done");

}

#####################################################################
### if our alarm expires, note who is still running,
### gen report and exit
#################################################################

sub handle_alarm {

   print get_stamp() . " More than $alarmwait seconds have passed\n";
   print get_stamp() . " Generating report and exiting\n";

   foreach my $k (keys(%pids)) {
      print get_stamp() . " ... " . $pids{$k} . " is still running\n";
      $statusvar{'host'} = $pids{$k};
      set_status(\%statusvar, 'failed: timeout');
   }
   print "\n";

   b_system("$buildreport -config $configfile");

   cleanup();

   exit(-1);

}

###################################################################
###
### return build status of all platforms it was spun out to
###
#################################################################

sub get_cstat {

   my $cs_retval = 'SUCCESS';
   my $FAILPLATS;

   foreach my $cs ( keys(%cstat) ) {
      next if ($cstat{$cs} =~ /^success$/);
      $FAILPLATS .= "\t$cs: $platforms{$cs}\n";
      $cs_retval = 'FAILED';
   }

   return ($cs_retval, $FAILPLATS);

}

#####################################################################
###
### use modules. they are your friend.
###
#################################################################

sub maildone {

   my $server  = '<mailserver>';
   my $sender  = '<user@some.com>';
   my $name    = 'Build Notice';
   my $baseurl = '<someurl>';
 
   my $compstat;
   my $FAILPLATS;

   ($compstat, $FAILPLATS) = get_cstat();
 
   my $subject = "$projectname Build ($ddir) completed: $compstat";
   my $rcpt    = "";

   if ( $notify ) {
      $rcpt = $notify;
   }

   if ( $bcnotify ) {
      $rcpt .= ",$bcnotify";
   }

   if ( $email ) {
      $rcpt .= ",$email";
   } 

   my $body .= get_stamp() . "\n\nBuild was spun from";

   if ($tag) {
      $body .= " tag: $tag. \n\n";
   } 
   else {
      $body .= " Trunk. \n\n";
   }

   $body .= "Build was spun by $user. \n\n\n";

   $body .= "Build failed on:\n$FAILPLATS\n" if ($compstat =~ /^FAILED$/);
   $body .= "Details of this build are available at : \n\n";
   $body .= "$baseurl/eng/$projectname/builds/summary.html\n";

   if ( ! send_email($server, $sender, $rcpt, $subject, $body) ) {
      print get_stamp() . " Error sending buildreport mail. Dumping STDOUT\n";
      print $body;
   }
 
   return;
}

######################################################################
### splash_message ()
### Purpose : Print message with date stamp and #s above and below
###           Just to clearly show the message
### Args    : String 
### Returns : None
######################################################################
sub splash_message 
{
   my $message = shift;
   my $me      = "BUILDALL";
   print get_stamp () . " ########################################";
   print "#######################################\n";
   print get_stamp () . " [$me] - $message \n";
   print get_stamp () . " ########################################";
   print "#######################################\n";
}

######################################################################

sub usage {

   print <<EOF;

$0 - Spin a build.

	-config	configfile	       [REQUIRED]
	-cvstag tag		       [OPTIONAL]
	-email "addy1,addy2"	       [OPTIONAL]
	-dist			       [OPTIONAL]
        -bomb=[ON|OFF|NOP]             [OPTIONAL]
        -strip=[ON|OFF|NOP]            [OPTIONAL]
        -debug=[ON|OFF|NOP]            [OPTIONAL]
        -build_suffix "PROFILE"        [OPTIONAL]
        -special_gmake_args "X=Y"      [OPTIONAL]

Ex:

$0 -config /home/builds/manhunt -email "someone\@somewhere.com" -dist


EOF

}
