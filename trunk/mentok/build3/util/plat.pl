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
	"\t[-R]  Display the OS runtime ID string (backward compatibility with older versions that didn't break this down by name and revision)\n".
	"\t[-w]  Display the OS runtime Name\n".
	"\t[-x]  Display the OS runtime major revision\n".
	"\t[-y]  Display the OS runtime minor revision\n".
	"\t[-z]  Display the OS runtime patch revision\n".
	"\t[-m]  Display the machine type\n".
	"\t[-p]  Display the machine processor family\n".
	"\t[-i]  Display the machine/OS optimal instruction set\n".
	"\t[-a]  Display all system attributes\n".
	"\t[-3]  Display the \"Mentok\" fully qualified platform ID string\n".
	"\t[-l]  Display output in long format\n".
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

getopts('ansNMPRmpih3wxyzl');
$display_machineName = $opt_n || $opt_a;
$display_OSName = $opt_s  || $opt_a;
$display_OSRevMajor = $opt_M  || $opt_a;
$display_OSRevMinor = $opt_N  || $opt_a;
$display_OSRevPatch = $opt_P  || $opt_a;
$display_machineType = $opt_m  || $opt_a;
$display_machineProc = $opt_p  || $opt_a;
$display_machineInstset = $opt_i  || $opt_a;
$display_OSRuntimeOldName = $opt_R  || $opt_a;
$display_OSRuntimeName = $opt_w  || $opt_a;
$display_OSRuntimeRevMajor = $opt_x  || $opt_a;
$display_OSRuntimeRevMinor = $opt_y  || $opt_a;
$display_OSRuntimeRevPatch = $opt_z  || $opt_a;
$display_build3Platform = $opt_3 || $opt_a;
$display_all = $opt_a;
if ($opt_l) {
  $display_format = 'long';
}
else {
  $display_format = 'short';
}
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

#
# Break down OS/kernel revision
#

$tmp_rev = `uname -r`;
($result_OSRevMajor, $result_OSRevMinor, $result_OSRevPatch) = split(/\./,$tmp_rev,3);
$result_OSRevMajor = normalize($result_OSRevMajor);
$result_OSRevMinor = normalize($result_OSRevMinor);
$result_OSRevPatch = normalize($result_OSRevPatch);
$result_OSRuntimeOldName = 'unknown';
$result_OSRuntimeName = 'unknown';



#
# Refine notions of hardware and instruction sets,
#
$result_machineType = `uname -m`;
$result_machineType = normalize($result_machineType);

$result_machineProc = `uname -p`;
$result_machineProc = normalize($result_machineProc);

# XXX I'm not sure if this is right. Check Mac OSX and Cygwin too
$result_machineInstset = $result_machineType;

if ($result_OSName eq "SunOS") {
  $result_machineInstset = `optisa i386 sparcv7 sparcv9`;
  $result_machineInstset = normalize($result_machineInstset);
}
elsif ($result_OSName eq "Linux") {
  if ($result_machineProc eq "unknown") {
    $result_machineProc = $result_machineType;
  }
}


#
# break down OS/runtime
#
if ($result_OSName eq "SunOS") {
  if ($result_OSRevMajor eq '5') {
    $result_OSRuntimeName = 'Solaris';
    $result_OSRuntimeOldName = 'Solaris';
  }
  else {
    $result_OSRuntimeName = 'SunOS';
    $result_OSRuntimeOldName = 'SunOS';
  }
  $result_OSRuntimeRevMajor = $result_OSRevMajor;
  $result_OSRuntimeRevMinor = $result_OSRevMinor;
  $result_OSRuntimeRevPatch = $result_OSRevPatch;

}
elsif ($result_OSName eq "Linux") {
  $result_OSRuntimeOldName = readlink("/lib/libc.so.6");
  $result_OSRuntimeOldName =~ s/\.so$//;
  $result_OSRuntimeOldName = normalize($result_OSRuntimeOldName);

  ($result_OSRuntimeName, $tmp_rev) = split(/-/, $result_OSRuntimeOldName, 2);
  ($result_OSRuntimeRevMajor, $result_OSRuntimeRevMinor, $result_OSRuntimeRevPatch)
    = split(/\./,$tmp_rev,3);
}


