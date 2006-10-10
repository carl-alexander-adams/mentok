#!/usr/local/bin/perl -w

# This file was last edited by:         $Author$
# The date was:                         $Date$
# Name of the file in repository:       $RCSFile$
# And our revision number:              $Revision$

use strict;
use lib ".";
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use Template;
use buildCGI;

my $RUSER = $ENV{'REMOTE_USER'};

### Valid Products and valid menu choices. Only ones we have a
### patch feature for.

my @products = ('manhunt','mantrap');
my ($q, $tt);

$q  = CGI->new();
$tt = Template->new();

print $q->header();
print $q->start_html(-Title => "Patch Build Request", -BGCOLOR=>"White");

my($buildid, $patchnum, $email, $product, $build, $cvstag);

$buildid  = untaint($q->param('buildid'));
$patchnum = untaint($q->param('patchnum'));
$email    = untaint($q->param('email'));
$build    = untaint($q->param('build')); 
$product  = untaint($q->param('product'));
$cvstag   = untaint($q->param('cvstag'));

my($sudo, $btool, $redir);

$sudo  = "/usr/local/bin/sudo -u release /usr/local/bin/re2cf";
$redir = "1>/home/builds/$product/bpinit.txt 2>&1" if $product;
$btool = "/home/builds/scripts/buildpatch.pl";

my($PATCH_HEADER, $PATCH_FORM, $PATCH_CHECK);

$PATCH_HEADER = "FORMS/PATCH_HEADER";
$PATCH_FORM   = "FORMS/PATCH_FORM";
$PATCH_CHECK  = "FORMS/PATCH_CHECK";

my $var = { env      => \%ENV,
            buildid  => $buildid,
            patchnum => $patchnum,
            email    => $email,
            build    => $build,
            product  => $product,
            cvstag   => $cvstag,
            products => \@products,
          };
 
if(! $tt->process($PATCH_HEADER, $var) ) {
   print "There were errors processing the form $PATCH_HEADER\n";
   print $tt->error();
}

unless ($q->param()) {

   if(! $tt->process($PATCH_FORM, $var) ) {
      print "There were errors processing the form $PATCH_FORM\n";
      print $tt->error();
   }
 
   print $q->end_html;
 
   exit 0;

} 
else {

   if ( ! defined($product)  || 
        ! defined($patchnum) ||
        ! defined($buildid) ) {

      if(! $tt->process($PATCH_CHECK, $var) ) {
         print "There were errors processing the form $PATCH_CHECK\n";
         print $tt->error();
      }

      if(! $tt->process($PATCH_FORM, $var) ) {
         print "There were errors processing the form $PATCH_FORM\n";
         print $tt->error();
      }

      print $q->end_html;
      exit 1;
   }

   if (-e "/home/builds/$product/$product.lck") {
      print "$product is already building, There may be problems.<BR>\n";
   } 

   my ($opts, $rc);

   $opts  = " -config /home/builds/config/$product.pl";
   $opts .= " -patchnum $patchnum";
   $opts .= " -build $buildid";
   $opts .= " -email $email" if $email;
   $opts .= " -cvstag $cvstag" if $cvstag;

   if (! auth_user($RUSER, $product) ) {
      print "User $RUSER is not allowed to build patch for $product\n";
   }
   else { 
 
      $rc = system("$sudo '$btool $opts $redir &'");

      if (! $rc ) {
         print "Ran 'buildpatch.pl $opts $redir'.<P>\n";
         print "The patch is now spinning now. "; 
         print "Mail will be sent out when it finished.<BR>\n",
      } 
      else {
         print "An error occured. Please contact release engineering.<BR>\n";
      }

   }

   print $q->end_html;

}

