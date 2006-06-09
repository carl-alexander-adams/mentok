### 
### Build scripts library - move commonly used functions and
### actions into here and abstract them enough to be reused
### by any and all
###
### Package VCS, Version Control Systems - attempt to wrap
### and make each product do "the right thing" when it's time
### to checkout code
###

=head1 NAME

vcs module - Version Control Subsystem

=head1 VERSION

Version 2.00

=head1 SYNOPSIS

This is the top-level 'virtualization' of a version control interface. 
It's made so that we can make simple calls like "code_co" and "code_tag"
and not have to worry about the underlying operations when we're dealing
with multiple types of source control repositories (CVS, Perforce). 

Basically, at this point you just need a 'config' file (docs to follow)
and some basic calls to a few of the functions here. You will need to have
CVS or Perforce clients installed as well and in the $PATH. 

=cut

=head1 CONFIG FILE

This particular object is an ever changing spec, so I will attempt to
nail down our latest changes. There were a few requirements from the last
rewrite that went into this. One, we wanted to be able to cleanly checkout
code from multiple repositories without having to shell out to external
scripts. Two, we wanted a way to unify our 'tagging' on code we checked
out. Three, we needed to make sure we could still 'compare' the code we
checked out to previous builds. Four, we wanted to push away from touching
or altering the contents of the Source Control Variable (SCVar) and let
the module/functions themselves do this at a lower level if necessary.

The core of the config file, as far as this module is concerned is the
'SCVar'. You can have one, or you can have many, they are to be numbered
however you see fit (SCVar1, SCVar2, SCFoo, etc), as long as they match
/^SC/. Typically, the config file which has these variables should be 
'require'ed into your $main:: scope. 

The SCVar has a few standard fields. It is a named hash, basically of

 SCVar => { SCVal1 => { var => 'value', var2 => 'value2'}, 
            SCVal2 => { foo => 'bar' }, };

Valid member variables include : 

 method
 name 
 altdir
 projectname
 revision

And several other method specific functions. Currently, we only support

 method => 'cvs'
 method => 'perforce'
 
 and

 method => 'svn',

The 'name' attribute is used inside the individual SCVar's, each one must
be unique for later parsing. The 'projectname' is used to give a global
name to the current project. The 'revision' attribute specifies a specific
revision for a particular piece. Set it to ' ' if you need to override any
revision set from the main program. A 'revision' set in the config file 
will OVERRIDE anything from the call to code_co. 

The CVS method has several variables that are special to it, including:

 _CVS_RSH
 _CVSROOT

It should be noted that anything with a preceeding _ (underscore) is treated
as an environment variable and will be set before any actions are taken (like
checking out and tagging code). _CVS_RSH sets the alternate tool to login to
the CVS repository (typically set to 'ssh' for our needs). _CVSROOT sets the
CVSROOT variable, which in our case looks a lot like:
 
 :ext:release@wopr:/cvs/blackbird

CVS has one more variable we use, the 'cvsmod' (CVS Module) variable, which
we can use to checkout a specific path or group from the CVSROOT setting.

The Perforce method has several variables that are special to it as well,
including: 

 _P4TEMPLATE
 _P4CLIENT
 _P4ROOT
 _P4USER
 _P4PASSWD

We use _P4TEMPLATE as a perforce client spec that is 'pristine', we use it
to generate a new client name, of "_P4CLIENT" . "-" . "_P4TEMPLATE". If
_P4ROOT is defined, we use this to take advantage of Perforce caching which
should decrease the network traffic. _P4ROOT should be set to a static 
directory (toplevel) which will only be used for checkouts for that 
particular p4 client spec. 

Both _P4USER and _P4PASSWD should be set to the username and the password
of the perforce user. _P4PORT should be set to the perforce server, typically
like 'host.name:1666'. 

**BETA** SUBVERSION SUPPORT.

Subversion (svn) uses a few variables of its own, I'm considering svn
support BETA at this point until I refine a few items. However, we
support:

 branch 
 tag 
 svnmod 
 base_url 
 svnmeth 

'branch' should be set to the 'branches' dir, or whatever you use to
the svn copy TO location when you make a branch. 

'tag' should be set to the 'tags' dir, or whatever you use to the svn 
copy TO location when you make a tag.

'svnmod' is the toplevel dir that you would typically use (trunk) for
your trunk/HEAD work.

'base_url' is set to the "servername/path/to/reponame" - we then use
the next item, 'svnmeth' to form up a URL - which will become a merge
of svnmeth://base_url/[branch|tag|svnmod] for checkout.

'svnmeth' - this is depending on how your Subversion server is setup,
I've tested this with svn+ssh, and it should also support 'http',
'https' and just 'svn'.

Both revision, altdir, method, and name are used/honored under the
svn method.