#
# Build3's platform name.
#
$result_build3Platform = "${result_OSName}-";
if (${result_OSRevMajor}) {$result_build3Platform .= "${result_OSRevMajor}";}
if (${result_OSRevMinor}) {$result_build3Platform .= ".${result_OSRevMinor}";}
if (${result_OSRevPatch}) {$result_build3Platform .= ".${result_OSRevPatch}";}
$result_build3Platform .= "-${result_machineInstset}-${result_OSRuntimeName}-";
if (${result_OSRuntimeRevMajor}) {$result_build3Platform .= "${result_OSRuntimeRevMajor}";}
if (${result_OSRuntimeRevMinor}) {$result_build3Platform .= ".${result_OSRuntimeRevMinor}";}
if (${result_OSRuntimeRevPatch}) {$result_build3Platform .= ".${result_OSRuntimeRevPatch}";}

#
# Output
#

if ($display_format eq 'long') {
  #
  # Long format output
  #
  if ($display_machineName) {
    print("Host Name                       : ${result_machineName}\n");
  }
  if ($display_OSName) {
    print("OS Name                         : ${result_OSName}\n");
  }
  if ($display_OSRevMajor) {
    print("OS Revision Major               : ${result_OSRevMajor}\n");
  }
  if ($display_OSRevMinor) {
    print("OS Revision Minor               : ${result_OSRevMinor}\n");
  }
  if ($display_OSRevPatch) {
    print("OS Revision Patch               : ${result_OSRevPatch}\n");
  }
  if ($display_OSRuntimeName) {
    print("OS Runtime Name                 : ${result_OSRuntimeName}\n");
  }
  if ($display_OSRuntimeRevMajor) {
    print("OS Runtime Revision Major       : ${result_OSRuntimeRevMajor}\n");
  }
  if ($display_OSRuntimeRevMinor) {
    print("OS Runtime Revision Minor       : ${result_OSRuntimeRevMinor}\n");
  }
  if ($display_OSRuntimeRevPatch) {
    print("OS Runtime Revision Patch       : ${result_OSRuntimeRevPatch}\n");
  }
  if ($display_OSRuntimeOldName) {
    print("OS Runtime (compatibility name) : ${result_OSRuntimeOldName}\n");
  }
  if ($display_machineType) {
    print("Machine Type                    : ${result_machineType}\n");
  }
  if ($display_machineProc) {
    print("Processor Type                  : ${result_machineProc}\n");
  }
  if ($display_machineInstset) {
    print("Processor Instruction Set       : ${result_machineInstset}\n");
  }
  if ($display_build3Platform) {
    print("Mentok Platform Name            : ${result_build3Platform}\n");
  }
} else {
  #
  # Sort format output
  #
  $delim = '';
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
  if ($display_OSRuntimeName) {
    print("${delim}${result_OSRuntimeName}");
    $delim = $config_delim;
  }
  if ($display_OSRuntimeRevMajor) {
    print("${delim}${result_OSRuntimeRevMajor}");
    $delim = $config_delim;
  }
  if ($display_OSRuntimeRevMinor) {
    print("${delim}${result_OSRuntimeRevMinor}");
    $delim = $config_delim;
  }
  if ($display_OSRuntimeRevPatch) {
    print("${delim}${result_OSRuntimeRevPatch}");
    $delim = $config_delim;
  }
  if ($display_OSRuntimeOldName) {
    print("${delim}${result_OSRuntimeOldName}");
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
  if ($display_build3Platform) {
    print("${delim}${result_build3Platform}");
    $delim = $config_delim;
  }
}

print("\n");
