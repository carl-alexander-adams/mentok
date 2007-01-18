#!/usr/bin/perl
#
#
# Unified platform identifier.
# This script produced the cannonical platform identification
# strings used in the new new build. Consider it a beefed up "uname"
#
#

use Getopt::Std;

sub print_usage {
    print("Usage:\n".
          "$0\n".
          "\t[-n]          Display the machine name\n".
          "\t[-s]          Display the OS name\n".
          "\t[-M]          Display the OS major revision\n".
          "\t[-N]          Display the OS minor revision\n".
          "\t[-P]          Display the OS patch revision\n".
          "\t[-w]          Display the OS runtime Name\n".
          "\t[-x]          Display the OS runtime major revision\n".
          "\t[-y]          Display the OS runtime minor revision\n".
          "\t[-z]          Display the OS runtime patch revision\n".
          "\t[-m]          Display the machine type\n".
          "\t[-p]          Display the machine processor family\n".
          "\t[-i]          Display the machine/OS optimal instruction set\n".

          "\t[-a]          Display all system attributes\n".
          "\t                  Fields will be displayed in the following order:\n".
          "\t                      - Machine name\n".
          "\t                      - OS name\n".
          "\t                      - OS major revision number\n".
          "\t                      - OS minor revision number\n".
          "\t                      - OS patch revision number\n".
          "\t                      - OS runtime name\n".
          "\t                      - OS runtime major revision number\n".
          "\t                      - OS runtime minor revision number\n".
          "\t                      - OS runtime patch revision number\n".
          "\t                      - Machine type\n".
          "\t                      - Machine processor\n".
          "\t                      - Machine instruction set\n".
          "\t                      - Mentok (\"build 3\") platform name string\n".
          "\t[-d <delim>]  Specify a delimiter to use when printing multiple fields.\n".
          "\t                  The current delimiter is \"$config_delim\"\n".
          "\t[-3]          Display the \"Mentok\" fully qualified platform ID string\n".
          "\t[-l]          Display output in long format\n".
          "\t[-h]          Display help message\n");
}

sub normalize {
    local($string);

    $string = $_[0];
    $string =~ s/[\s\r\n\(\)]+/ /gm;
    $string =~ s/[\\\/]+/./gm;
    $string =~ s/^\s+//;
    $string =~ s/\s+$//;
    $string =~ s/ /_/g;
    return $string;
}
#
# Main
#


getopts('3ad:hilmMnNpPRswxyz');
$display_machineName = $opt_n || $opt_a;
$display_OSName = $opt_s  || $opt_a;
$display_OSRevMajor = $opt_M  || $opt_a;
$display_OSRevMinor = $opt_N  || $opt_a;
$display_OSRevPatch = $opt_P  || $opt_a;
$display_machineType = $opt_m  || $opt_a;
$display_machineProc = $opt_p  || $opt_a;
$display_machineInstset = $opt_i  || $opt_a;
$display_OSRuntimeName = $opt_w  || $opt_a;
$display_OSRuntimeRevMajor = $opt_x  || $opt_a;
$display_OSRuntimeRevMinor = $opt_y  || $opt_a;
$display_OSRuntimeRevPatch = $opt_z  || $opt_a;
$display_build3Platform = $opt_3 || $opt_a;

if ($opt_d) {
    $config_delim = $opt_d;
}
else {
    $config_delim = '|';
}

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
$result_OSName = normalize(`uname -s`);
$result_machineName = normalize(`uname -n`);

#
# Break down OS/kernel revision
#
$tmp_rev = normalize(`uname -r`);
($result_OSRevMajor, $result_OSRevMinor, $result_OSRevPatch) = split(/\./,$tmp_rev,3);
$result_OSRuntimeName = 'unknown';


#
# Refine notions of hardware and instruction sets,
#
$result_machineType = normalize(`uname -m`);
if ($result_OSName eq "HP-UX") {
    $result_machineProc = 'unknown';
}
else {
    $result_machineProc = normalize(`uname -p`);
}

# XXX I'm not sure if this is right. Check Mac OSX and Cygwin too
$result_machineInstset = $result_machineType;

