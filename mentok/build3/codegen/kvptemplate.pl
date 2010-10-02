#!/usr/bin/perl
#use strict;
use Getopt::Long;

GetOptions("h|?|help"      => \$opt_help,
           "o|output=s"    => \$opt_output,
           "k|kvp=s"       => \$opt_kvp,
           "t|template=s"  => \$opt_template,
           "I|include=s@"  => \$opt_includes) || exit_usage(1);

if ( $opt_help ) { exit_usage(0); }
my $template_file = $opt_template || exit_usage(2);
my $kvp_file = $opt_kvp || exit_usage(3);
my $output_file = $opt_output || $template_file . "." . $kvp_file;
my $include_dirs = $opt_includes;

push(@INC, @{$include_dirs});

expand_template($template_file, $kvp_file, $output_file, $include_dirs);

exit(0);

##############################################################################

sub exit_usage {
    local($exit_code) = @_;
    print(STDERR "Usage: $0 [-h] -t <template file> -k <key file> [-o <output file>]\n".
                 "    -h|-?|--help                   Display this help message\n".
                 "    -t|--template <template file>  Specify template onput file.\n".
                 "    -k|--kvp <key file>            Specify key/value pair input file. Must define \$template_kvp as an associative array in Perl syntax.\n".
                 "    -o|--output <output file>      Specify output file.\n".
                 "    -I|--include <include dir>     Specify additional include dirs for key/value pair files\n");
    exit($exit_code);
}

sub expand_template {
    local($tmpl, $kvp, $out, $incs) = @_;
    local($wrk) = $out . ".wrk";

    print "Creating $out\n";

    undef $template_kvp;
    require $kvp or die "Could not import key/value pair file '$kvp'";
    defined($template_kvp) or die "key/value pair file '$kvp' did not appear to define the associative array reference '\$template_kvp'";

    # read whole file with <>
    local $/ = undef;
    
    open IN, "< $tmpl" or die "Can't read '$tmpl' ($!)\n";
    open OUT, "> $wrk" or die "Can't create '$wrk' ($!)\n";
    my $contents = <IN>;
    my $data;

    # set variable values
    my $vars = '';
    foreach my $name (keys(%{$template_kvp}))
    { $vars .= "my \$$name = $template_kvp->{$name};\n"; }

    eval "$vars\n$contents";
    die $@ if $@;
    
    # write the substituted template
    print OUT "$data";
    
    close OUT or die "Can't write '$wrk' ($!)\n";
    close IN;
    
    # place the output file
    rename($wrk, $out) or die "rename '$wrk' -> '$out' failed ($!)\n";
}

