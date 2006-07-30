#!/usr/local/bin/perl

# This file was last edited by:         $Author$
# The date was:                         $Date$
# Name of the file in repository:       $RCSFile$
# And our revision number:              $Revision$


use lib ".";
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use Template;

use buildCGI;

my ($buildroot, $config);
my ($BCMD, $HCMD, $RUSER, $DEBUG, $RROOT, $BROOT);
my ($OPENING_FORM, $CONF_FORM, $END_FORM);
my ($HEADER, $P_LAUNCH, $P_FAIL, $P_LOCK);
my $FOOTER;

$buildroot = "/home/builds";
$BCMD  = "$buildroot/scripts/buildall.pl";
$HCMD  = "$buildroot/scripts/hidsbuild.pl";
$BROOT = "/local/apache/html/eng";
$RUSER = $ENV{'REMOTE_USER'} || "unknown_web";


$ENV{'PATH'} = '/usr/bin:/usr/local/bin:/bin';

# Will have to get rid of BS linking/apache perms
# later on to use these relative paths, this only
# works called from the scripts dir right now.

$OPENING_FORM = "FORMS/PRODUCT_FORM";
$CONF_FORM    = "FORMS/PRODUCT_CONF_FORM";
$END_FORM     = "FORMS/PRODUCT_END_FORM";
$HEADER       = "FORMS/PRODUCT_HEADER";
$FOOTER       = "FORMS/PRODUCT_FOOTER";
$P_LAUNCH     = "FORMS/PRODUCT_LAUNCH";
$P_FAIL       = "FORMS/PRODUCT_FAIL";
$P_LOCK       = "FORMS/PRODUCT_FAIL";

$DEBUG = 0;

my $q  = CGI->new();
my $tt = Template->new();
my ($var, $err);

if ( ! ( $q->param() ) || $q->param('UpHosts') ) {

   print $q->header;
   print $q->start_html(-Title => "Build Request", 
                        -BGCOLOR=>"#000000",
                        -TEXT   =>"#FFFFFF",
                        -LINK   =>"#FFFFFF",
                        -ALINK  =>"#FFFFFF",
                        -VLINK  =>"#FFFFFF",
   );

   my ($ret, @products, @auth_prod);

   # each product must have a 'builds' dir. 
   @products = get_build_products($BROOT);

   @auth_prod = auth_user_defs($RUSER);

   # grab hosts into @hosts here

   %hosts = (); 

   if ( $q->param('UpHosts') ) {
      $product = untaint($q->param('product'));
      $branch = $tag = untaint($q->param('branch'));
      if ( -f "$buildroot/config/$product.pl" ) {
         eval { require "$buildroot/config/$product.pl"; };
         unless ($@) { 
            foreach (keys %platforms) {
               $hosts{$_} = 1;
            }
         }
      }
            
#      if ( open(PROD, "<$buildroot/config/$product.pl") ) {
#         while(defined ($line = <PROD>)) {
#            if ($line =~ /'(\S+)'\s+=>\s+'\S+'/) {
#               $hosts{$1} = 1;
#            }
#         } 
#         close(PROD);
#      }
      else {
         print "Wasn't able to open $product.pl. \n<BR>";
      }
   }

   $var = { env  => \%ENV,
            prod => \@products,
            auth => \@auth_prod,
            hosts => \%hosts,
            prod_sel => $product,
            branch => $branch,
          };

   if (! $tt->process($HEADER, $var) ) {
      print "There were errors processing the form: $HEADER\n";
      print $tt->error();
   }

   if (! $tt->process($OPENING_FORM, $var) ) {
      print "There were errors processing the form: $OPENING_FORM\n";
      print $tt->error();
   }

   if (! $tt->process($FOOTER, $var) ) {
      print "There were errors processing the form: $FOOTER\n";
      print $tt->error();
   }

   print $q->end_html;
 
   exit 0;

}