if ($result_OSName eq "SunOS") {
    $result_machineInstset = normalize(`optisa i386 sparcv7 sparcv9`);
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
    }
    else {
        $result_OSRuntimeName = 'SunOS';
    }
    $result_OSRuntimeRevMajor = $result_OSRevMajor;
    $result_OSRuntimeRevMinor = $result_OSRevMinor;
    $result_OSRuntimeRevPatch = $result_OSRevPatch;

}
elsif ($result_OSName eq "Linux") {
    # Of course, with a million linux distros, there
    # is no easy way to do this.
    open(ETC_ISSUE, '/etc/issue');
    while (<ETC_ISSUE>) {
        push(@etc_issue, $_);
    }
    close(ETC_ISSUE);

    open(ETC_LSBRELEASE, '/etc/lsb-release');
    while (<ETC_LSBRELEASE>) {
        push(@etc_lsbrelease, $_);
    }
    close(ETC_LSBRELEASE);

    if (-f '/etc/gentoo-release') {
        # /etc/issue:
	#
        # This is \n.\O (\s \m \r) \t
	# 
	# /etc/gentoo-release:
        #
        # Gentoo Base System version 1.12.6
        # 
        $result_OSRuntimeName = 'Gentoo';

        open(ETC_DISTRORELEASE, '/etc/gentoo-release');
        while (<ETC_DISTRORELEASE>) {
	    if ($_ =~  /^\s*$/) { next; } 
            push(@etc_distrorelease, $_);
        }
        close(ETC_DISTRORELEASE);

        @tmp_version = grep(/Gentoo Base System/, @etc_distrorelease);
	$tmp_version = pop(@tmp_version);
	$tmp_version =~ s/^.*version\s+([^\s]+).*$/\1/;
        ($result_OSRuntimeRevMajor, $result_OSRuntimeRevMinor, $result_OSRuntimeRevPatch)
            = split(/\./, $tmp_version, 3);
    }
    elsif (-f '/etc/SuSE-release') {
        # /etc/issue:
        # 
        # Welcome to SUSE LINUX Enterprise Server 9 (i586) - Kernel \r (\l).
        # 
	# /etc/SuSE-release:
	# 
	# SUSE LINUX Enterprise Server 9 (i586)
	# VERSION = 9
	# 
        $result_OSRuntimeName = 'SuSE';

        open(ETC_DISTRORELEASE, '/etc/SuSE-release');
        while (<ETC_DISTRORELEASE>) {
	    if ($_ =~  /^\s*$/) { next; } 
            push(@etc_distrorelease, $_);
        }
        close(ETC_DISTRORELEASE);

        @tmp_version = grep(/VERSION/, @etc_distrorelease);
	$tmp_version = pop(@tmp_version);
	$tmp_version =~ s/.*=\s+//;
        ($result_OSRuntimeRevMajor, $result_OSRuntimeRevMinor, $result_OSRuntimeRevPatch)
            = split(/\./, $tmp_version, 3);
    }
    elsif (-f '/etc/UnitedLinux-release') {
        # /etc/issue:
        #
        # Welcome to UnitedLinux 1.0 (i586) - Kernel \r (\l).
        # 
        # Kernel 2.4.18-17.7.xsmp on a 2 processor i686
        # 
	#
	# /etc/UnitedLinux-release:
	# 
	# UnitedLinux 1.0 (i586)
	# VERSION = 1.0
	#
	# 
	# /etc/lsb-release:
	# LSB_VERSION="1.2"
	# DISTRIB_ID="UnitedLinux"
	# DISTRIB_RELEASE="1.0"
	# DISTRIB_DESCRIPTION="UnitedLinux 1.0 (i586)"
	# 
	$result_OSRuntimeName = 'UnitedLinux';

        open(ETC_DISTRORELEASE, '/etc/UnitedLinux-release');
        while (<ETC_DISTRORELEASE>) {
	    if ($_ =~  /^\s*$/) { next; } 
            push(@etc_distrorelease, $_);
        }
        close(ETC_DISTRORELEASE);

        @tmp_version = grep(/VERSION/, @etc_distrorelease);
	$tmp_version = pop(@tmp_version);
	$tmp_version =~ s/.*=\s+//;
        ($result_OSRuntimeRevMajor, $result_OSRuntimeRevMinor, $result_OSRuntimeRevPatch)
            = split(/\./, $tmp_version, 3);
    }
    #
    # Need to add RedHat Enterprise Linux here.
    # 
    elsif (-f '/etc/fedora-release') {
	# Fedora is redhat derived, so test for it before redhat.
	#
        # /etc/issue:
        # 
        # Fedora Core release 5 (Bordeaux)
	# Kernel \r on an \m
	# 
	# /etc/fedore-release:
	# 
        # Fedora Core release 5 (Bordeaux)
        # 
	$result_OSRuntimeName = 'FedoraCore';

        open(ETC_DISTRORELEASE, '/etc/fedora-release');
        while (<ETC_DISTRORELEASE>) {
	    if ($_ =~  /^\s*$/) { next; } 
            push(@etc_distrorelease, $_);
        }
        close(ETC_DISTRORELEASE);

	@tmp_version = grep(/Fedora Core/, @etc_distrorelease);
	$tmp_version = pop(@tmp_version);
	$tmp_version =~ s/^.*release\s+([^\s]+).*$/\1/;
        ($result_OSRuntimeRevMajor, $result_OSRuntimeRevMinor, $result_OSRuntimeRevPatch)
            = split(/\./, $tmp_version, 3);
    }
    elsif (-f '/etc/redhat-release') {
        # /etc/issue:
        # 
        # Red Hat Linux release 7.1 (Seawolf)
        # 
        # Kernel 2.4.18-17.7.xsmp on a 2 processor i686
        # 
	# 
	# /etc/redhat-release:
	# 
	# Red Hat Linux release 7.1 (Seawolf)
        # 
	$result_OSRuntimeName = 'RedHat';

        open(ETC_DISTRORELEASE, '/etc/redhat-release');
        while (<ETC_DISTRORELEASE>) {
	    if ($_ =~  /^\s*$/) { next; } 
            push(@etc_distrorelease, $_);
        }
        close(ETC_DISTRORELEASE);

	@tmp_version = grep(/Red Hat Linux/, @etc_distrorelease);
	$tmp_version = pop(@tmp_version);
	$tmp_version =~ s/^.*release\s+([^\s]+).*$/\1/;
        ($result_OSRuntimeRevMajor, $result_OSRuntimeRevMinor, $result_OSRuntimeRevPatch)
            = split(/\./, $tmp_version, 3);
    }
    elsif (grep(/Ubuntu/, @etc_issue)) {
	# Ubuntu is Debian derived, so test for it before Debian
	# 
	# /etc/issue: 
	# 
	# Ubuntu 6.06.1 LTS \n \l
	# 
	# 
	# /etc/lsb-release:
	# 
	# DISTRIB_ID=Ubuntu
	# DISTRIB_RELEASE=6.06
	# DISTRIB_CODENAME=dapper
	# DISTRIB_DESCRIPTION="Ubuntu 6.06.1 LTS"
	# 
	# 
	# /etc/debian_version: 
	# 
	# testing/unstable
	# 
	$result_OSRuntimeName = 'Ubuntu';

	@tmp_version = grep(/Ubuntu/, @etc_issue);
	$tmp_version = pop(@tmp_version);
	$tmp_version =~ s/^.*Ubuntu\s+([^\s]+).*$/\1/;
        ($result_OSRuntimeRevMajor, $result_OSRuntimeRevMinor, $result_OSRuntimeRevPatch)
            = split(/\./, $tmp_version, 3);

	# @tmp_version = grep(/DISTRIB_RELEASE/, @etc_lsbrelease);
	# $tmp_version = pop(@tmp_version);
	# $tmp_version =~ s/.*=\s+//;
        # ($result_OSRuntimeRevMajor, $result_OSRuntimeRevMinor, $result_OSRuntimeRevPatch)
        #     = split(/\./, $tmp_version, 3);
    }
    elsif (-f '/etc/debian_version') {
        # /etc/issue:
        # 
	# Debian GNU/Linux 4.0 \n \l
	#
	# /etc/debian_version:
	#
	# 4.0
	#
	# 
	$result_OSRuntimeName = 'Debian';
	
        open(ETC_DISTRORELEASE, '/etc/debian_version');
        while (<ETC_DISTRORELEASE>) {
	    if ($_ =~  /^\s*$/) { next; } 
            push(@etc_distrorelease, $_);
        }
        close(ETC_DISTRORELEASE);

	$tmp_version = shift(@etc_distrorelease);
        ($result_OSRuntimeRevMajor, $result_OSRuntimeRevMinor, $result_OSRuntimeRevPatch)
            = split(/\./, $tmp_version, 3);
    }
    else {
        $result_OSRuntimeName = 'unknown';
        $result_OSRuntimeRevMajor = 0;
        $result_OSRuntimeRevMinor = 0;
        $result_OSRuntimeRevPatch = 0;
    }
}
elsif ($result_OSName eq "Darwin") {
    $result_OSRuntimeName = normalize(`/usr/bin/sw_vers -productName`);
    $tmp_rev = normalize(`/usr/bin/sw_vers -productVersion`);
    ($result_OSRuntimeRevMajor, 
     $result_OSRuntimeRevMinor, 
     $result_OSRuntimeRevPatch) = split(/\./, $tmp_rev, 3);
    }
