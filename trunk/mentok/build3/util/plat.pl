#!/usr/bin/perl
#
#
# Unified platform identifier.
# This script produced the cannonical platform identification
# strings used in the new new build. Consider it a beefed up "uname"
#
#

use Getopt::Std;
$config_delim = "|";

sub print_usage {
  print("Usage:\n".
	"$0\n".
	"\t[-n]  Display the machine name\n".
	"\t[-s]  Display the OS name\n".
	"\t[-M]  Display the OS major revision\n".
	"\t[-N]  Display the OS minor revision\n".
	"\t[-P]  Display the OS patch revision\n".
	"\t[-R]  Display the OS runtime environment revision\n".
	"\t[-m]  Display the machine type\n".
	"\t[-p]  Display the machine processor family\n".
	"\t[-i]  Display the machine/OS optimal instruction set\n".
	"\t[-a]  Display all system attributes\n".
	"\t[-3]  Display the \"build3\" fully qualified platform ID string\n".
	"\t[-h]  Display help message\n");
}

sub normalize {
  local($string);

  $string = $_[0];
  $string =~ s/[\s\r\n]+/ /gm;
  $string =~ s/^\s+//;
  $string =~ s/\s+$//;
  $string =~ s/ /_/g;
  return $string;
}
#
# Main
#

getopts('ansNMPRmpih3');
$display_machineName = $opt_n || $opt_a;
$display_OSName = $opt_s  || $opt_a;
$display_OSRevMajor = $opt_M  || $opt_a;
$display_OSRevMinor = $opt_N  || $opt_a;
$display_OSRevPatch = $opt_P  || $opt_a;
$display_OSRuntime = $opt_R  || $opt_a;
$display_machineType = $opt_m  || $opt_a;
$display_machineProc = $opt_p  || $opt_a;
$display_machineInstset = $opt_i  || $opt_a;
$display_build3Platform = $opt_3;

if ($opt_h) {
  print_usage();
  exit 0;
}

#
# Figure out the values and adjust for different OSs
# needing different command lines to make a proper determination.
#

$result_OSName = `uname -s`;
$result_OSName = normalize($result_OSName);

$result_machineName = `uname -n`;
$result_machineName = normalize($result_machineName);

$tmp_rev = `uname -r`;
($result_OSRevMajor, $result_OSRevMinor, $result_OSRevPatch, @junk) = split(/\./,$tmp_rev);
$result_OSRevMajor = normalize($result_OSRevMajor);
$result_OSRevMinor = normalize($result_OSRevMinor);
$result_OSRevPatch = normalize($result_OSRevPatch);
$result_OSRuntime = 'unknown';

$result_machineType = `uname -m`;
$result_machineType = normalize($result_machineType);

$result_machineProc = `uname -p`;
$result_machineProc = normalize($result_machineProc);

# XXX I'm not sure if this is right. Check Mac OSX and Cygwin too
$result_machineInstset = $result_machineType;

if ($result_OSName eq "SunOS") {
  $result_machineInstset = `optisa i386 sparcv7 sparcv9`;
  $result_machineInstset = normalize($result_machineInstset);
  if ($result_OSRevMajor eq '5') {
    $result_OSRuntime = 'Solaris';
  }
}
elsif ($result_OSName eq "Linux") {
  if ($result_machineProc eq "unknown") {
    $result_machineProc = $result_machineType;
  }
  $result_OSRuntime = readlink("/lib/libc.so.6");
  $result_OSRuntime =~ s/\.so$//;
  # XXX - what level do we want to chop this versoin string to?
  $result_OSRuntime = normalize($result_OSRuntime);
}


$result_build3Platform = "${result_OSName}-";
if (${result_OSRevMajor}) {$result_build3Platform .= "${result_OSRevMajor}";}
if (${result_OSRevMinor}) {$result_build3Platform .= ".${result_OSRevMinor}";}
if (${result_OSRevPatch}) {$result_build3Platform .= ".${result_OSRevPatch}";}
$result_build3Platform .= "-${result_machineInstset}-${result_OSRuntime}";

#
# Output
#

if ($display_build3Platform) {
  print("${result_build3Platform}");


  print();
}
else {
  if ($display_machineName) {
    print("${delim}${result_machineName}");
    $delim = $config_delim;
  }
  if ($display_OSName) {
    print("${delim}${result_OSName}");
    $delim = $config_delim;
  }
  if ($display_OSRevMajor) {
    print("${delim}${result_OSRevMajor}");
    $delim = $config_delim;
  }
  if ($display_OSRevMinor) {
    print("${delim}${result_OSRevMinor}");
    $delim = $config_delim;
  }
  if ($display_OSRevPatch) {
    print("${delim}${result_OSRevPatch}");
    $delim = $config_delim;
  }
  if ($display_OSRuntime) {
    print("${delim}${result_OSRuntime}");
    $delim = $config_delim;
  }
  if ($display_machineType) {
    print("${delim}${result_machineType}");
    $delim = $config_delim;
  }
  if ($display_machineProc) {
    print("${delim}${result_machineProc}");
    $delim = $config_delim;
  }
  if ($display_machineInstset) {
    print("${delim}${result_machineInstset}");
    $delim = $config_delim;
  }
}

print("\n");
