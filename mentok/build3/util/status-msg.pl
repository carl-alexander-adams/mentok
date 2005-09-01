#!/usr/bin/perl
#
# status-msg: A small utility to set a status message in
# in the xterm title bar. This utility exists to get around
# the pain of shell and makefile excaping of the term coded
# that need to appear in the echo.
#

if($ENV{'MENTOK_STATUSREPORT'} eq 'XTERM_TITLE') {
  printf("\033]0;%s\007", join(' ', @ARGV));
}

