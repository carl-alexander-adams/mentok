#!/usr/bin/perl
#
#
# Unified platform identifier.
# This script produces cannonical platform identification
# strings used in the new new build. Consider it a beefed up "uname".
#
# This tool was originally written as part of the mentok build system 
# for Recourse Technologies & Symantec Corporation.
#
# Copyright (c) 2003-2006 Symantec Corporation.
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR THE COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# 

use Getopt::Std;

#############################################################################
##
## Main
##
#############################################################################

#
# Empty init.
#
$result = {};

#
# Process args.
#

getopts('3ad:hilmMnNpPRswxyz') || die;
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
# Do the work.
#

plat_getOS($result);
plat_getHostname($result);

if ($result->{'OSName'} eq "SunOS") {
    plat_refineSunOS($result);
}
elsif ($result->{'OSName'} eq "Linux") {
    plat_refineLinux($result);
}
elsif ($result->{'OSName'} eq "Darwin") {
    plat_refineDarwin($result);
}
elsif ($result->{'OSName'} =~ "CYGWIN_NT") {
    plat_refineCygwin($result);
}
elsif ($result->{'OSName'} =~ "AIX") {
    plat_refineAIX($result);
}
elsif ($result->{'OSName'} =~ "HP-UX") {
    plat_refineHPUX($result);
}
else {
    plat_refineUnknown($result);
}

plat_normalize($result);
plat_constructBuild3($result);


#
# Output
#
if ($display_format eq 'long') {
    #
    # Long format output
    #
    if ($display_machineName) {
        print("Host Name                       : $result->{'machineName'}\n");
    }
    if ($display_OSName) {
        print("OS Name                         : $result->{'OSName'}\n");
    }
    if ($display_OSRevMajor) {
        print("OS Revision Major               : $result->{'OSRevMajor'}\n");
    }
    if ($display_OSRevMinor) {
        print("OS Revision Minor               : $result->{'OSRevMinor'}\n");
    }
    if ($display_OSRevPatch) {
        print("OS Revision Patch               : $result->{'OSRevPatch'}\n");
    }
    if ($display_OSRuntimeName) {
        print("OS Runtime Name                 : $result->{'OSRuntimeName'}\n");
    }
    if ($display_OSRuntimeRevMajor) {
        print("OS Runtime Revision Major       : $result->{'OSRuntimeRevMajor'}\n");
    }
    if ($display_OSRuntimeRevMinor) {
        print("OS Runtime Revision Minor       : $result->{'OSRuntimeRevMinor'}\n");
    }
    if ($display_OSRuntimeRevPatch) {
        print("OS Runtime Revision Patch       : $result->{'OSRuntimeRevPatch'}\n");
    }
    if ($display_machineType) {
        print("Machine Type                    : $result->{'machineType'}\n");
    }
    if ($display_machineProc) {
        print("Processor Type                  : $result->{'machineProc'}\n");
    }
    if ($display_machineInstset) {
        print("Processor Instruction Set       : $result->{'machineInstset'}\n");
    }
    if ($display_build3Platform) {
        print("Mentok Platform Name            : $result->{'build3Platform'}\n");
    }
} else {
    #
    # Sort format output
    #
    $delim = '';
    if ($display_machineName) {
        print("${delim}$result->{'machineName'}");
        $delim = $config_delim;
    }
    if ($display_OSName) {
        print("${delim}$result->{'OSName'}");
        $delim = $config_delim;
    }
    if ($display_OSRevMajor) {
        print("${delim}$result->{'OSRevMajor'}");
        $delim = $config_delim;
    }
    if ($display_OSRevMinor) {
        print("${delim}$result->{'OSRevMinor'}");
        $delim = $config_delim;
    }
    if ($display_OSRevPatch) {
        print("${delim}$result->{'OSRevPatch'}");
        $delim = $config_delim;
    }
    if ($display_OSRuntimeName) {
        print("${delim}$result->{'OSRuntimeName'}");
        $delim = $config_delim;
    }
    if ($display_OSRuntimeRevMajor) {
        print("${delim}$result->{'OSRuntimeRevMajor'}");
        $delim = $config_delim;
    }
    if ($display_OSRuntimeRevMinor) {
        print("${delim}$result->{'OSRuntimeRevMinor'}");
        $delim = $config_delim;
    }
    if ($display_OSRuntimeRevPatch) {
        print("${delim}$result->{'OSRuntimeRevPatch'}");
        $delim = $config_delim;
    }
    if ($display_machineType) {
        print("${delim}$result->{'machineType'}");
        $delim = $config_delim;
    }
    if ($display_machineProc) {
        print("${delim}$result->{'machineProc'}");
        $delim = $config_delim;
    }
    if ($display_machineInstset) {
        print("${delim}$result->{'machineInstset'}");
        $delim = $config_delim;
    }
    if ($display_build3Platform) {
        print("${delim}$result->{'build3Platform'}");
        $delim = $config_delim;
    }
}

