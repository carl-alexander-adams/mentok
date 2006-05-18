package buildCGI;
require Exporter;

# This file was last edited by:         $Author$
# The date was:                         $Date$
# Name of the file in repository:       $RCSFile$
# And our revision number:              $Revision$

### Fcntl is needed for file locking

use Fcntl;

### Main definitions

our @ISA       = qw(Exporter);
our @EXPORT    = qw(auth_user send_to_log get_build_products auth_user_defs 
		    untaint get_stamp eat_keep write_keep b_system b_sudo
                    exit_err
                   );
our @EXPORT_OK = qw();
our $VERSION   = "1.3";

our $auth_file   = "/local/apache/conf/passwd/auth_file";
our $cgi_logfile = "/local/apache/logs/cgi_logs/cgilog";
our $sudo = '/usr/local/bin/sudo';
our %rules = ();
our %users = ();

############################################################
###
### auth_user
### check for authentication of the user to access the named
### authval, typically a product or component the user is
### requesting access to through a cgi
###

sub auth_user {

   my $user    = shift;
   my $authval = shift;

   if( ! parse_auth_file() ) {
      print STDERR "Errors with authentication!\n";
      return 0;
   }

   if ( defined ($users{$user}) &&
        is_in   ($authval, $users{$user}) ) {
      return 1;
   }

   return 0;

}

#############################################################
###
### auth_user_defs
### this will return what a user is allowed to build
###

sub auth_user_defs {
   
   my $user = shift;

   if( ! parse_auth_file() ) {
      print STDERR "Errors with authentication!\n";
      return 0;
   }

   if ( defined ($users{$user}) ) {
      return expand($users{$user});
   }
   
   return "";

}    

###########################################################
###
### parse_auth_file
### do basic opening, reading, and entering of data from
### the auth file into our internal datastructures.
###

