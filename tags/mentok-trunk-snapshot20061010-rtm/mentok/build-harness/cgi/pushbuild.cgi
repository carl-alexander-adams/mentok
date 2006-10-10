#!/usr/local/bin/perl -w
	

# This file was last edited by:         $Author$
# The date was:                         $Date$
# Name of the file in repository:       $RCSFile$
# And our revision number:              $Revision$

use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use Template;

use buildCGI;

my $buildroot    = '/home/builds';
my $stable       = "";
my $stable_ext   = '/local/apache/html/eng/release/stable_builds/external';
my $stable_int   = '/local/apache/html/eng/release/stable_builds/internal';
my $now          = get_stamp();
my $RUSER        = $ENV{'REMOTE_USER'} || "";

my @products     = qw(manhunt mantrap hidsCD_4.1 anasazi);

# Get a list of products first
# opendir (B, "$buildroot");
# my @list = readdir(B);
# closedir (B);
# foreach (sort @list) {
#    next if (/TEMPLATE/ || /scripts/ || /config/);
#    next if (/^\./ || /backups/ || /public_html/ || /mail/);
#    next if (/src/ || /\.tar/);
#    push (@products, $_);
# }


my $tt = Template->new();
my $q  = CGI->new();

my $PUSH_HEADER    = "FORMS/PUSH_HEADER";
my $PUSH_FORM      = "FORMS/PUSH_FORM";
my $PUSH_FORM2     = "FORMS/PUSH_FORM2";
my $PUSH_FAIL      = "FORMS/PUSH_FAIL";
my $PUSH_SUCCESS   = "FORMS/PUSH_SUCCESS";
my $PUSH_FOOTER    = "FORMS/PUSH_FOOTER";
my $PUSH_GETPROD   = "FORMS/PUSH_GETPROD";

my $name    = untaint($q->param('name'));
my $build   = untaint($q->param('build'));
my $area    = untaint($q->param('area'));
my $id      = untaint($q->param('nameas'));

my $var = {};

print $q->header();
print $q->start_html(-Title => "Make Builds Available For Download",
                     -BGCOLOR => "#000000");


$var = { env     => \%ENV,
         products => \@products,
};

if(! $tt->process($PUSH_HEADER, $var) ) {
   print "There were errors processing form $PUSH_HEADER\n";
   print $tt->error();
}

if(! $tt->process($PUSH_GETPROD, $var) ) {
   print "There were errors processing form $PUSH_HEADER\n";
   print $tt->error();
}

