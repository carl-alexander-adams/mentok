#!/usr/local/bin/perl

# This file was last edited by:         $Author$
# The date was:                         $Date$
# Name of the file in repository:       $RCSFile$
# And our revision number:              $Revision$

# This is almost a straight rip from the buildproduct
# that I wrote oh-so-long-ago. Will be able to customize
# this to our liking going forward - I think it's fairly
# handy. Groups of builds that build in a predetermined
# and consistent way, weird. 


use lib ".";
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use Template;

use buildCGI;

my ($buildroot, $config);
my ($BCMD, $HCMD, $RUSER, $DEBUG, $RROOT, $BROOT);

$buildroot = "/home/builds";
$grconf    = "$buildroot/config/queuerunner.pl";

$RUSER = $ENV{'REMOTE_USER'} || "unknown_web";

$BCMD = '/home/builds/scripts/queuerunner.pl';

$ENV{'PATH'} = '/usr/bin:/usr/local/bin:/bin';

# Will have to get rid of BS linking/apache perms
# later on to use these relative paths, this only
# works called from the scripts dir right now.

$OPENING_FORM = "FORMS/GROUP_FORM";
$PRE_FORM     = "FORMS/GROUP_DISP";
$CONF_FORM    = "FORMS/GROUP_CONF_FORM";
$END_FORM     = "FORMS/GROUP_END_FORM";
$HEADER       = "FORMS/GROUP_HEADER";
$FOOTER       = "FORMS/GROUP_FOOTER";
$P_LAUNCH     = "FORMS/GROUP_LAUNCH";
$P_FAIL       = "FORMS/GROUP_FAIL";
$P_LOCK       = "FORMS/GROUP_FAIL";

$DEBUG = 0;

$q  = CGI->new();
$tt = Template->new( { EVAL_PERL => 1, } );

## Moved header and grconf to here to cut back on redundant
## code somewhat. 
   
print $q->header;
print $q->start_html(-Title => "Build Request", 
                        -BGCOLOR=>"#000000",
                        -TEXT   =>"#FFFFFF",
                        -LINK   =>"#FFFFFF",
                        -ALINK  =>"#FFFFFF",
                        -VLINK  =>"#FFFFFF",
);
   
eval { require $grconf; };

if ($@) { 
   $vars{'error'} = "Error sourcing $grconf group config file!";
   footer_fail();
   exit 1;
}
   