elsif (defined ($q->param('product')) && (! defined ( $q->param('GO') ))) {

   print $q->header;
   print $q->start_html(-Title => "Build Request", 
                        -BGCOLOR=>"#000000",
                        -TEXT   =>"#FFFFFF",
                        -LINK   =>"#FFFFFF",
                        -ALINK  =>"#FFFFFF",
                        -VLINK  =>"#FFFFFF",
   );

   my(%vars, $var);

   $vars{'product'} = $q->param('product');
   $vars{'branch'}  = $q->param('branch');
   $vars{'email'}   = $q->param('email');
   $vars{'suffix'}  = untaint( $q->param('suffix') );
   $vars{'special_gmake_args'} = untaint( $q->param('special_gmake_args') );

   $vars{'dist'}    = $q->param('dist');

   $vars{'ebid'}    = $q->param('ebid');

   $vars{'debug'}   = $q->param('debug');
   $vars{'bomb'}    = $q->param('bomb');
   $vars{'strip'}   = $q->param('strip');
   $vars{'variant'} = $q->param('variant');


   foreach my $i (0 .. 99) { # no more than 99 hosts? :)
      if ( ($q->param("host${i}_name")) ) {
         $vars{"host${i}_name"}    =  $q->param("host${i}_name") ;
         $vars{"host${i}_enable"}  =  $q->param("host${i}_enable") ;
         $vars{"host${i}_args"}    =  $q->param("host${i}_args") ;
      }
      else {
         last;
      }
   }

   $var = { vars => \%vars,
            env  => \%ENV,
          };

   if (! $tt->process($HEADER, $var)) {
      print "There were errors processing the form\n";
      print $tt->error();
   }

   if (! auth_user($RUSER, $vars{'product'}) ) {
      $vars{'error'}  = "$RUSER is not allowed to spin $vars{'product'}";
      if (! $tt->process($P_FAIL, \%vars) ) {
         print "There were errors processing the form\n";
         print $tt->error();
      }
      if (! $tt->process($FOOTER, $var) ) {
         print "There were errors processing the form: $FOOTER\n";
         print $tt->error();
      }
      exit 1;
   }

   if (! $tt->process($CONF_FORM, $var)) {
      print "There were errors processing the form\n";
      print $tt->error();
   }

   if (! $tt->process($FOOTER, $var) ) {
      print "There were errors processing the form: $FOOTER\n";
      print $tt->error();
   }

   print $q->end_html;
 
   exit 0;

}

