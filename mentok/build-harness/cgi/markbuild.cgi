#!/usr/local/bin/perl -w

# This file was last edited by:         $Author$
# The date was:                         $Date$
# Name of the file in repository:       $RCSFile$
# And our revision number:              $Revision$

### This script is used to list, identify, and allow you to
### change the characteristics of a named build. Most useful
### for '.keep'ing a build (preventing deletion), marking it
### symbolically (qc0, rc0), or marking it for immediate
### death '.die'. 

use lib ".";
use strict;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use Template;
use Template::Stash;
use Time::Local;
use buildCGI;

### Sanitize our path
$ENV{'PATH'} = "/bin:/usr/bin:/usr/local/bin";

### Setup our variables
my $RUSER     = $ENV{'REMOTE_USER'} || "";
my $BROOT     = '/local/apache/html/eng';
my $SROOT     = '/local/apache/html/eng/release/request/scripts';
my $buildroot = '/home/builds';
my @products;
my $dir;

# Get a list of products first
opendir (B, "$buildroot");
my @list = readdir(B);
closedir (B);
foreach (sort @list) {
   next if (-f "$buildroot/$_");          # ignores symlinks, as long as it
                                          # links to a dir.
   next if (/^scripts$/ || /^config$/);   # standard /home/builds dirs.
   next if (/^\./);                       # ignore . directories.
   next if ( /^public_html/ || /^mail$/); # skip other dirs that shouldn't be
   push (@products, $_);
}

my @states    = ('keep', 'testing', 'release', 'delete', '');

my $MARK_HEADER    = "$SROOT/FORMS/MARK_BUILD/HEADER";
my $MARK_FORM      = "$SROOT/FORMS/MARK_BUILD/BODY";
my $MARK_FOOTER    = "$SROOT/FORMS/MARK_BUILD/FOOTER";
my $MARK_GETPROD   = "$SROOT/FORMS/MARK_BUILD/GETPROD";
my $MARK_OK        = "$SROOT/FORMS/MARK_BUILD/OK";
my $MARK_ERROR     = "$SROOT/FORMS/MARK_BUILD/ERROR";

### Sort function for use in TT operations
$Template::Stash::LIST_OPS->{ sort_bydate } = sub {
   my $list = shift;
   return sort by_builddate @$list;
};

### BEGIN ##########################################

my $now = get_stamp();
my $q   = CGI->new();
my $tt  = Template->new( { ABSOLUTE => 1, } );

print $q->header();
print $q->start_html(-Title    => "Online Build Management", 
                     -BGCOLOR  => "#000000",
                     -TEXT     => "#FFFFFF",
                     -LINK     => "#000000",
                     -VLINK    => "#000000",
                     -ALINK    => "#000000",
);

my $name    = untaint($q->param('name'));
my $owner   = untaint($q->param('owner'));
my $state   = untaint($q->param('state'));
my $build   = untaint($q->param('build'));
my $product = untaint($q->param('product'));

my $var = {};

if(! $tt->process($MARK_HEADER, $var) ) {
   print "There were errors processing form $MARK_HEADER\n";
   print $tt->error();
}

### Modify build first.