print("\n");


#############################################################################
##
## Subs
##
#############################################################################

sub plat_getOS {
    local($platinfo) = @_;
    local($tmp_rev);

    $platinfo->{'OSName'} = normalize(`uname -s`);
    (! $?) || die "Error calling \"uname -s\"";

    $tmp_rev = normalize(`uname -r`);
    (! $?) || die "Error calling \"uname -r\"";

    ($platinfo->{'OSRevMajor'},
     $platinfo->{'OSRevMinor'},
     $platinfo->{'OSRevPatch'}) = split(/\./,$tmp_rev,3);
}

sub plat_getHostname {
    local($platinfo) = @_;

    $platinfo->{'machineName'} = normalize(`uname -n`);
    (! $?) || die "Error calling \"uname -n\"";
}


sub plat_refineSunOS {
    local($platinfo) = @_;

    #
    # Runtime
    # 
    if ($platinfo->{'OSRevMajor'} eq '5') {
        $platinfo->{'OSRuntimeName'} = 'Solaris';
    }
    else {
        $platinfo->{'OSRuntimeName'} = 'SunOS';
    }
    $platinfo->{'OSRuntimeRevMajor'} = $platinfo->{'OSRevMajor'};
    $platinfo->{'OSRuntimeRevMinor'} = $platinfo->{'OSRevMinor'};
    $platinfo->{'OSRuntimeRevPatch'} = $platinfo->{'OSRevPatch'};

    #
    # machine type
    # 
    $result->{'machineType'} = normalize(`uname -m`);
    (! $?) || die "Error calling \"uname -m\"";

    $result->{'machineProc'} = normalize(`uname -p`); 
    (! $?) || die "Error calling \"uname -p\"";

    $result->{'machineInstset'} = normalize(`optisa i386 sparcv7 sparcv9`);
    (! $?) || die "Error calling \"optisa i386 sparcv7 sparcv9\"";
}