if ( defined ($q->param('product')) ) {

	my $product = untaint($q->param('product'));

	if(! auth_user($RUSER, 'pushbuild') ) {
   	print "You are not allowed to push builds. Sorry.\n<BR>";
   	send_to_log("$RUSER attempted to push a build and failed perms");
   	print $q->end_html;
   	exit 1;
	}

	# handle modifies first
	if ( defined ($q->param('remove'))) {

      	$build = $q->param('build');
      	$area = $q->param('area');
      	if (! $build || ! $area ) {
         	$var->{'Err'} = "Remove build specified but don't know what to remove from where";
         	exit_err_html();
      	}
      	if ($area eq "ext") {
         	$area = $stable_ext;
      	} elsif ($area eq "int") {
         	$area = $stable_int;
      	}
      	if (system ("/bin/rm -fr $area/$product/$build")) {
         	$var->{'Err'} = "Could not remove $area/$build!";
         	exit_err_html();
      	} else {
         	if (! $tt->process($PUSH_SUCCESS, $var)) {
            	print "There were errors processing $PUSH_SUCCESS\n";
            	print $tt->error();
         	}
     	 	}
   
  	} elsif (defined ($q->param('push_to_int')) || defined($q->param('push_to_ext')) ) {

   		if (defined ($q->param('push_to_ext'))) {
      		   $stable = $stable_ext;
   		} else {
      		   $stable = $stable_int;
   		}

   		if ( !($id) || ($id eq '')) {
      		   $id = $name;
   		}

   		if ( ! $name ) {
      		   $var->{'Err'} = "Build must have a symbolic name to push";
      		   exit_err_html();
   		}
 
   		if (! (-d "$buildroot/$product/$build") ) {
      		   $var->{'Err'} = "Build $build does not exist.";
      		   exit_err_html();
   		}

 	        # build ghettoness. mantrap does it one way. manhunt another.
  		my $rc = 0;
  	        if ($product eq "mantrap") {
      		   $rc = symlink ("$buildroot/$product/$build/package", 
 		    		"$stable/$product/$id");
      		   if (! $rc ) {
          		   $var->{'Err'} = "Failed to make symlink. $!";
          		   exit_err_html();
      		   }    
   		}

   		elsif ($product eq "manhunt") {

      		   my ($prod, $path);
      		   if (system ("mkdir -p $stable/$product/$id") ) {
         		$var->{'Err'} .= "Unable to mkdir $stable/$product/$id\n<BR>";
         		exit_err_html(); 
      		   }
      		   eval { require "$buildroot/config/$product.pl"; };
      		   foreach $prod (keys %platforms) {
         		$path = $prod . '/package';
         		if (system ("/bin/cp $buildroot/$product/$build/$path/*.tar* $stable/$product/$id")) { 
            		   $var->{'Err'} .= "Unable to cp $buildroot/$product/$build/$path/*.tar to";
            		   $var->{'Err'} .= " $stable/$product/$id\n<BR>";
         		   exit_err_html(); 
         		}
      		   }
   		}  elsif ( ($product eq "hidsCD_4.1") || ($product eq "anasazi") ) {

                     ### Create our placeholder in download area 
                     if (system ("/bin/mkdir -p $stable/hids/$product/$id")) {
         		$var->{'Err'} .= "Unable to mkdir $stable/hids/$product/$id\n<BR>";
         		exit_err_html(); 
      		     }
                     
                     ### Copy the CD image into the download area  
                     ### I know this is ugly, but get this going fo now, revisit later.
         	     if (system ("/bin/cp $buildroot/$product/$build/buildclient-2k/stage/* $stable/hids/$product/$id/")) { 
            		   $var->{'Err'} .= "Unable to cp $buildroot/$product/$build/buildclient-2k/stage/* to";
            		   $var->{'Err'} .= " $stable/hids/$product/$id/\n<BR>";
         		   exit_err_html(); 
         	     }
                           
                }

   		if ($var->{'Err'}) {
      		   exit_err_html();
   		} else {
      		   if (! $tt->process($PUSH_SUCCESS, $var)) {
         		print "There were errors processing $PUSH_SUCCESS\n";
         		print $tt->error();
      		   }
   		}

   } else {

   	my ($p, %build, @files, @dirs, @extbuildsonline, @intbuildsonline);
   	my ($state, $name, $owner);

   	$p = $product;

      %build = @files = @dirs = @extbuildsonline = @intbuildsonline = ();

      # Grab the current stable builds online (ext)
      opendir(STABLE,"$stable_ext/$p");
      @files = grep !/^\./, readdir(STABLE);
      closedir(STABLE);

      foreach (@files) {
         next if ($_ =~ /CVS/);
         push(@extbuildsonline,$_);
      }

      # Grab the current stable builds online (int)
      opendir(STABLE,"$stable_int/$p");
      @files = grep !/^\./, readdir(STABLE);
      closedir(STABLE);

      foreach (@files) {
         next if ($_ =~ /CVS/);
         push(@intbuildsonline,$_);
      }


      # Grab the current dirs for each product
      opendir(BDIR,"$buildroot/$p");
      @files = grep !/^\./, readdir(BDIR);
      closedir(BDIR);

      foreach (@files) {
         next unless ($_ =~ /\d+\-\d+\-\d+_\d+/);
         push(@dirs,$_);
      }

      foreach (@dirs) {
         ($state, $name, $owner) = eat_keep("$buildroot/$p/$_/.keep");
         next unless $state;
         $build{$_}{'state'} = $state;
         $build{$_}{'name'}  = $name;
         $build{$_}{'owner'} = $owner;
      }

      $var = { env     => \%ENV,
               builds  => \%build,
               product => $p,
             };
               
      if (! $tt->process($PUSH_FORM, $var) ) {
         print "There were errors processing form $PUSH_FORM\n";
         print $tt->error();
      }

      $var = { env     => \%ENV,
               prod    => $p,
               ebuilds => \@extbuildsonline,
               ibuilds => \@intbuildsonline,
             };

      if (! $tt->process($PUSH_FORM2, $var) ) {
         print "There were errors processing form $PUSH_FORM\n";
         print $tt->error();
      }
   }
}

if(! $tt->process($PUSH_FOOTER, $var) ) {
   print "There were errors processing form $PUSH_FOOTER\n";
   print $tt->error();
}


print $q->end_html;

exit 0;


######################################################################

sub exit_err_html {

   if(! $tt->process($PUSH_FAIL, $var) ) {
      print "There were errors processing form $PUSH_FAIL\n";
      print $tt->error();
   }

   if(! $tt->process($PUSH_FOOTER, $var) ) {
      print "There were errors processing form $PUSH_FOOTER\n";
      print $tt->error();
   }

   print $q->end_html;

   exit 1;
}
