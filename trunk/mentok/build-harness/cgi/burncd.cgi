#!/usr/local/bin/perl -w

# This file was last edited by:         $Author$
# The date was:                         $Date$
# Name of the file in repository:       $RCSFile$
# And our revision number:              $Revision$

use strict;

use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use Template;

$ENV{'PATH'} = "/bin:/usr/bin:/usr/local/bin";

use buildCGI;

my ($RUSER, $sudo, $q, $tt);
my ($BURNCD_FORM, $BURNCD_HEADER, $BURNCD_ACTION, $BURNCD_FAIL);

my(@source_op, @products);

$|         = 1;
$RUSER     = $ENV{'REMOTE_USER'};

# Command to run things across machines as release
$sudo      = "/usr/local/bin/sudo -u release /usr/local/bin/re2cfl";

# Products which we support burning cd's for from a buildid
@products  = qw(manhunt mantrap);
@source_op = qw(directory isoimage patch cd);

$q  = CGI->new();
$tt = Template->new( { EVAL_PERL    => 1, PRE_CHOMP => 1});

$BURNCD_FORM   = "FORMS/BURNCD_FORM";
$BURNCD_HEADER = "FORMS/BURNCD_HEADER";
$BURNCD_ACTION = "FORMS/BURNCD_ACTION";
$BURNCD_FAIL   = "FORMS/BURNCD_FAIL";

print $q->header(); 
print $q->start_html(-Title => "Burn CD", -BGCOLOR=>"White");

my($source, $directory, $volume, $tag, $backup, $isoimage, $speed, $verbose);
my($buildid, $product);

my $defspeed = 12;

# Get out CGI variables and sanity check them

$source    = untaint($q->param('source'));

$directory = untaint($q->param('directory'));
$volume    = untaint($q->param('volume'));
$tag       = untaint($q->param('tag'));
$backup    = untaint($q->param('backup'));

$isoimage  = untaint($q->param('isoimage'));

$buildid   = untaint($q->param('buildid'));
$product   = untaint($q->param('product'));

$speed     = untaint($q->param('speed'));
$verbose   = untaint($q->param('verbose'));

# Form up our variable to pass onto the Templates

unless ($speed) { $speed = $defspeed; }

my $var = { directory => $directory,
            volume    => $volume,
            tag       => $tag,
            backup    => $backup,
            source    => $source,
            isoimage  => $isoimage,
            source_op => \@source_op,
            products  => \@products,
            buildid   => $buildid,
            product   => $product,
            env       => \%ENV,
	    speed     => $speed,
	    verbose   => $verbose,
          };

# Begin checking for CGI input

if(! $tt->process($BURNCD_HEADER, $var) ) {
   print "There were errors processing form $BURNCD_HEADER\n";
   $tt->error;
}

if(! auth_user($RUSER, 'burncd') ) {
   print "You are not allowed to burn CD's. Sorry\n<BR>";
   send_to_log("$RUSER attempted to burn a CD and failed auth");
   exit 1;
}

if (defined($q->param('action'))) {

    my ($opts, $cmd);

    if ($source eq 'directory') {

        if( !($directory) || !($volume) || !($tag) ) {

           if (! $tt->process($BURNCD_FAIL, $var) ) {
              print "There were errors processing form $BURNCD_FAIL\n";
              $tt->error;
           }
          
           print $q->end_html;
           exit 1; 
        }

        $opts =  "-dir $directory -tag $tag -volume $volume";
        $opts .= " -X" unless $backup;
        $opts .= " -sp $speed";
        $opts .= " -v" if $verbose;

        $cmd = "$sudo '/home/builds/scripts/makecd $opts'";

        $var->{'cmd'} = $cmd;

    }

    elsif ($source eq 'isoimage') {

        if (! $isoimage ) {
           if (! $tt->process($BURNCD_FAIL, $var) ) {
              print "There were errors processing form $BURNCD_FAIL\n";
              print $tt->error;
           }
           $q->end_html;
           exit 1;
        }

        #$opts = "-iso $isoimage -V";
        $opts = "-iso $isoimage";
        $opts .= " -sp $speed";
        $opts .= " -v" if $verbose;
        $cmd  = "$sudo '/home/builds/scripts/makecd $opts'";

        $var->{'cmd'} = $cmd;
 
    }

    elsif ($source eq 'build') {

        if ( !($product) || !($buildid) ) { 
           if (! $tt->process($BURNCD_FAIL, $var) ) {
              print "There were errors processing form $BURNCD_FAIL\n";
              print $tt->error;
           }
           $q->end_html;
           exit 1;
        }
 
        $opts = "-prod $product -build $buildid";
        $opts .= " -sp $speed";
        $opts .= " -v" if $verbose;
        $cmd  = "$sudo '/home/builds/scripts/burnbuild.pl $opts'";

        
        $var->{'cmd'} = $cmd;

    }

    elsif ($source eq 'patch') {

        if ( !($product) || !($buildid) ) { 
           if (! $tt->process($BURNCD_FAIL, $var) ) {
              print "There were errors processing form $BURNCD_FAIL\n";
              print $tt->error;
           }
           $q->end_html;
           exit 1;
        }
        
    }
 
    elsif ($source eq 'cd') {

        $opts = ' -C';
        $opts .= " -sp $speed";
        $opts .= " -v" if $verbose;
        $cmd  = "$sudo '/home/builds/scripts/makecd $opts'";

        $var->{'cmd'} = $cmd;
      
    }

    if (defined $var->{'cmd'}) {

        if (! $tt->process($BURNCD_ACTION, $var) ) {
          print "There were errors processing form $BURNCD_ACTION\n";
          print $tt->error;
        }
        send_to_log("$RUSER launched cdburn process");

        ### Can't launch $cmd from form, due to screwy STDERR,STDOUT
        ### redirection.

        print "<PRE>\n";
        my $rc = system("$cmd");
        print "</PRE>\n";

        if( $rc ) {
           print "There were errors with the CD burn launch!\n";
        }

    }
     
    print $q->end_html;
    exit 0;

}

# No action, display default form

if(! $tt->process($BURNCD_FORM, $var) ) {
   print "There were errors processing form $BURNCD_FORM\n";
   print $tt->error;
}

print $q->end_html;

exit 0;