sub plat_refineLinux {
    local($platinfo) = @_;
    local($tmp_rev,
          $tmp_version,
          $tmp_proc,
          @proc_cpuinfo,
          @tmp_proc,
          @etc_issue,
          @etc_lsbrelease,
          @etc_distrorelease,
          @tmp_version);

    #
    # Runtime
    # 

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
        $platinfo->{'OSRuntimeName'} = 'Gentoo';

        open(ETC_DISTRORELEASE, '/etc/gentoo-release');
        while (<ETC_DISTRORELEASE>) {
	    if ($_ =~  /^\s*$/) { next; } 
            push(@etc_distrorelease, $_);
        }
        close(ETC_DISTRORELEASE);

        @tmp_version = grep(/Gentoo Base System/, @etc_distrorelease);
        $tmp_version = pop(@tmp_version);
        $tmp_version =~ s/^.*version\s+([^\s]+).*$/\1/;
        ($platinfo->{'OSRuntimeRevMajor'},
         $platinfo->{'OSRuntimeRevMinor'},
         $platinfo->{'OSRuntimeRevPatch'}) = split(/\./, $tmp_version, 3);
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
        $platinfo->{'OSRuntimeName'} = 'SuSE';

        open(ETC_DISTRORELEASE, '/etc/SuSE-release');
        while (<ETC_DISTRORELEASE>) {
	    if ($_ =~  /^\s*$/) { next; } 
            push(@etc_distrorelease, $_);
        }
        close(ETC_DISTRORELEASE); # 

        @tmp_version = grep(/VERSION/, @etc_distrorelease);
        $tmp_version = pop(@tmp_version);
        $tmp_version =~ s/.*=\s+//;
        ($platinfo->{'OSRuntimeRevMajor'},
         $platinfo->{'OSRuntimeRevMinor'},
         $platinfo->{'OSRuntimeRevPatch'}) = split(/\./, $tmp_version, 3);
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
        $platinfo->{'OSRuntimeName'} = 'UnitedLinux';
        
        open(ETC_DISTRORELEASE, '/etc/UnitedLinux-release');
        while (<ETC_DISTRORELEASE>) {
	    if ($_ =~  /^\s*$/) { next; } 
            push(@etc_distrorelease, $_);
        }
        close(ETC_DISTRORELEASE);

        @tmp_version = grep(/VERSION/, @etc_distrorelease);
        $tmp_version = pop(@tmp_version);
        $tmp_version =~ s/.*=\s+//;
        ($platinfo->{'OSRuntimeRevMajor'},
         $platinfo->{'OSRuntimeRevMinor'},
         $platinfo->{'OSRuntimeRevPatch'}) = split(/\./, $tmp_version, 3);
    }
    #
    # Need to add RedHat Enterprise Linux here.
    # 
    elsif (-f '/etc/fedora-release') {
        # Fedora is redhat derived, so test for it before redhat.
        #
        # /etc/issue (FC 5):
        # Fedora Core release 5 (Bordeaux)
        # Kernel \r on an \m
        # 
        # /etc/fedore-release (FC 5)
        # Fedora Core release 5 (Bordeaux)
        # 
        # /etc/issue (FC 10): 
        # Fedora release 10 (Cambridge)
        # Kernel \r on an \m (\l)
        # 
        # /etc/fedore-release (FC 10):
        # Fedora release 10 (Cambridge)
        # 

        open(ETC_DISTRORELEASE, '/etc/fedora-release');
        while (<ETC_DISTRORELEASE>) {
	    if ($_ =~  /^\s*$/) { next; } 
            push(@etc_distrorelease, $_);
        }
        close(ETC_DISTRORELEASE);

        if (grep(/Fedora Core/, @etc_distrorelease)) {
            $platinfo->{'OSRuntimeName'} = 'FedoraCore';
        }
        else {
            $platinfo->{'OSRuntimeName'} = 'Fedora';
        }

        @tmp_version = grep(/Fedora.*release/, @etc_distrorelease);
        $tmp_version = pop(@tmp_version);
        $tmp_version =~ s/^.*release\s+([^\s]+).*$/\1/;
        ($platinfo->{'OSRuntimeRevMajor'},
         $platinfo->{'OSRuntimeRevMinor'},
         $platinfo->{'OSRuntimeRevPatch'}) = split(/\./, $tmp_version, 3);
    }
    elsif (-f '/etc/redhat-release') {
        # /etc/issue (RH 7.1)
        # Red Hat Linux release 7.1 (Seawolf)
        # 
        # Kernel 2.4.18-17.7.xsmp on a 2 processor i686
        # 
        # 
        # /etc/redhat-release (RH 7.1)
        # Red Hat Linux release 7.1 (Seawolf)
        # 
        # /etc/redhat-release (RHAS 3.0):
        # Red Hat Enterprise Linux AS release 3 (Taroon)
        #
        # /etc/redhat-release (RHES 4.0):
        # Red Hat Enterprise Linux ES release 4 (Nahant)


        open(ETC_DISTRORELEASE, '/etc/redhat-release');
        while (<ETC_DISTRORELEASE>) {
	    if ($_ =~  /^\s*$/) { next; } 
            push(@etc_distrorelease, $_);
        }
        close(ETC_DISTRORELEASE);


        if (grep(/Red Hat Enterprise Linux AS/, @etc_distrorelease)) {
            $platinfo->{'OSRuntimeName'} = 'RHAS';
        }
        elsif (grep(/Red Hat Enterprise Linux ES/, @etc_distrorelease)) {
            $platinfo->{'OSRuntimeName'} = 'RHES';
        }
        else {
            $platinfo->{'OSRuntimeName'} = 'RedHat';
        }
        @tmp_version = grep(/Red Hat.*release/, @etc_distrorelease);
        $tmp_version = pop(@tmp_version);
        # $tmp_version =~ s/^.*release\s+([^\s]+).*$/\1/; # why is this not working on RHES 3?        
        $tmp_version =~ s/^.*release\s+//;
        $tmp_version =~ s/\s+.*$//;
        ($platinfo->{'OSRuntimeRevMajor'},
         $platinfo->{'OSRuntimeRevMinor'},
         $platinfo->{'OSRuntimeRevPatch'}) = split(/\./, $tmp_version, 3);
    }
    elsif (grep(/Ubuntu/, @etc_issue)) {
        # Ubuntu is Debian derived, so test for it before Debian
        # 
        # /etc/issue: 
        # 
        # Ubuntu 6.06.1 LTS \n \l

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
        $platinfo->{'OSRuntimeName'} = 'Ubuntu';

        @tmp_version = grep(/Ubuntu/, @etc_issue);
        $tmp_version = pop(@tmp_version);
        $tmp_version =~ s/^.*Ubuntu\s+([^\s]+).*$/\1/;
        ($platinfo->{'OSRuntimeRevMajor'},
         $platinfo->{'OSRuntimeRevMinor'},
         $platinfo->{'OSRuntimeRevPatch'}) = split(/\./, $tmp_version, 3);

        # @tmp_version = grep(/DISTRIB_RELEASE/, @etc_lsbrelease);
        # $tmp_version = pop(@tmp_version);
        # $tmp_version =~ s/.*=\s+//;
        # ($platinfo->{'OSRuntimeRevMajor'},
        #  $platinfo->{'OSRuntimeRevMinor'},
        #  $platinfo->{'OSRuntimeRevPatch'}) = split(/\./, $tmp_version, 3);
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
        $platinfo->{'OSRuntimeName'} = 'Debian';
	
        open(ETC_DISTRORELEASE, '/etc/debian_version');
        while (<ETC_DISTRORELEASE>) {
	    if ($_ =~  /^\s*$/) { next; } 
            push(@etc_distrorelease, $_);
        }
        close(ETC_DISTRORELEASE);

        $tmp_version = shift(@etc_distrorelease);
        ($platinfo->{'OSRuntimeRevMajor'},
         $platinfo->{'OSRuntimeRevMinor'},
         $platinfo->{'OSRuntimeRevPatch'}) = split(/\./, $tmp_version, 3);
    }
    else {
        $platinfo->{'OSRuntimeName'} = 'unknown';
        $platinfo->{'OSRuntimeRevMajor'} = 0;
        $platinfo->{'OSRuntimeRevMinor'} = 0;
        $platinfo->{'OSRuntimeRevPatch'} = 0;
    }


    #
    # Machine type
    # 
    $result->{'machineType'} = normalize(`uname -m`);
    (! $?) || die "Error calling \"uname -m\"";

    $result->{'machineProc'} = normalize(`uname -p`); 
    (! $?) || die "Error calling \"uname -p\"";

    #    if ($result->{'machineProc'} eq 'unknown') {
    #        open(PROC_CPUINFO, '/proc/cpuinfo');
    #        while (<PROC_CPUINFO>) {
    #            push(@proc_cpuinfo, $_);
    #        }
    #        close(PROC_CPUINFO);
    #        @tmp_proc = grep(/model name/, @proc_cpuinfo);
    #        $tmp_proc = pop(@tmp_proc);
    #        $tmp_proc =~ s/.*model name\s*:\s*//;
    #        $tmp_proc = normalize($tmp_proc);
    #        $result->{'machineProc'} = $tmp_proc;
    #    }

    $result->{'machineInstset'} = $result->{'machineType'};
}

