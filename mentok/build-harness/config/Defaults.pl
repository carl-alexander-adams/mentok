
###########################################################
###
### Environment
###
###########################################################

$ENV{'PATH'}       = "/bin:/usr/bin:/usr/local/bin:/usr/ucb:/usr/ccs/bin:/sbin:.";
$ENV{'BS_VERBOSE'} = 2;
umask(022);

###########################################################
###
### General info we find and cache for later use. 
###
###########################################################

($sysname, $nodename, $release, $version, $machine) = POSIX::uname();

$defaults{'uname'} = "$sysname $release $machine";

$arch     = $sysname; $arch =~ s/ /\-/g;
$defaults{'arch'}  = $arch;

$host     = hostname(); $host =~ m#^([A-Za-z0-9_-]*)#; $host = $1;
$defaults{'host'} = $host;

($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time());
$defaults{'year'}  = $year + 1900;
$defaults{'month'} = ($mon < 10 ? $mon = "0" . $mon : $mon);
$defaults{'month'}++;
$defaults{'day'}   = ($mday < 10 ? $mday = "0" . $mday : $mday); 

$defaults{'transport'} = get_ssh(); 
$defaults{'transport_port'} = 22;

$defaults{'make'}      = '/usr/local/bin/gmake';

###########################################################
### From $project config
###########################################################

$defaults{'alarmwait'}    = 60 * 180; # 180 mins
$defaults{'toolsdir'}     = '/home/builds/scripts';
$defaults{'buildtool'}    = "$defaults{'toolsdir'}/runbuild.pl";
$defaults{'buildreport'}  = "$defaults{'toolsdir'}/buildreport.pl";
$defaults{'wbtb'}         = "$defaults{'toolsdir'}/wbtb.pl";
$defaults{'cmdline'}      =  $defaults{'buildtool'};
$defaults{'prune_after'}  = 5;

$defaults{'mailserver'}   = "mail";
$defaults{'sender'}       = "build-user";
### We append $projectname/summary.html to baseurl later.
$defaults{'baseurl'}      = "http://devserver/builds";


###########################################################
### This will be the default client build
### sequence for all products. If a particular
### product has different needs, re-define
### this array in <product>.pl
###########################################################
### [dir] [sudo] [command] [args] [targets]
###########################################################

### define this in product config 
@client_build_sequence = ( ); 

###########################################################
### FUNCTIONS
###########################################################

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