if (defined($q->param('modify'))) {

   my $file = "$buildroot/$product/$build/.keep";
   $dir  = "$buildroot/$product/$build";

   unless( $product ) {
      print "Product is not defined\n";
      print $q->end_html; exit 1;
   }

   unless( auth_user($RUSER, "markbuild") ) {

      unless( auth_user($RUSER, "markbuild$product") ) {
         $var->{'error'} = "You are not allowed to mark builds. Sorry";
         if(! $tt->process($MARK_ERROR, $var) ) {
            print "There were errors processing form $MARK_ERROR\n";
            print $tt->error();
         }
         send_to_log("$RUSER tried to markbuild for $product and failed auth");
         print $q->end_html;
         exit 1;
      }

   }

   unless( $build ) {
         $var->{'error'} = "Build is not defined!";
         if(! $tt->process($MARK_ERROR, $var) ) {
            print "There were errors processing form $MARK_ERROR\n";
            print $tt->error();
         }
         print $q->end_html; exit 1;
   }

   unless( -d "$buildroot/$product/$build" ) {
         $var->{'error'} = "Build $build does not exist!";
         if(! $tt->process($MARK_ERROR, $var) ) {
            print "There were errors processing form $MARK_ERROR\n";
            print $tt->error();
         }
         print $q->end_html; exit 1;
   }

   if ( ($name) && -e "$buildroot/$product/$name" && ( $state ne '') ) {
         $var->{'error'} = "Link of dir $name already exists!";
         if(! $tt->process($MARK_ERROR, $var) ) {
            print "There were errors processing form $MARK_ERROR\n";
            print $tt->error();
         }
         print $q->end_html; exit 1;
   }

   my ($currstate,$currname) = eat_keep($file);

   if ($state eq '') {

      if ( ($currstate eq 'release' ) || ($currname =~ /-rtm/) ) {
         $var->{'error'} = "You cannot remove a released build!";
         if(! $tt->process($MARK_ERROR, $var) ) {
            print "There were errors processing form $MARK_ERROR\n";
            print $tt->error();
         }
         print $q->end_html; exit 1;
      }

      send_to_log("Clearing status for $product on build $build");
      print "Clearing status on build $build...\n";

      if ( b_sudo('root', "/usr/local/bin/delkeep $dir") ) {
         $var->{'error'} = "Unable to remove .keep from $dir!";
         if(! $tt->process($MARK_ERROR, $var) ) {
            print "There were errors processing form $MARK_ERROR\n";
            print $tt->error();
         }
      }

      if ( chdir("$buildroot/$product") ) {
         unless (b_sudo('root',"/usr/local/bin/b_unlink $name") ) {
            $var->{'success'} = "Successfully cleared status of $build";
            if(! $tt->process($MARK_OK, $var) ) {
               print "There were errors processing form $MARK_OK\n";
               print $tt->error();
            }
         }
         chdir("$SROOT");
      } else {
         $var->{'error'} = "Unable to chdir to $buildroot/$product";
         if(! $tt->process($MARK_ERROR, $var) ) {
            print "There were errors processing form $MARK_ERROR\n";
            print $tt->error();
         }
      }

   }

   elsif ( $state && write_keep($dir,$state,$name,$owner,$now) ) {

      send_to_log("Marked .keep for $dir - $state, $name, $owner");

      $var->{'success'} = "Successfully marked $product $build";
      if(! $tt->process($MARK_OK, $var) ) {
         print "There were errors processing form $MARK_OK\n";
         print $tt->error();
      }

      # 
      # when we tag mh-secupdate build as RTM, we need to
      # automatically kick off mh-erguide component build,
      # because for every security update released, we need
      # a new event reference guide. This guide is used by
      # Info Dev to convert to PDF and publish on CRT site.
      #
      # Does this really belong here?  -mhall

      if ($product eq "mh-secupdate" && $name =~ /rtm/) {
         my $kick_off = "mh-erguide";
         my $kick_off_file = "$buildroot/config/$kick_off.pl";
         my $kick_off_cmd_base = "/usr/local/bin/sudo -u release /usr/local/bin/re2cf";
         my $kick_off_cmd = "$kick_off_cmd_base $buildroot/scripts/buildall.pl -config $kick_off_file";
         my $kick_ret = system ("$kick_off_cmd > $buildroot/$kick_off/web-init.txt 2>&1 &");

         if ( ($kick_ret >> 8) == 0 ) {
            $var->{'success'} = "Kicked off $kick_off build";
            if(! $tt->process($MARK_OK, $var) ) {
               print "There were errors processing form $MARK_OK\n";
               print $tt->error();
            }
         }

      }

      unless ( chdir("$buildroot/$product") ) {
         $var->{'error'} = "Failed to chdir to $buildroot/$product";
         if(! $tt->process($MARK_ERROR, $var) ) {
            print "There were errors processing form $MARK_ERROR\n";
            print $tt->error();
         }
      }
      else {

         if ($state eq 'delete') {
            send_to_log("$RUSER marked $build for delete (.kill)");
            system("touch $buildroot/$product/$build/.kill");
         }

         if ( ($name ne $currname) ) {

            if ($currname ne "") {
	       if ( b_sudo('root', "/usr/local/bin/b_unlink $currname") ) {
                  $var->{'error'} = "Error removing old [$currname]: $! ";
                  if(! $tt->process($MARK_ERROR, $var) ) {
                     print "There were errors processing form $MARK_ERROR\n";
                     print $tt->error();
                  }
               }
               else {
                  $var->{'success'} = "Removed old link [$currname]";
                  if(! $tt->process($MARK_OK, $var) ) {
                     print "There were errors processing form $MARK_OK\n";
                     print $tt->error();
                  }
               }
            }

            if ($name) {
	        if ( b_sudo('root', "/usr/local/bin/b_symlink $build $name") ) {
                  $var->{'error'} = "Failed to create sym link [$name] -> [$build]";
                  if(! $tt->process($MARK_ERROR, $var) ) {
                     print "There were errors processing form $MARK_ERROR\n";
                     print $tt->error();
                  }
               }
               else {
                  send_to_log("$RUSER created sym link $name -> $build");
                  $var->{'success'} = "Linked [$name] -> [$build]";
                  if(! $tt->process($MARK_OK, $var) ) {
                     print "There were errors processing form $MARK_OK\n";
                     print $tt->error();
                  }
               }
            }

         } ### name is not equal newname
 
      } ### else chdir succeeded

      chdir("$SROOT");

   }
   else {
         $var->{'error'} = "Error writing a .keep file for $dir";
         if(! $tt->process($MARK_ERROR, $var) ) {
            print "There were errors processing form $MARK_ERROR\n";
            print $tt->error();
         }
   }

   footer();

   print $q->end_html;

   exit 0;

}