sub plat_refineDarwin {
    local($platinfo) = @_;
    local($tmp_rev);

    #
    # Runtime
    # 

    $platinfo->{'OSRuntimeName'} = normalize(`/usr/bin/sw_vers -productName`);
    (! $?) || die "Error calling \"/usr/bin/sw_vers -productName\"";
    
    $tmp_rev = normalize(`/usr/bin/sw_vers -productVersion`);
    (! $?) || die "Error calling \"/usr/bin/sw_vers -productVersion\"";
    
    ($platinfo->{'OSRuntimeRevMajor'}, 
     $platinfo->{'OSRuntimeRevMinor'}, 
     $platinfo->{'OSRuntimeRevPatch'}) = split(/\./, $tmp_rev, 3);

    #
    # Machine type
    # 
    $result->{'machineType'} = normalize(`uname -m`);
    (! $?) || die "Error calling \"uname -m\"";

    $result->{'machineProc'} = normalize(`uname -p`); 
    (! $?) || die "Error calling \"uname -p\"";

    # $result->{'machineInstset'} = $result->{'machineType'};
}


sub plat_refineCygwin {
    local($platinfo) = @_;
    local($tmp_runtime,
          $tmp_rev);

    #
    # Runtime
    # 

    # $platinfo->{'OSName'} will have something like 
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
    $tmp_runtime = $platinfo->{'OSName'};
    $platinfo->{'OSName'} = 'Windows';

    $platinfo->{'OSRuntimeRevMajor'} = $platinfo->{'OSRevMajor'};
    $platinfo->{'OSRuntimeRevMinor'} = $platinfo->{'OSRevMinor'};
    $platinfo->{'OSRuntimeRevPatch'} = $platinfo->{'OSRevPatch'};

    ($platinfo->{'OSRuntimeName'}, $tmp_rev) = split(/-/, $tmp_runtime, 2);

    ($platinfo->{'OSRevMajor'},
     $platinfo->{'OSRevMinor'},
     $platinfo->{'OSRevPatch'}) = 
        split(/\./, $tmp_rev, 3);

    #
    # Machine type
    # 
    $result->{'machineType'} = normalize(`uname -m`);
    (! $?) || die "Error calling \"uname -m\"";

    $result->{'machineProc'} = normalize(`uname -p`); 
    (! $?) || die "Error calling \"uname -p\"";

    # $result->{'machineInstset'} = $result->{'machineType'};
}