elsif ( defined ( param('GO') )) {

   print $q->header;
   print $q->start_html(-Title => "Build Request", 
                        -BGCOLOR=>"#000000",
                        -TEXT   =>"#FFFFFF",
                        -LINK   =>"#FFFFFF",
                        -ALINK  =>"#FFFFFF",
                        -VLINK  =>"#FFFFFF",
   );

   my (%vars);

   $| = 1;

   $vars{'product'} = untaint( $q->param('product') );
   $vars{'branch'}  = untaint( $q->param('branch') );
   $vars{'email'}   = untaint( $q->param('email') );
   $vars{'suffix'}  = untaint( $q->param('suffix') );
   $vars{'variant'} = untaint( $q->param('variant') );
   $vars{'special_gmake_args'} = untaint( $q->param('special_gmake_args') );

   $vars{'dist'}    = $q->param('dist') ;

   $vars{'ebid'}    = $q->param('ebid');

   $vars{'bomb'}    = $q->param('bomb');
   $vars{'debug'}   = $q->param('debug');
   $vars{'strip'}   = $q->param('strip');

   my (%host, $en);

   # formating it up for later - we want it to be
   # --host <hostname>="<0|1>|<gmake_args>"
   # 0 to disable. 1 is enabled (default). 

   foreach my $i (0 .. 99) {
      if ( $q->param("host${i}_name") ) {
         if ( ($q->param("host${i}_enable") ) &&
              ! ($q->param("host${i}_args")) ) {
            next;
         }
         if ( ! $q->param("host${i}_enable") ) { $en = 0; }
         else { $en = 1; }
         $host{untaint($q->param("host${i}_name"))} = $en . "|" .  
            untaint($q->param("host${i}_args"));
      }
      else {
         last;
      }
   }

   my $product = $vars{'product'};

   if (! $tt->process($HEADER, \%vars)) {
      print "There were errors processing the form\n";
      print $tt->error();
   }
   
   if (! auth_user($RUSER, $vars{'product'}) ) {
      $vars{'error'}  = "$RUSER is not allowed to spin $vars{'product'}";
      if (! $tt->process($P_FAIL, \%vars) ) {
         print "There were errors processing the form\n";
         print $tt->error();
      }
      if (! $tt->process($FOOTER, $var) ) {
         print "There were errors processing the form: $FOOTER\n";
         print $tt->error();
      }
      exit 1;
   }

   # Make sure nothing is currently building.
   if (-f "/home/builds/$product/$product.lck") {
      $vars{'error'} = "$vars{'product'} is locked by another build process. 
                        Please try again after some time."; 
      if (! $tt->process($P_FAIL, \%vars) ) {
         print "There were errors processing the form\n";
         print $tt->error();
      }
      if (! $tt->process($FOOTER, $var) ) {
         print "There were errors processing the form: $FOOTER\n";
         print $tt->error();
      }
      print $q->end_html;
      exit 0;
   } 

   #
   # We now have 2 master build scripts - buildall.pl (sane)
   # and hidsbuild.pl (insane). The product config file
   # dictates which one to use for the product we're building.
   # So, eval it and set BCMD appropriately.
   #

   # XXX We should source Defaults as well before the product.pl

   $config = "$buildroot/config/$product\.pl";

   eval { require "$config"; }; 
   if ($@) {
      $vars{'error'} = "Error sourcing $product build config file!";
      if (! $tt->process($P_FAIL, \%vars) ) {
         print "There were errors processing the form\n";
         print $tt->error();
      }

      if (! $tt->process($FOOTER, $var) ) {
         print "There were errors processing the form: $FOOTER\n";
         print $tt->error();
      }
       
      print $q->end_html;
      exit 0;
   }

   # At this point, we should have the kick off 
   # script for $vars{product} in $cgi_bcmd.

   $BCMD = $cgi_bcmd if ($cgi_bcmd);
   send_to_log ("master build kickoff script = $BCMD");

   my ($opts, $redir, $sudo, $rc);
  
   # Now build up the command line, and do it.
   # This is all relative to the machine carefree now.

   $opts  = " -config /home/builds/config/$product.pl";

   $opts .= " -user $RUSER";

   $opts .= " -cvstag $vars{'branch'}" 	if ($vars{'branch'});
   $opts .= " -email $vars{'email'}" 	if ($vars{'email'});
   $opts .= " -suffix $vars{'suffix'}"  if ($vars{'suffix'});
   $opts .= " -variant $vars{'variant'}" if ($vars{'variant'});
   $opts .= " -special_gmake_args \"$vars{'special_gmake_args'}\"" 
	if ($vars{'special_gmake_args'});

   if( $vars{'ebid'} && ($vars{'ebid'} eq "ON") ) {
      $opts .= " -ebid increment ";
   }

   if($vars{'bomb'}) {
      $opts .= " -bomb=$vars{'bomb'} ";
   }

   if($vars{'debug'}) {
      $opts .= " -debug=$vars{'debug'} ";
   }
   
   if($vars{'strip'}) {
      $opts .= " -strip=$vars{'strip'}";
   }

   $opts .= " -dist" 		if ($vars{'dist'});

   foreach my $i (keys %host) {
      $opts .= " --host $i=\"$host{$i}\"";
   }

   #$redir = " >/home/builds/$product/buildall.txt";

   ### Not much to go here, but may catch initial errors

   $redir = " 1>/home/builds/$product/init.txt 2>&1";

   # And the special sudo perms + wrapper script we need to
   # make this work.

   $sudo  = "/usr/local/bin/sudo -u release /usr/local/bin/re2cf";
  
   $rc = system("$sudo '$BCMD $opts $redir &'");

   my $mesg = "$RUSER attempted to build $product\n";
   $mesg   .= "Full cmd was: $sudo '$BCMD $opts $redir &'";
   send_to_log($mesg);

   if (! $rc ) {
      if (! $tt->process($P_LAUNCH, \%vars) ) {
         print "There were errors processing the form\n";
         print $tt->error();
      }
   }
   else {
      $vars{'error'} = "$rc did not succeed";
      if (! $tt->process($P_FAIL, \%vars) ) {
         print "There were errors processing the form\n";
         print $tt->error();
      }
   } 

   if (! $tt->process($FOOTER, $var) ) {
      print "There were errors processing the form: $FOOTER\n";
      print $tt->error();
   }

   print $q->end_html;
   exit 0;

}