### Begin display of default form.

$var = {
   products  => \@products,
};

if ($q->param('product')) { $var->{'selected'} = $q->param('product'); }

if(! $tt->process($MARK_GETPROD, $var) ) {
   print "There were errors processing form $MARK_FORM\n";
   print $tt->error();
}

if ($q->param('product')) {

   my $p = $q->param('product');
   my (@files, @dirs) = ();
   my $PRUNE_AFTER    = 0;

   opendir(DIR,"$buildroot/$p") || do {
      print "Unable to opendir $buildroot/$p! $!";
      next;
   };

   @files = grep !/^\./, readdir(DIR);
   closedir(DIR);

   open(PR, "<$buildroot/config/$p.pl") || do {
         $var->{'error'} = "Failed to get configuration of $p";
         if(! $tt->process($MARK_ERROR, $var) ) {
            print "There were errors processing form $MARK_ERROR\n";
            print $tt->error();
         }
   };

   while(<PR>) {
      if (/^\$PRUNE.*?=\s*(\d+)/) {
         $PRUNE_AFTER = $1;
      }
   }
   close(PR);

   $PRUNE_AFTER = $PRUNE_AFTER || 5;

   my %build = ();

   foreach my $f (@files) {
      # looks like 2001-11-25_1
      next unless ($f =~ /(\d+)\-(\d+)\-(\d+)_\d+/ &&
                   -d "$buildroot/$p/$f" && (! -l "$buildroot/$p/$f"));
  
      my $timestamp = timelocal(0,0,0,$3,($2-1),$1);
      my $modtime   = int(($^T-$timestamp)/(60*60*24));

      my ($state,$name,$owner) = eat_keep("$buildroot/$p/$f/.keep");

      # putting this into a form the TT can sort easily on

      $build{$f}{'state'} = $state;
      $build{$f}{'name'}  = $name;
      $build{$f}{'owner'} = $owner;
      $build{$f}{'prune'} = ( ((! $state ) && ($modtime > ($PRUNE_AFTER - 1))) || ($state eq "delete") );
      $build{$f}{'build'} = $f;

      if (-f "$buildroot/$p/$f/BUILDNUMBER") {
         if (open (BN, "<$buildroot/$p/$f/BUILDNUMBER")) {
            chomp($build{$f}{'ebid'} = <BN>);
            close (BN);
         }
      }
   }

   $var = { env    => \%ENV,
            build  => \%build,
            prod   => $p,
            pday   => $PRUNE_AFTER,
            states => \@states,
          };

   if(! $tt->process($MARK_FORM, $var) ) {
      print "There were errors processing form $MARK_FORM\n";
      print $tt->error();
   }
  
}

footer();

print $q->end_html;

exit 0;

###########################################################

sub footer {


   if(! $tt->process($MARK_FOOTER, $var) ) {
      print "There were errors processing form $MARK_FOOTER\n";
      print $tt->error();
   }

}

sub by_builddate {

   my (@a1) = split(/\D+/, $a);
   my (@b1) = split(/\D+/, $b);

   my $ele;

   foreach $ele (@a1) {
      unless ($ele =~ /^0/) { ($ele < 10) ? ($ele = "0" . $ele) : 1; }
   }
   foreach $ele (@b1) {
      unless ($ele =~ /^0/) { ($ele < 10) ? ($ele = "0" . $ele) : 1; }
   }

   return ( (join("",@a1)) <=> (join("",@b1)) );

}

