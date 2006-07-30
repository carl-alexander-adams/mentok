
### An Example Config

# REQUIRED: platforms
# 'hostname' => 'arch'
$config{'platforms'} = { 'fc4-1' => 'Linux-2.6.11-1.1369_FC4smp-i686', };

@{$config{'buildhosts'}} = keys %{$config{'platforms'}};

$config{'alarmwait'}  = 60*180; # 180 mins  

# REQUIRED:projectname
$config{'projectname'} = 'someproject';
# REQUIRED: toolsdir
$config{'toolsdir'}    = "/home/builds/scripts2";
# REQUIRED: buildroot
$config{'buildroot'}   = "/home/builds/$config{'projectname'}";
# REQUIRED: startdir (or we assume 'src' or '.'). 
$config{'startdir'}    = "somedir/$config{'projectname'}";
# Who we send email to on build status
$config{'notify'}      = 'someone@who.cares.com';

# REQUIRED: SCvar (Source Control Variable)

%SCVar = ( projectname => 'xplatform',
           SCVar1 => { 
              method => 'cvs',
              name   => 'xplatform_from_cvs',
              cvsmod => "recourse/$config{'projectname'}",
              _CVSROOT => ':ext:release@wopr:/cvs/components',
              _CVS_RSH => $defaults{'transport'},
           },
         );

# Another example

%SCvar = (
          projectname => 'SomeCodeBase',
          SCvar1 => {
                    name     => 'SomeCodeBase_FromCVS',
                    method   => 'cvs',
                    cvsmod   => 'src',
                    _CVSROOT => ':ext:user@hostname:/cvs/SomeCodeBase',
                    _CVS_RSH => $ssh,
                   },
          SCvar2 => {
                    name        => 'SomeCodeBasedocs_fromP4',
                    method      => 'perforce',
                    revision    => ' ', # yes.
                    _P4CLIENT   => 'working_client_spec',
                    _P4TEMPLATE => 'pristine_client_spec_template',
                    _P4PORT     => 'p4server:1666',
                    _P4USER     => 'p4user',
                    _P4PASSWD   => 'p4passwd',
                    _P4ROOT     => '/home/builds/SomeCodeBase/templates',
                   },
	  SCvar3 => {
                    name     => 'SomeCodeFrom_SVN',
                    method   => 'svn',
                    branch   => 'branches',
                    tag      => 'tags',
                    svnmod   => 'trunk',
                    base_url => 'your.server.com/svn',
                    svnmeth  => 'https',
                 },
);

# OPTIONAL: maincmd
# if each hostname needs a special config file of its own.

$config{'maincmd'} = ( 'hostname'     => 'special_config_file', );

$gmake = '/usr/local/bin/gmake';

# REQUIRED: client_build_sequence

# RUNDIR|USER|COMMAND|ARGS|TARGETS|IGNOREERROR|ENVS|ARBLOGFILE

# RUNDIR, dir to change to, 
#	can embed code.
# USER, user to run cmd as
# COMMAND, command to run
#	can embed code
# ARGS, arguments for the command
#	can embed code
# TARGETS, make-style targets for the command
#	can embed code
# IGNOREERROR, ignore errors generated by a command (Set it to "1" to enable)
# ENVS, set ENV vars before running cmd, form is "VAR=foo:bar|BAR=blah"
#	can embed code
# ARBLOGFILE, an arbitrary logfile, otherwise will form from command/target
#	can embed code

@client_build_sequence = (
        [ "", "", "$gmake", "-f", "Makefile-build3.mk" ],
        [ "", "", "$gmake", "", "depends" ],
        [ "", "", "$gmake", "", "all" ],
        [ "", "", "$gmake", "", "package" ],
);

### Another example. Note the late eval of '$ddir'. 

@client_build_sequence = (
        [ "", "", "$gmake", "-f Makefile.build", "", "", 
          "", "", "" ],
        [ "", "", "mkdir", "-p $buildroot/\$ddir/package", ""  ],
        [ "", "", "cp", "-f ../bin/something.o $config{'buildroot'}/\$ddir/package/something2.o", "" ],
        [ "", "", "$gmake", "", "full-clean" ],
        [ "", "", "$gmake", "-f Makefile.build", "", "", 
          "", "", "" ],
        [ "", "", "cp", "-f ../bin/something.o $config{'buildroot'}/\$ddir/package/something3.o", "" ],
	[ "", "", "$gmake", "-f Makefile.build", "package" ],
);

# OPTIONAL PRUNE_AFTER (Check Defaults.pl for default value)
# Our prunes.pl uses this to detemine whether or not to reap builds.
$config{'prune_after'} = 5;

# REQUIRED: buildtool
# This is the script that picks things up on the client side.
$config{'buildtool'} = "$config{'toolsdir'}/runbuild.pl";
# REQUIRED: cmdline
$config{'cmdline'} = $config{'buildtool'};

# OPTIONAL: altdist. This will override the 'dist'ing mechanism (packaging)
### XXX Rewrite alt dist to be in client_build_sequence form.

@altdist = ("directory", "command", 
            "directory", "command"); 
