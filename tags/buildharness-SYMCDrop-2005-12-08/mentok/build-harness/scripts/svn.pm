
######################################################
# Hi! I'm a comment! You'll be seeing more of me in the
# near future! 

# This file was last edited by: 	$Author$
# The date was:				$Date$
# Name of the file in repository:	$RCSFile$
# And our revision number:		$Revision$

### 
### Build scripts library - move commonly used functions and
### actions into here and abstract them enough to be reused
### by any and all
###

package svn;
require Exporter;

use Cwd;

@ISA       = qw(Exporter);

@EXPORT    = qw(
	        svn_env svn_log svn_status svn_getlog
	        svn_co svn_tag svn_cleanup svn_treerev svn_treediff
                svn_verbose svn_dump
               );

@EXPORT_OK = qw();
$VERSION   = 1.10;

use lib qw(/home/builds/scripts);
use build;

my $svn = '/usr/local/bin/svn';
my $svn_verbose = 0;

#############################################################
###
### svn_status - Get the cvs status of a file, makes the
### assumption that the correct CVSROOT and CVS_RSH envs
### are set, we should make this part of a cvs perl lib at
### some point
###
### REQUIRES file
### RETURNS Revision plus checkin history

sub svn_status {

   my $file = shift;

   my $cstat;
   my $rev;
   my $clog;

   return undef, unless ($file);

   open(CS, "$svn status -u $file 2>&1 | ") || do {
      print get_stamp() . "Can't cvs status $file! $! \n";
      return undef;
   };

   while (defined ($cstat = <CS>) ) {
      ($rev = $2) if ( $cstat =~ m#^(.){6}\s+(\d+)\s+# );
   }
   close(CS);

   if ( defined($rev) && ($rev) ) {
      $clog = svn_log($file, $rev);
      return "SVN log of last check-in of $file :\n\n $clog";
   }

}

###################################################################
###
### svn_log - grab the svn log output from a particular file
###
### REQUIRES file and rev
### RETURNS checkin history

sub svn_log {

   my $file = shift;
   my $rev  = shift;

   my $ret;
   my $clog;

   return undef unless ($file && $rev);

   open (CLOG, "svn log -r$rev $file 2>&1 | " ) || do {
      return "Unable to get CVS log of file $file! $!\n";
   };

   while ( defined ($clog = <CLOG>) ) {
      $ret .= $clog;
   }
   close(CLOG);

   return $ret;

}

##########################################################
###
### svn_env 
### This is just a stub now, ENV work is done elsewhere. 
###

sub svn_env {

   return 1; 

}

sub svn_co { 

   my $revision = shift;
   my $redir    = shift || ""; 
   my $scvar    = shift;

   my $cmd = "$svn checkout ";

   # at this point, a hardcoded revision overrides any passed
   # revisions. You put it in the conf file for a reason, right? 

   # Later include a lookup to a revision table, with 
   # name->revision ... SCVar should have a 'name' field.

   # form up URL to checkout from. 

   my $url = '';

   if (defined $scvar->{'svnmeth'}) {
      if (defined $scvar->{'base_url'}) {
         $url = $scvar->{'svnmeth'} . "://" . $scvar->{'base_url'};
      }
      else {
         print get_stamp() . " No 'base_url' set for checkout\n";
         return 0;
      }
   }
   else {
      print get_stamp() . " No 'svnmeth' set for checkout\n";
      return 0;
   }

   # now here, should have URL. 

   # This is where things get odd. We want to know what path we
   # checked out for future operations, and the checkout can come
   # from any path, really. Whether a virtual 'tags' dir, or a 
   # virtual 'branches' dir, or the 'trunk' real dir. 

   # So the assumptions are made to shoe-horn this in : 
   # If revision is defined (named word branch), it's a branch. 
   # If revision is defined and it's a number, it's a commit # and
   # we pull from 'trunk'
   # If revision from user is defined (named word branch), it's a branch.
   # Otherwise, we use 'svnmod' (trunk) from config as checkout point. 

   # So this means to get a named word revision, that's just a tag, 
   # the 'branch' item in the SCVar should be changed to 'tags'.
   # We /rarely/ checkout a build from a tag, mostly important branches.
   
   # This becomes useful later for auto-tagging / doing tags.

   if (defined $scvar->{'revision'}) {
      if (defined $scvar->{'branch'}) {
         $url .= "/" . $scvar->{'branch'} . "/" . $scvar->{'revision'}; 
         $scvar->{'_svnpath'} = $scvar->{'branch'} . "/" . $scvar->{'revision'};
      }
      else {
         print get_stamp() . " Rev defined, but no branch dir in cfg.\n";
         return 0;
      }
   }
   elsif ( $revision =~ /^\d+$/ ) { # lone number equals tag or branch
                                    # but we have to know mapping. 
      $cmd .= " -r $revision ";
      $url .= "/" . $scvar->{'svnmod'};
      $scvar->{'_svnpath'} = $scvar->{'svnmod'}; 
   }
   elsif ( $revision ) { # named revision assumed
      if (defined $scvar->{'branch'}) {
         $url .= "/" . $scvar->{'branch'} . "/" . $revision; 
         $scvar->{'_svnpath'} = $scvar->{'branch'} . "/" . $scvar->{'revision'};
      }
      else {
         print get_stamp() . " Rev defined, but no branch dir in cfg.\n";
         return 0;
      }
   }
   elsif ( defined $scvar->{'svnmod'} ) {
      # if we're here, we're a trunk checkout, revs take priority
      # assumed against branch. 
      $url .= "/" . $scvar->{'svnmod'};
      $scvar->{'_svnpath'} = $scvar->{'svnmod'}; 
   }

   $cmd .= " $url ";         

   my ($tardir, $curdir) = '';

   if (defined $scvar->{'altdir'}) {
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

   print get_stamp() . " ### Beginning SVN Checkout from $url\n";

   if ( b_system("$cmd $redir") ) {
      print get_stamp() . " +++ SVN co of source failed. \n";
      if ($tardir) { chdir $curdir; }
      return 0;
   }

   if ($tardir) { chdir $curdir; }

   return 1;

}

sub svn_tag { 

   my $args   = shift; # this is the revision
   my $redir  = shift;
   my $scvar  = shift; 

   my ($tardir, $curdir) = '';

   my $url = '';
                                                                                
   if (defined $scvar->{'svnmeth'}) {
      if (defined $scvar->{'base_url'}) {
         $url = $scvar->{'svnmeth'} . "://" . $scvar->{'base_url'};
      }
      else {
         print get_stamp() . " No 'base_url' set for tag\n";
         return 0;
      }
   }
   else {
      print get_stamp() . " No 'svnmeth' set for tag\n";
      return 0;
   }
                                                                                
   # now here, should have URL.
                                                                                
   if ( $args ) { # named revision assumed
      if (defined $scvar->{'tag'}) {
         $url .= "/" . $scvar->{'tag'} . "/" . $args;
      }
      else {
         print get_stamp() . " Rev defined, but no tag dir in cfg.\n";
         return 0;
      }
   }

   if (defined $scvar->{'altdir'}) {
      $tardir = $scvar->{'altdir'};
      $curdir = getcwd();
      unless ( chdir($tardir) ) {
         print get_stamp() . " Unable to chdir to altdir $altdir for co\n";
         return 0;
      }
   }

   # need to figure out local path to tag.

   my $tagpath = '';

   if (defined $scvar->{'_svnpath'}) { 
      $tagpath = $scvar->{'_svnpath'};
   }
   else { # form from revision ? 
          # we have to assume we are tagging based on a checked out src.
          # IE, code_co happened, because we need the _svnpath to figure
          # out what (branch/code_name) or (trunk) was checked out - 
          # this should be addressed in a rewrite XXX

      print get_stamp() . " Tagging without checkout info (in error?)\n";
      $tagpath = $scvar->{'svnmod'};
   }

   my $auto = " -m \" auto-tag from build harness \" ";
   
   if ( b_system("$svn copy --non-interactive $tagpath $url $auto $redir") ) {
      print get_stamp() . " +++ SVN tag of source failed. \n";
      if ($tardir) { chdir $curdir; }
      return 0;
   }
                                                                                
   if ($tardir) { chdir $curdir; }

   return 1;

}

sub svn_cleanup { 

   ### SVN doesn't need to cleanup after itself.

   return 1;

}

############################################################
### svn_treerev - find the revisions of all files in the 
### source tree.
### At this point we hope we're in the top level dir.

sub svn_treerev {

   my $logfile = shift;
   my $empty   = shift; ## compat'ing with code_work from vcs.pm
   my $lref    = shift;

   if ( ! $logfile ) {
      print get_stamp() . " [svn_treerev] Logfile not specified!\n";
      return 0;
   }

   if (-f "$logfile") { 
      print get_stamp() . " [svn_treerev] Opening logfile for APPEND\n";
   }

   open (LF, ">>$logfile") || do {
      print get_stamp() . " [svn_treerev] Unable to open $logfile! $!\n";
      return 0;
   };

   # Drop this hint line to our revlog output.

   if (defined ($lref->{'name'})) {
      print LF "# M:SVN N:$lref->{'name'}\n"; 
   }

   if (defined ($lref->{'altdir'})) { $altdir = $lref->{'altdir'}; }
   if($altdir) { $origdir = getcwd(); chdir ($altdir); }

   my $svnpath = '';

   # we may have to enforce this, strict co first op, then everything
   # can flow from there. this is for /auto/ checkout / tagging after
   # all. 

   # XXX fix this to some default

   if (defined $lref->{'_svnpath'}) { 
      $svnpath = $lref->{'_svnpath'};
   }      

   open(CSTAT, "$svn -uv status $svnpath | ") || do { 
      print get_stamp() . " [svn_treerev] Could not run svn status: $!\n";
      if($altdir) { chdir ($origdir); }
      return 0;
   };

   my ($line, $rev, $file, %files, $cvsmod);
   my (@moddirs, @filedirs, $fail, $i);

   while( defined($line = <CSTAT>) ) {

      next unless ($line =~ /^(.){6}\s+(\d+)\s+(\d+)\s+(\w+)\s+(.*?)$/);

      # i'm assuming that last edited rev is the real rev here,
      # since otherwise it would all be the same. IE, revs# in
      # svn are not "revision #X of file.c", but 
      # "file.c as it appears in revision #X of the repo"

      $rev = $3; $file = $5;

      $type = $1; # may have to make some decisions here.

      ### trim off the leading slash (for proper treediff)
      $file =~ s#^/##;
      
      ### avoid strange dups...
      next if (defined($files{$file}));

      $files{$file}++;

      print LF "$file:$rev\n";
   }
   close(CSTAT);
   close(LF);
   
   if($altdir) { chdir ($origdir); }

   return 1;

}

#############################################################
###
### this is obsoleted and work is done at the vcs level now.
###

sub svn_treediff {
   return 1;
}


sub svn_getlog {

   my ($file, $rev) = @_;
   my ($line, $comment);


   print get_stamp() . "Getting svn filelog for ${file}#${rev}\n" if
      $svn_verbose >=2;

   open(LOG, "svn -q log -r$rev $file|") || do {
      print get_stamp() .
         " [treediff] Unable to open cvs log for rev $rev and file $file\n";
      return;
   };

   while(defined ($_ = <LOG>) ) {
      last if (/^--/);
   }
   while(defined ($line = <LOG>) ) {
      if ($line =~ /^--/) {
         $comment .= "\n";
         last;
      }
      $comment .= $line;
   }
   close(LOG);

   return $comment;
}

sub svn_verbose {

   my $verb = shift;

   $svn_verbose = $verb;

   return $svn_verbose;

}

sub svn_dump {
 
   return 1;

}

1;