sub plat_refineAIX {
    local($platinfo) = @_;

    #
    # OS needs some repair on AIX.
    # 
    $platinfo->{'OSRevMajor'} = normalize(`uname -v`);
    (! $?) || die "Error calling \"uname -v\"";

    $platinfo->{'OSRevMinor'} = normalize(`uname -r`);
    (! $?) || die "Error calling \"uname -r\"";
    
    $platinfo->{'OSRevPatch'} = '';


    #
    # Runtime
    # 
    $platinfo->{'OSRuntimeName'} = $platinfo->{'OSName'};
    $platinfo->{'OSRuntimeRevMajor'} = $platinfo->{'OSRevMajor'};
    $platinfo->{'OSRuntimeRevMinor'} = $platinfo->{'OSRevMinor'};
    $platinfo->{'OSRuntimeRevPatch'} = $platinfo->{'OSRevPatch'};

    #
    # Machine type
    # 
    $result->{'machineType'} = normalize(`uname -m`);
    (! $?) || die "Error calling \"uname -m\"";

    # $result->{'machineProc'} = normalize(`uname -p`); 
    # (! $?) || die "Error calling \"uname -p\"";

    # $result->{'machineInstset'} = $result->{'machineType'};
}

sub plat_refineHPUX {
    local($platinfo) = @_;

    #
    # Runtime
    # 

    $platinfo->{'OSRuntimeName'} = $platinfo->{'OSName'};
    $platinfo->{'OSRuntimeRevMajor'} = $platinfo->{'OSRevMajor'};
    $platinfo->{'OSRuntimeRevMinor'} = $platinfo->{'OSRevMinor'};
    $platinfo->{'OSRuntimeRevPatch'} = $platinfo->{'OSRevPatch'};

    #
    # Machine type
    # 
    $result->{'machineType'} = normalize(`uname -m`);
    (! $?) || die "Error calling \"uname -m\"";

    # $result->{'machineProc'} = normalize(`uname -p`); 
    # (! $?) || die "Error calling \"uname -p\"";

    # $result->{'machineInstset'} = $result->{'machineType'};
}

sub plat_refineUnknown {
    local($platinfo) = @_;

    #
    # Runtime
    # 

    #
    # Machine type
    # 
    (0) || die "refineUnknown not implemented.\n";
}

