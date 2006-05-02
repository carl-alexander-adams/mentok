
###########################################################
###
### Defaults to be sourced in by buildall and runbuild
###
###########################################################

$ENV{'PATH'} = "/bin:/usr/bin:/usr/local/bin:/usr/ucb:/usr/ccs/bin:/sbin:.:$ENV{'PATH'}";

# New build3.5 feature - we want verbose for tracking down errors.
$ENV{'BS_VERBOSE'} = 2;

umask(022);

###########################################################
### Needed for Sun compilers and Purify
###########################################################

$ENV{'LM_LICENSE_FILE'} = '1726@<somehostname>';

###########################################################
### From buildall
###########################################################

$uname    = 'uname -smr';

$ping      = get_ping(); 
$cp        = get_cp();
$ssh       = get_ssh(); 

$hostname = 'hostname';
$mkdir    = '/bin/mkdir -p -m 0755';
$gmake    = '/usr/local/bin/gmake';
$sudo     = '/usr/local/bin/sudo';
$p4       = '/usr/local/bin/p4';

###########################################################
### Vars used by the Web CGI scripts
### These may be over-written by product config files
###########################################################
#$cgi_bcmd = "/home/builds/scripts/buildall.pl";

###########################################################
### derived stuff
###########################################################

chomp($arch = `$uname`); $arch =~ s/ /\-/g;
chomp($host = `$hostname | cut -d. -f1`);
$numcpu     = get_proc_info ($arch);

###########################################################
### From $project config
###########################################################
$toolsdir     = '/home/builds/scripts';
$buildtool    = "$toolsdir/runbuild.pl";
$buildreport  = "$toolsdir/buildreport.pl";
$platinfo     = "$toolsdir/platforminfo.pl -v";
$platlinks    = "$toolsdir/makeplatformlinks.pl";
$wbtb         = "$toolsdir/wbtb.pl";
$alarmwait    = 60*180; # 180 mins
$cmdline      = "$buildtool";
$dateVer      = getDateVersion();

$PRUNE_AFTER = 5;

###########################################################
### This will be the default client build
### sequence for all products. If a particular
### product has different needs, re-define
### this array in <product>.pl
###########################################################
### [dir] [sudo] [command] [args] [targets]
###########################################################

@client_build_sequence = (
        [ "", "", "$gmake", "", "" ],
        [ "", "", "$gmake", "", "package" ],
);


# re - release engineering
$re = '<a href="mailto:email@somewhere">Set your Email Address for RE</a>';

###########################################################
### FUNCTIONS
###########################################################

sub get_proc_info {
   
   my $arch   = shift;
   my $numcpu = 1;

   if ($arch =~ /SunOS/) {
      chomp($numcpu = `uname -X | grep NumCPU | awk -F" " '{print \$3}'`);
   } elsif ($arch =~ /Linux/) {
      chomp($numcpu = `cat /proc/cpuinfo | grep processor | wc -l`);
   }

   return $numcpu;

}

###########################################################

sub getDateVersion {

   my $date = `date +%Y-%m-%d`;
   chomp ($date);
   $date = $date || "UNKNOWN";
   return $date;

}

sub get_ping {

   my $arch  = '';
   my $pargs = '';
   my $ping  = '';

   chomp($arch = `$uname`); $arch =~ s/ /\-/g;

   if ($arch =~ /Linux/) {
      $pargs = " -c 1 ";
   }

   my @locations = qw(/usr/sbin/ping /bin/ping /sbin/ping);

   foreach (@locations) {
      if ( -x $_ )  {
         $ping = $_;
         last;
      }
   }

   return ($ping . $pargs);

}


sub get_cp {

   my $cp = '';

   my @locations = qw(/usr/bin/cp /bin/cp);

   foreach (@locations) {
      if ( -x $_ )  {
         $cp  = $_;
         last;
      }
   }
                                                                                      
   return ($cp);

}

sub get_ssh {

   my $ssh = '';

   my @locations = qw(/usr/local/bin/ssh /usr/bin/ssh /bin/ssh);

   foreach (@locations) {
      if ( -x $_ )  {
         $ssh  = $_;
         last;
      }
   }

   return ($ssh);

}