unless ($q->param()) {

   my ($ret, @grconfig, @auth_prod);

   @auth_prod = auth_user_defs($RUSER);

   $var = { env     => \%ENV,
            auth    => \@auth_prod,
            grpind  => \%groups,
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

### pregroup defined, throw up the options for that group

elsif (defined ($q->param('pregroup')) && ! defined ( $q->param('group') ) ) {
   
   if (! $tt->process($HEADER, $var) ) {
      print "There were errors processing the form: $HEADER\n";
      print $tt->error();
   }

   $vars{'group'}   = $q->param('pregroup');

   @args = process_arg_template();

   ## this is ugly, but TT seems to lack / not let me do things
   ## how i need to in their limited way .. 

   foreach $line (@args) {
      next if ($line =~ /^[#|\s+]/);
      @t = split(/\t/,$line); 
      $t[2] =~ s/^"//; $t[2] =~ s/"$//;
      $t[3] =~ s/^"//; $t[3] =~ s/"$//;
      $s = "<TR><TD>$t[3]</TD>";
      if ($t[1] eq '+') {
         @choices = split(/\|/,$t[2]);
         $def = splice(@choices,0,1); $s .= "<TD>";
         foreach (@choices) {
           if ($_ eq $def) {
            $s .= "$_ : <INPUT TYPE=radio NAME=$t[0] VALUE=\"$_\" CHECKED>";
           }
           else { 
            $s .= "$_ : <INPUT TYPE=radio NAME=$t[0] VALUE=\"$_\">"; 
           }
         }
         $s .= "</TD>";
      }
      elsif ($t[1] eq 's') {
         $s .= "<TD><INPUT TYPE=text NAME=$t[0] VALUE=\"$t[2]\"></TD>";
      }
      else {
         $s .= "<TD>Unknown type, fix me. </TD>\n";
      }
      $s .= "</TR>";
      push (@templ, $s); 
   }

   $var = { env     => \%ENV,
            auth    => \@auth_prod,
            grpind  => \%groups,
            items   => \@templ,
            group   => $vars{'group'},
          };
  
   if (! $tt->process($PRE_FORM, $var) ) {
      print "There were errors processing the form\n";
      print $tt->error();
   }

   if (! $tt->process($FOOTER, $var) ) {
      print "There were errors processing the form: $FOOTER\n";
      print $tt->error();
   }


}

### 3rd step, group was defined (not pregroup) but there is no 'go',
### so throwup a conf page, and shove everything else into hidden
### form submits.

elsif (defined ($q->param('group')) && (! defined ( $q->param('GO') ))) {

   $vars{'group'}   = $q->param('group');
   
   @args = process_arg_template(); 

   foreach $line (@args) {
      next if ($line =~ /^[#|\s+]/);
      @t = split(/\t/,$line);

      print "found $t[0] in config \n<BR>";
      if ( $q->param($t[0]) ) {
         print "found $t[0] from web input val:" .  $q->param($t[0]) . "\n<BR>";
         $vars{$t[0]} = untaint ($q->param($t[0]));
      }
   }
       
   $var = { vars => \%vars,
            env  => \%ENV,
          };


   if (! $tt->process($HEADER, $var)) {
      print "There were errors processing the form\n";
      print $tt->error();
   }

   if (! auth_user($RUSER, $vars{'group'}) ) {
      $vars{'error'}  = "$RUSER is not allowed to spin $vars{'group'}";
      footer_fail();
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

### OK, if go is defined. Read in arg template, see if matching
### param entries are set. "NOP" is a special case and it gets
### weeded out. 'ebid' is special too, more because of legacy design.

elsif ( defined ( param('GO') )) {

   $| = 1;

   $vars{'group'}   = untaint( $q->param('group') );
  
   if (! $tt->process($HEADER, \%vars)) {
      print "There were errors processing the form\n";
      print $tt->error();
   }
   
   @args = process_arg_template();                                                                                
   foreach $line (@args) {
      next if ($line =~ /^[#|\s+]/);
      @t = split(/\t/,$line);
      if ( $q->param($t[0]) ) {
         next if ($q->param($t[0]) =~ /NOP/);
         $vars{$t[0]} = untaint ($q->param($t[0]));
      }
   }
   
   if (! auth_user($RUSER, $vars{'group'}) ) {
      $vars{'error'}  = "$RUSER is not allowed to spin $vars{'group'}";
      footer_fail();
      exit 1;
   }

   send_to_log ("$RUSER ran queuerun for $vars{'group'}");

   my ($opts, $redir, $sudo, $rc);
  
   # Now build up the command line, and do it.
   # This is all relative to the machine carefree now.

   $group = $vars{'group'}; $vars{'group'} = undef; delete $vars{'group'};

   $opts = "-group $group -- ";
   $opts .= " -user $RUSER ";

   foreach (keys %vars) {
      next if ($_ =~ /ebid/); # ebid is different :P
      $opts .= "-$_ \"$vars{$_}\" ";
   }

   $vars{'group'} = $group;

   if( $vars{'ebid'} && ($vars{'ebid'} eq "ON") ) {
      $opts .= " -ebid increment ";
   }

   $redir = " 1>/dev/null 2>&1";

   # And the special sudo perms + wrapper script we need to
   # make this work.

   $sudo  = "/usr/local/bin/sudo -u release /usr/local/bin/re2cf";
   
   my $mesg = "$RUSER attempted to build $vars{'group'}\n";
   $mesg   .= "Full cmd was: $sudo '$BCMD $opts $redir &'";
   send_to_log($mesg);
  
   $rc = system("$sudo '$BCMD $opts $redir &'");

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

### Redundant code to follow. $vars{'error'} must be set
### before hand (maybe eventually I'll just pass it in and
### set it here - gets tossed to TT forms anyway.

sub footer_fail {


   if (! $tt->process($P_FAIL, \%vars) ) {
      print "There were errors processing the form\n";
      print $tt->error();
   }
   if (! $tt->process($FOOTER, $var) ) {
      print "There were errors processing the form: $FOOTER\n";
      print $tt->error();
   }


}

### Find the arg template file. And return an array w 1 line
### per item. 

sub process_arg_template {


   $arg_file = $groups{$vars{'group'}}{'arg_template'};

   if (! -f "/home/builds/config/arg_template/$arg_file" ) {
      if (! -f $arg_file ) {
                                                                                
         $vars{'error'} = "Error reading arg_template $arg_file !";
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
   }
   else {
      $arg_file = "/home/builds/config/arg_template/$arg_file";
   }
                                                                                
   open (AF, "<$arg_file") || do {
         $vars{'error'} = "Error reading arg_template $arg_file !";
         if (! $tt->process($P_FAIL, \%vars) ) {
            print "There were errors processing the form\n";
            print $tt->error();
         }
         if (! $tt->process($FOOTER, $var) ) {
            print "There were errors processing the form: $FOOTER\n";
            print $tt->error();
         }
         exit 1;
   };
          
    while(defined ($line = <AF>) ) {
      push (@t, $line);
    }

   close(AF);

   return @t; 

}