Finally, we also use the 'altdir' argument, which either during the checkout,
or after the checkout, the code will get copied to this location. It's assumed
that before calling 'code_co' you are in a working directory where ALL the
code will go (Unless P4ROOT is specified). The variable altdir will merely
put the code in a different place if you want it somewhere else as part of
the checkout. In the case of P4ROOT, the code will be sync'ed out to the 
usual location, and then copied into altdir. altdir is expected to be a
relative path to your working dir, though it should work as an absolute. 

=cut 

=head1 FUNCTIONS

=cut

package vcs;
require Exporter;

@ISA       = qw(Exporter);

@EXPORT    = qw(
	        code_co code_tag get_method code_env
	        code_cleanup code_treerev code_treediff 
		code_verbose code_info 
               );

@EXPORT_OK = qw();
$VERSION   = 1.50;

$vcs_verbose   = 0;

use lib qw(/home/mhall/workplay/mentok/mentok/build-harness/scripts);

use Cwd;

use svn;
use cvs;
use perforce;
use build;

### solely for setting verbose flag.
### This will have to be changed if new methods are ever
### added. 

my @methods = qw(cvs perforce svn);

####################################################################
###
### code_env
### if there needs to be specific ENV vars set, we can do them
### here. we've changed this to handle multiple methods and junk
### that need specific env's. 
###

=item B<code_env() >

This is mostly an internal function, which will set the appropriate
environment variables before performing any tagging or checkout
operations. 

=cut 

sub code_env { 

   my $lref = shift; 

   foreach $key (sort keys %{$lref}) {
      if ($key =~ /^SC/) { # new style!
         $llref = \%{$lref->{$key}};
         $method = $llref->{'method'};
         unless ( $method ) {
            print get_stamp() . " No method defined in found SCVar - FIX CONF.\n";
            return 0;
         }
         $err = &{$method . '_env'}(@_,$llref); 
         unless($err) {
            print get_stamp() . " Problems setting ENV " .
               $llref->{'name'} . " -- Aborting.\n";
            return 0;
         }
      }
   }

   return 1;

}

##################################################################
### This will perform a code checkout based on what is set in
### variables set in main of the form 'SCvar', where SCvar is
### a nice hash that has everything that needs to be set there.

### code_co should be called with 2 arguments, a revision (label)
### and a output redirector (like 1>stupidfile.txt). 

=item B<code_co($rev, $redirection) >

This is the main checkout function. It takes an optional revision
argument (Leave it as '' or undef), and a redirection option (Much
like "2>&1 1>/this/log/file.txt"). code_co will use and loop through
all SCVar's in the $main:: space and perform the appropriate actions.

=cut

sub code_co { 

   my $lref  = shift; 
   my $rev   = shift;
   my $redir = shift;
   my $found = 0;

   my ($llref);

   $new = 0;

   print "here4\n";
   
   foreach $key (sort keys %{$lref}) {
      if ($key =~ /^SC/) { # new style!
         $found = 1;
         $llref = \%{$lref->{$key}};
         $err = code_work($rev, $redir, $llref, 'co');
         unless($err) { 
            print get_stamp() . " Problems checking out " .
               $llref->{'name'} . " -- Aborting.\n";
            return 0;
         } 
      }
   }


   unless ( $found ) { 
      print get_stamp() . " No SCVar found in conf. FIX CONF.\n";
      return 0;
   }

   return 1;
  
}

#################################################################
### This is where the redundant code went. Next step would be to
### combine code_tag and code_co into one function. We'll get
### there. 

sub code_work {
 
   my $rev   = shift; 
   my $redir = shift;
   my $lref  = shift;
   my $act   = shift;
 
   if (defined ($lref->{'method'})) {
       $method = $lref->{'method'};
   }
   else {
      print get_stamp() . " No method defined!\n";
      return 0;
   }

   set_env_vars($lref);

   $err = &{$method . '_env'}($lref);

   unless ( $err ) { 
      print get_stamp() . " Problems setting ENV: Aborting $act.\n";
      return 0;
   }

   # function calls like this make the baby jesus cry. 
   $err = &{$method . "_${act}"}($rev, $redir, $lref);

   unless ( $err ) { 
      print get_stamp() . " Problem checking out: Aborting $act.\n";
      return 0;
   }

   return 1;

}

#################################################################
### Top-level tagging - 
### CVS tag will recursively do everything as long as we are properly
###   toplevel
### Perforce Tag relies on our clientspec and what we 'have' in it.

=item B<code_tag($revision, $redirection) >

This is the main tagging function, it will attempt to apply a tag
(or label) to every piece of code it can / knows about through the
SCVar's. Hopefully maintaining a unified tag across repositories if
needed.

=cut