sub plat_constructBuild3 {
    local($platinfo) = @_;

    $platinfo->{'build3Platform'} = "$platinfo->{'OSName'}-";
    if ($platinfo->{'OSRevMajor'}) {$platinfo->{'build3Platform'} .= "$platinfo->{'OSRevMajor'}";}
    if ($platinfo->{'OSRevMinor'}) {$platinfo->{'build3Platform'} .= ".$platinfo->{'OSRevMinor'}";}
    if ($platinfo->{'OSRevPatch'}) {$platinfo->{'build3Platform'} .= ".$platinfo->{'OSRevPatch'}";}
    $platinfo->{'build3Platform'} .= "-$platinfo->{'machineInstset'}-$platinfo->{'OSRuntimeName'}-";
    if ($platinfo->{'OSRuntimeRevMajor'}) {$platinfo->{'build3Platform'} .= "$platinfo->{'OSRuntimeRevMajor'}";}
    if ($platinfo->{'OSRuntimeRevMinor'}) {$platinfo->{'build3Platform'} .= ".$platinfo->{'OSRuntimeRevMinor'}";}
    if ($platinfo->{'OSRuntimeRevPatch'}) {$platinfo->{'build3Platform'} .= ".$platinfo->{'OSRuntimeRevPatch'}";}

}

sub plat_normalize {
    local($platinfo) = @_;
    if (! $platinfo->{'machineName'} )       { $platinfo->{'machineName'} = "unknown" ; }
    if (! $platinfo->{'OSName'} )            { $platinfo->{'OSName'} = "unknown" ; }
    if (! $platinfo->{'OSRevMajor'} )        { $platinfo->{'OSRevMajor'} = "0" ; }
    if (! $platinfo->{'OSRevMinor'} )        { $platinfo->{'OSRevMinor'} = "0" ; }
    if (! $platinfo->{'OSRevPatch'} )        { $platinfo->{'OSRevPatch'} = "0" ; }
    if (! $platinfo->{'OSRuntimeName'} )     { $platinfo->{'OSRuntimeName'} = "unknown" ; }
    if (! $platinfo->{'OSRuntimeRevMajor'} ) { $platinfo->{'OSRuntimeRevMajor'} = "0" ; }
    if (! $platinfo->{'OSRuntimeRevMinor'} ) { $platinfo->{'OSRuntimeRevMinor'} = "0" ; }
    if (! $platinfo->{'OSRuntimeRevPatch'} ) { $platinfo->{'OSRuntimeRevPatch'} = "0" ; }
    if (! $platinfo->{'machineType'} )       { $platinfo->{'machineType'} = "unknown" ; }
    if (! $platinfo->{'machineProc'} )       { $platinfo->{'machineProc'} = "unknown" ; }
    if (! $platinfo->{'machineInstset'} )    { $platinfo->{'machineInstset'} = "unknown" ; }
    
    $platinfo->{'machineName'}       = normalize($platinfo->{'machineName'});
    $platinfo->{'OSName'}            = normalize($platinfo->{'OSName'});
    $platinfo->{'OSRevMajor'}        = normalize($platinfo->{'OSRevMajor'});
    $platinfo->{'OSRevMinor'}        = normalize($platinfo->{'OSRevMinor'});
    $platinfo->{'OSRevPatch'}        = normalize($platinfo->{'OSRevPatch'});
    $platinfo->{'OSRuntimeName'}     = normalize($platinfo->{'OSRuntimeName'});
    $platinfo->{'OSRuntimeRevMajor'} = normalize($platinfo->{'OSRuntimeRevMajor'});
    $platinfo->{'OSRuntimeRevMinor'} = normalize($platinfo->{'OSRuntimeRevMinor'});
    $platinfo->{'OSRuntimeRevPatch'} = normalize($platinfo->{'OSRuntimeRevPatch'});
    $platinfo->{'machineType'}       = normalize($platinfo->{'machineType'});
    $platinfo->{'machineProc'}       = normalize($platinfo->{'machineProc'});
    $platinfo->{'machineInstset'}    = normalize($platinfo->{'machineInstset'});
}

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
    $string =~ s/[\\\/]+/ /gm;
    $string =~ s/^\s+//;
    $string =~ s/\s+$//;
    $string =~ s/ /_/g;
    return $string;
}