elsif ($result_OSName eq "HP-UX") {
    $result_OSRuntimeName = 'HP-UX';
    $result_OSRuntimeRevMajor = $result_OSRevMajor;
    $result_OSRuntimeRevMinor = $result_OSRevMinor;
    $result_OSRuntimeRevPatch = $result_OSRevPatch;
}
elsif ($result_OSName =~ "CYGWIN_NT") {
    # $result_OSName will have something like 
    # "CYGWIN_NT-5.1" from uname -s on Cygwin.
    # 
    # Cygwin is really a runtime, not the OS.
    # Furthermore, just because make is running
    # in the cygwin runtime, doesn't mean you are
    # compiling for the cygwin runtime.
    # 
    # we doctor things up for a Windows OS and Cygwin
    # runtime by default.

    # Cygwin puts the windows version in the OS name,
    # and the cygwin version in what's returned by
    # uname -r
    $tmp_runtime = $result_OSName;
    $result_OSName = 'Windows';

    $result_OSRuntimeRevMajor = $result_OSRevMajor;
    $result_OSRuntimeRevMinor = $result_OSRevMinor;
    $result_OSRuntimeRevPatch = $result_OSRevPatch;

    ($result_OSRuntimeName, $tmp_rev) = split(/-/, $tmp_runtime, 2);

    ($result_OSRevMajor, $result_OSRevMinor, $result_OSRevPatch) = 
        split(/\./, $tmp_rev, 3);
}