sub code_tag { 

   my $lref  = shift; 
   my $rev   = shift;
   my $redir = shift;
   my ($llref);
                                                                                
   foreach $key (sort keys %{$lref}) {
      if ($key =~ /^SC/) { # new style!
         $llref = \%{$lref->{$key}};
         $err = code_work($rev, $redir, $llref, 'tag');
         unless($err) {
            print get_stamp() . " Problems tagging " .
               $llref->{'name'} . " -- Aborting.\n";
            return 0;
         }
      }
   }
                                                                                
   return 1;

}

sub code_cleanup { 

   my $lref  = shift;
   my $redir = shift;
                                                                                
   my ($llref);
                                                                                
   foreach $key (sort keys %{$lref}) {
      if ($key =~ /^SC/) { # new style!
         $llref = \%{$lref->{$key}};
         $err = code_work('', $redir, $llref, 'cleanup');
         unless($err) {
            print get_stamp() . " Problems cleaning up " .
               $llref->{'name'} . " -- Aborting.\n";
            return 0;
         }
      }
   }
                                                                                
   return 1;

}


###############################################################
###
### Loop through the SCvar and set any environment variables
### that need to be set (once). 
###

{


sub set_env_vars {
   my $lref = shift;
   my ($var, $val);
   foreach (keys %{$lref}) {
      if ($_ =~ /^_(.*)/) { 
         print "Setting $1 in ENV to $lref->{$_};\n" if $vcs_verbose >= 3;
         $ENV{$1} = $lref->{$_};
      }
   }
}


}

=item B<code_treerev($outfile) >

This will output a 'revision file', where there will be an entire
listing of code, plus revision number, for every file that was checked
out for each SCVar. The format should be fairly legible. See 
code_treediff for comparing the output generated by this function.

=cut

sub code_treerev {

   my $lref    = shift;
   my $outfile = shift;
   my $redir   = '';
   my ($llref);
                                                                                
   foreach $key (sort keys %{$lref}) {
      if ($key =~ /^SC/) { # new style!
         $llref = \%{$lref->{$key}};
         $err = code_work($outfile, $redir, $llref, 'treerev');
         unless($err) {
            print get_stamp() . " Problems checking out " .
               $llref->{'name'} . " -- Aborting.\n";
            return 0;
         }
      }
   }
                                                                                
   return 1;

}

### treediff, do a diff based on the revlog. keep track of our
### changing of methods based on what is fed in through the revlog.

### Make treediff use SCvar, make func to take 'name' of piece
### and return lref to that hash. 

### This was moved up from the base libs since we're really just
### doing basic file comparisons. 

=item B<code_treediff($file1, $file2, $outfile) >

This function expects 2 files, both generated from code_treerev and
will compare their differences and output that info to $outfile. 

=cut 

sub code_treediff {

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
      print get_stamp() . " [treediff] Outputfile was not defined!\n";
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

   open(OF, ">$outfile") || do {
      print get_stamp() . " [treediff] Unable to open $outfile! $!\n";
      return 0;
   };
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

   # New change, we have to do our output inline, since we will be
   # changing CVS root's on the fly (possibly). 

   my ($COUT, $AOUT);

   $COUT = "Files changed:\n-------------\n";
   $AOUT = "Files added:\n-------------\n";

   while(defined ($line = <F2>) ) {
      chomp($line);
      if ($line =~ /^#/) {
         if ($line =~ /N:(\S+)/) {
            $name = $1;
            # new method, revert.
            if ($origdir) { chdir($origdir); $orgdir = '';}
            ### XXX fix this ref to main space
            $lref = find_piece($name,\%main::SCVar);
            set_env_vars($lref);
            $method = $lref->{'method'};
            # perforce client spec name might be wrong - have p4_Treerev
            # drop the correct 'at build time' name to be picked up.
            if ($method eq 'perforce') {
               if ($line =~ /C:(\S+)/) {
                  $ENV{'P4CLIENT'} = $1;
               }
            }

            if (defined ($lref->{'altdir'})) {
               $origdir = getcwd(); chdir($lref->{'altdir'});
            }
         }
         next;
      } 

      ($file, $rev) = split(':', $line);
      next unless ($file);
      if (defined($oldfiles{$file})) {
         $oldrev = $oldfiles{$file};
         print OF "$file: [$oldrev] vs [$rev]\n" if $vcs_verbose >= 3;
         delete $oldfiles{$file};
         if ($rev cmp $oldrev) {
            $COUT .= "$file:$rev\n";
            $COUT .= &{$method . '_getlog'}($file,$rev) if $vcs_verbose;
            next;
         }
      }
      else {
         $AOUT .= "$file:$rev\n";
         $AOUT .= &{$method . '_getlog'}($file,$rev) if $vcs_verbose;
         next;
      }
   }
   close(F2);
   my $oldfh =  select(OF);

   print $COUT, "\n";
   print $AOUT, "\n";

   print "Files removed:\n-------------\n";
   foreach (sort keys %oldfiles) {
      print "$_:$oldfiles{$_}\n";
   }

   close(OF);

   select $oldfh;

   if($origdir) { chdir($origdir); }
   return 1;

}