sub parse_auth_file {
  
   my $line     = "";
   my $group    = "";
   my $groupdef = "";
 
   open(FILE, "$auth_file") || do {
      print STDERR "Unable to open authentication file for read. $!\n";
      return 0;
   };

   while( defined ($line = <FILE>) ) {
      chomp($line);

      next unless($line);
      next if ($line =~ /^#/);
      next if ($line =~ /^ /);

      if($line =~ /^G/) {
         ($group, $groupdef) = $line =~ /^G(\w+):(.*)$/;
         $groupdef =~ s/^ //;
         $rules{$group} = $groupdef;
      }

      elsif ($line =~ /^U/) {
         ($user, $ugroup) = $line =~ /^U(\w+):(.*)$/;
         $ugroup =~ s/^ //;
         $users{$user} = $ugroup;
      }
 
      else {
         print STDERR "Unknown line \"$line\" in auth_file.\n";
      } 

   }

   close(FILE);

   return 1;

}

##################################################################
###
### is_in
### this function takes the parsed data from the auth file that
### was stored in %rules and %users, and does rule expansion down
### to a base case, and then sees if the authval is in the groups
###

sub is_in {

   my $authval = shift;
   my $groups  = shift;

   my $killswitch = 0; 

   my @tokens = expand($groups);

   foreach my $token (@tokens) {
      if ($authval eq $token) {
         return 1;
      }
   }

   return 0;

} 

##################################################################
###
### expand
### this takes a token list, and expands it out to no longer have
### macro tokens
###


sub expand {
   
   my $groups     = shift;
   my $killswitch = 0; 

   my @tokens = split(/ /, $groups);

   loop: {

      # protect against looping in conf file
      $killswitch++;
      if($killswitch > 99) {
         print STDERR "Killswitch limit reached. Loop in auth file?\n";
         last loop;
      }

      # weed out !nots first
      foreach my $token (@tokens) {
         next unless $token;
         if($token =~ /^!(#.*#)/) {
            my $not = $1;
            foreach (@tokens) {
               if (s/$not//) { $token = ""; redo loop; }
            }
         }
      }

      # do rule replacement
      foreach my $token (@tokens) {
         next unless $token;
         if($token =~ /^#(.*)#/) {
            my $var = $1;
            if(defined ($rules{$var})) {
               $token = "";
               my @all = split(/ /, $rules{$var});
               foreach (@all) { push @tokens, $_; }
               redo loop;
            }
            else {
               print STDERR "Unknown symbol $token\n";
            }
         }
      }

   }

   # clean up any nulls
   for(my $i = $#tokens; $i >= 0; $i--) {
      if($tokens[$i] eq "") { splice(@tokens,$i,1); }
   }

   return @tokens;

}

########################################################
###
### eat_keep
### legacy function to digest contents of a .keep file
### that builds are tagged with
###
     
sub eat_keep {

  my ($file) = shift;
  my ($state,$name,$owner,$date,$line);
  open (FILE, "$file") || do {
     return;
  };

  $state='keep';

  while(defined ($line = <FILE>) ) {
      if ($line =~ /^state: (.+)/) {
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
      else {
         print STDERR "Unknown line $line in keep file!\n";
      }    
  } 
  close(FILE);

  return ($state, $name, $owner, $date);

} 

##############################################################
###
### write_keep
### legacy function to write out a keep file with important
### information that we use later in the markbuild script
### to display things pretty.
###

sub write_keep {

  my ($dir,$state,$name,$owner,$date) = @_;
  my ($file) = "$dir/.keep";

  system("/usr/local/bin/sudo -u root /usr/local/bin/mkkeep $dir");

  open(FILE, ">$file") || do {
     print "Could not open $file for writing! $!\n";
     return 0;
  };

  print FILE "state: $state\n";
  print FILE "name: $name\n";
  print FILE "owner: $owner\n";
  print FILE "date: $date\n";

  close(FILE);

  return 1;

}


################################################################
###
### builddate
### sort based on a number like '2002-4-29_1'
###

sub builddate {

  # WTF? The function works, yet it SPEWS warnings.
  no warnings qw(uninitialized);

  my ($ay, $am, $ad, $an);
  my ($by, $bm, $bd, $bn);

  $ay = $am = $ad = $an = "";
  $by = $bm = $bd = $bn = "";

  ($ay,$am,$ad,$an) = split(/\D/,$a);
  ($by,$bm,$bd,$bn) = split(/\D/,$b);

  return ($ay <=> $by) unless ($ay <=> $by);
  return ($am <=> $bm) unless ($am <=> $bm);
  return ($ad <=> $bd) unless ($ad <=> $bd);
  return ($an <=> $bn);

#  return ($ay <=> $by) if (($ay <=> $by) != 0);
#  return ($am <=> $bm) if (($am <=> $bm) != 0);
#  return ($ad <=> $bd) if (($ad <=> $bd) != 0);
#  return ($an <=> $bn);

}

#########################################################
###
### send_to_log
### send a line of data to the cgilog file by default,
### or to the logfile of choice. uses simple locking
### mechanism to try to avoid race conditions
###

sub send_to_log {

   my $data      = shift;
   my $file      = shift || "$cgi_logfile";
   my $locked    = 0;
   my $tries     = 0;
   my $max_tries = 10;

   foreach ($tries .. $max_tries) {
      $ret = lock_file("$file.lck");
      if ( ! $ret ) {
         sleep 1;
         next;
      }
      $locked = 1;
      last;
   } 
  
   if (! $locked ) {
      print STDERR "Unable to lock $file.lck file!\n";
      return 0;
   }

   open(FILE, ">>$file") || do  {
      print STDERR "Unable to open up $file for append! $!\n";
      return 0;
   };

   my $tstamp = get_stamp();

   print FILE "[$tstamp] $data\n";

   close(FILE);

   unlock_file("$file.lck");

   return 1;
} 

##############################################################
###
### lock_file
### creates a lockfile in a safer manner
###

sub lock_file {

   my $lockfile = shift;

   return 0 if -e $lockfile;

   sysopen(HANDLE, $lockfile, O_WRONLY|O_CREAT|O_EXCL, 0666) || do {
      return 0;
   };

   print HANDLE "$$ " . localtime(time) ."\n";

   return 1;

}

#####################################################################
###
### unlock_file
### removes a lockfile
###

sub unlock_file {

   my $lockfile = shift;
   if ( -f "$lockfile" ) {
      unlink($lockfile);
   }

} 

##################################################################
###
### get_build_products
### returns a listing of the directories which have a 'builds'
### directory in them, following the convention we have
###

sub get_build_products {

   my $path    = shift;
   my @product = ();

   opendir(DIR, "$path") || do {
      print STDERR "Unable to open $path for build search\n";
      return undef;
   };

   my @items = grep !/^\./, readdir DIR;

   closedir(DIR);

   foreach my $item (@items) {
      push (@product, $item) if (-e "$path/$item/builds");
   }

   return sort @product;
} 

###########################################################
###
### get_stamp
### formulate a date string and return a pretty date stamp
### at the time we are called
###

sub get_stamp {

   my($sec, $min, $hour, $mday, $mon, $year);

   ($sec,$min,$hour,$mday,$mon,$year) = localtime(time());

   ($hour < 10) ? $hour = "0" . $hour : 0;
   ($min < 10)  ? $min  = "0" . $min  : 0;
   ($sec < 10)  ? $sec  = "0" . $sec  : 0;

   $mon++; $year += 1900;

   return "$hour:$min:$sec $mon/$mday/$year";

}

#############################################################
###
### untaint
### simple untaint, weed out certain characters, and then
### only grab A-Za-z @ _ - . 
###

sub untaint {

   my $tainted = shift;
   my $safer   = "";

   return unless $tainted;

   $tainted =~ s/&\[\];\?\*\x00\r\n//g;
   $tainted =~ m#^([A-Za-z\@\_\-\.\/\d\s\=]+)$#;
   $safer   = $1;

   return $safer;
}

###############################################################
###
### Simple exit sub for when we aren't using forms
###

sub exit_err {
   my $code    = shift;
   my $message = shift || "";

   print "Exiting: $code\n<BR>";
   print "$message\n<BR>" if $message;
   exit $code;
}

################################################################
###
### Simple wrapper call for system calls and sudo calls
### See also the visudo/sudoers stuff on bothered
###

sub b_system {
                                                                                
   my @args = @_;

   my $rc   = system(@args);
   my $a_rc = $rc >> 8;

   return $a_rc;

}

sub b_sudo {

   my $user = shift;
   my $cmd  = shift;

   my $rc = b_system("$sudo -u $user $cmd ");

   return $rc;

}


1; 