#
# Final cleanup. We don't like empty or messy values.
#
if (! ${result_machineName} )       { ${result_machineName} = "unknown" ; }
if (! ${result_OSName} )            { ${result_OSName} = "unknown" ; }
if (! ${result_OSRevMajor} )        { ${result_OSRevMajor} = "0" ; }
if (! ${result_OSRevMinor} )        { ${result_OSRevMinor} = "0" ; }
if (! ${result_OSRevPatch} )        { ${result_OSRevPatch} = "0" ; }
if (! ${result_OSRuntimeName} )     { ${result_OSRuntimeName} = "unknown" ; }
if (! ${result_OSRuntimeRevMajor} ) { ${result_OSRuntimeRevMajor} = "0" ; }
if (! ${result_OSRuntimeRevMinor} ) { ${result_OSRuntimeRevMinor} = "0" ; }
if (! ${result_OSRuntimeRevPatch} ) { ${result_OSRuntimeRevPatch} = "0" ; }
if (! ${result_machineType} )       { ${result_machineType} = "unknown" ; }
if (! ${result_machineProc} )       { ${result_machineProc} = "unknown" ; }
if (! ${result_machineInstset} )    { ${result_machineInstset} = "unknown" ; }

$result_machineName       = normalize($result_machineName);
$result_OSName            = normalize($result_OSName);
$result_OSRevMajor        = normalize($result_OSRevMajor);
$result_OSRevMinor        = normalize($result_OSRevMinor);
$result_OSRevPatch        = normalize($result_OSRevPatch);
$result_OSRuntimeName     = normalize($result_OSRuntimeName);
$result_OSRuntimeRevMajor = normalize($result_OSRuntimeRevMajor);
$result_OSRuntimeRevMinor = normalize($result_OSRuntimeRevMinor);
$result_OSRuntimeRevPatch = normalize($result_OSRuntimeRevPatch);
$result_machineType       = normalize($result_machineType);
$result_machineProc       = normalize($result_machineProc);
$result_machineInstset    = normalize($result_machineInstset);


#
# Build3's platform name (a constructed value)
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