### Either fixup or get rid of it. 
### Originally added to test being able to 'ping' the correct
### subfunctions.

sub code_test {

   return 1;                                                                                
#   set_method_vars();
#   my $method = get_method();
#   return ( &{$method . '_test'}(@_) );
                                                                                
}

#############################################################
### 
### just set our verbose flag everywhere.
###

=item B<code_verbose($verbose) >

This functions just sets a verbosity level, which typically only
matters to code_treediff, but you might get some extra output 
elsewhere. 

=cut

sub code_verbose {

   my $verb = shift;

   $vcs_verbose = $verb;

   foreach (@methods) {
      if (defined (&{$_ . '_verbose'})) {
         &{$_ . '_verbose'}($verb);
      }
   }

   return $vcs_verbose;

}

############################################################
###
### if given a 'name', return a lref that points to the correct
### piece of SCvar.
###

sub find_piece {

   my $name = shift;
   my $lref = shift;

   foreach $key (sort keys %{$lref}) {
      if ($key =~ /^SC/) { # 
         $llref = \%{$lref->{$key}};
         if ( (defined ($llref->{'name'})) && 
              ($llref->{'name'} eq $name) ) {
            return $llref;
         }
      }
   }

   # still here?  old style. now deprecated, return undef instead of $lref

   return undef;

}

#############################################################
###
### code_info 
### 
### This just dumps our SCvar info out into a flatfile for inspection
### later. Might help track down errors. Eventually, I want to spit
### out the perforce clientspecs as well. 
###

sub code_info {

   my $lref    = shift;
   my $outfile = shift;

   print get_stamp() . " Opening $outfile for info dump.\n";

   open(OUT, ">$outfile") || do { 
      print get_stamp() . " Unable to open $outfile for write. $!";
      return 0;
   };

   foreach $key (sort keys %{$lref}) {
      if ($key =~ /^SC/) { # new style!
         # maybe replace this with a method specific function later
         # ? 
         $llref = \%{$lref->{$key}};
         if (defined ($llref->{'method'})) {
            $method = $llref->{'method'};
            set_env_vars($llref);
            # do something based on method. 
            $err = &{$method . '_dump'}($outfile, $llref);
         }
         print OUT "$key -> \n";
         foreach $skey ( sort keys %{$llref} ) {
            print OUT "\t $skey -> $llref->{$skey}\n";
         }
      }
      else {
         print OUT "$key -> $lref->{$key}\n";
      }
   }
                  
   close(OUT);                                                              

   return 1;

}

=head1 EXAMPLES

Here's our current Fake config 

 %SCvar = (
          projectname => 'SomeCodeBase',
          SCvar1 => {
                    name     => 'SomeCodeBase_fromCVS',
                    method   => 'cvs',
                    cvsmod   => 'src',
                    _CVSROOT => ':ext:user@hostname:/cvs/SomeCodeBase',
                    _CVS_RSH => $ssh,
                   },
          SCvar2 => {
                    name => 'SomeCodeBase_docs',
                    method      => 'perforce',
                    revision    => ' ', # yes.
                    _P4CLIENT   => 'workingclientspec',
                    _P4TEMPLATE => 'pristinetemplateclientspec',
                    _P4PORT     => 'p4host:1666',
                    _P4USER     => 'p4user',
                    _P4PASSWD   => 'p4passwd',
                    _P4ROOT     => '/some/build/root/templates',
                   },
 );

Here's a more involved example that I used for my testing. 

 %SCvar = ( projectname => 'masscheckout',
           SCtest1 => { method   => 'cvs',
                        cvsmod   => 'Test1',
                        name     => 'Test1',
                        _CVSROOT => ':ext:mhall@mile:/cvs/test1',
                        _CVS_RSH => $ssh,
                      },
           SCtest5 => { method   => 'cvs',
                        cvsmod   => 'Test4',
                        name     => 'Test4',
                        _CVSROOT => ':ext:mhall@latenight:/tmp/cvs/test4',
                        _CVS_RSH => $ssh,
                        altdir   => 'Test1/Test4',
                      },
           SCtest7 => { method      => 'perforce',
                        name        => 'Test6',
                        _P4TEMPLATE => 'mile',
                        _P4CLIENT   => 'mile-build2',
                        _P4ROOT     => '/home/mhall/p4cache/mile-build2',
                        _P4PORT     => 'mile:1666',
                        _P4USER     => 'matt_hall',
                        _P4PASSWD   => 'foobar',
                        altdir      => 'Test1/P4',
                      },
        );



=cut


1;
