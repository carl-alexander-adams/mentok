#!/usr/bin/perl

# Usage:
#   shadowtree -s <src> -d <dst> [-l|-c]

# Require dependancies
use FileHandle;
use Getopt::Std;
use Cwd;
use File::Copy;

$|=1;

#
# parse CL
#
getopts('lcs:d:');

$ME=$0;
$ME=~s/.*\///;
$src_file = $opt_s || './';
$dst_dir = $opt_d || './';
$mode = "link"; # default mode
if ($opt_c) {$mode = "copy";}
if ($opt_l) {$mode = "link";}
$start_dir = cwd();


Util_mkPath($dst_dir);
$dst_dir = Util_normalizePath($dst_dir);
$src_file = Util_normalizePath($src_file);

if (($src_file eq '.') ||
  ($src_file =~ /\/\.\.$/)) {
  $trim_prefix = $src_file;
}
else {
  @tmp = split(/\//, $src_file);
  $garbage = pop(@tmp);
  $trim_prefix = join ('/', @tmp);
}

$trim_prefix = Util_normalizePath($trim_prefix);

print("Shadow Source: $src_file\n");
print("Shadow Destination Dir: $dst_dir\n");
print("Shadow Source trim prefix: $trim_prefix\n");

if (Util_normalizePath($src_file) eq Util_normalizePath($dst_dir)) {
  print("$ME: ERROR: Souce and destination appear to be the same.\n");
  exit(1);
}
if (! -d $dst_dir) {
  print("$ME: ERROR: Could not make shadow directory $dst_dir\n");
  exit(2);
}


# pass one - figure out what to do.
push(@src_files, $src_file);
while ($src_raw_path = pop(@src_files)) {

  $src_path = Util_normalizePath($src_raw_path);

  $dst_path = $src_path;
  if (${trim_prefix}) {
    $dst_path =~ s/^${trim_prefix}\///;
  }
  $dst_path = $dst_dir.'/'.$dst_path;
  $dst_path = Util_normalizePath($dst_path);

  if (-d $src_path) {
    if (($src_path ne '.') && (!Util_testSameDir($src_path, $dst_dir))){
      if (! -d "$dst_path") {
	push(@shadow_dirs, "$dst_path");
      }
    }

    opendir(D, $src_path) || die "Could not open directory $src_file. Bailing\n";
    @child_files = readdir(D);
    closedir(D);
    @child_files = grep(!/^\.\.{0,1}$/, @child_files);
    foreach $child_file (@child_files) {
      if ((-d "$src_path/$child_file") &&
	(Util_testSameDir("$src_path/$child_file", $dst_dir))){
	next;
      }
      push(@src_files, "$src_path/$child_file");
    }
  }
  else {
    if ($mode eq 'copy') {
      if (! -f $dst_path) {
	$shadow_copies{$dst_path} = $src_path;
      }
    }
    else {
      if (! -l $dst_path) {
	$shadow_symlinks{$dst_path} = $src_path;
      }	
    }
  }
}

# Pass two - do it
foreach $dir (@shadow_dirs) {
  print("\tShadowing Dir: $dir\n");
  Util_mkPath($dir);
}
foreach $dst (keys(%shadow_symlinks)) {
  print("\tShadowing File (Link): $dst\n");

  $src_dir = $shadow_symlinks{$dst};
  if ($src_dir =~ /\//) {
    $src_dir =~ s/\/[^\/]+$//;
  }
  else {
    $src_dir = '.';
  }

  $dst_dir = $dst;
  if ($dst_dir =~ /\//) {
    $dst_dir =~ s/\/[^\/]+$//;
  }
  else {
    $dst_dir = '.';
  }

  $shadow_relpath = Util_computeRelativePath($src_dir, $dst_dir);

  $src_filename = $shadow_symlinks{$dst};
  $src_filename  =~ s/.*\///;

  $link_text = "${shadow_relpath}/${src_filename}";
  $lint_text = Util_normalizePath($link_text);

  symlink($link_text, $dst)
    || die "could not create symlink $dst";
}
foreach $dst (keys(%shadow_copies)) {
  print("\tShadowing File (Copy): $dst\n");

  copy($shadow_copies{$dst}, $dst)
    || die "could not copy file $shadow_src to $shadow_dst";

  @stat_info = stat($shadow_copies{$dst});
  chmod(($stat_info[2] & 0x1ff), $dst);
}

sub Util_computeRelativePath {
  # given two paths, figure out a relative path to reference the
  # first path from a $cwd of the second.
  local($to_dir, $from_dir) = @_;
  local($old_cwd, $count, $depth, $rv, @to, @from);

  $old_cwd = cwd();

  chdir($to_dir) || die "Cound not chdir() to $to_dir in Util_computeRelativePath";
  $to_dir = cwd();
  chdir($old_cwd);

  chdir($from_dir) || die "Cound not chdir() to $from_dir in Util_computeRelativePath";
  $from_dir = cwd();
  chdir($old_cwd);

  @to = split(/\//,$to_dir);
  @from = split(/\//,$from_dir);
  $count = 0;
  while ( (($#to >= 0) && ($#from >= 0)) && ($to[0] eq $from[0])) {
    shift(@to);
    shift(@from);
    $count ++;
  }
  if ($count > 1) {
    # compute relative path
    $depth = $#from;
    for ( ; $depth >= 0 ; $depth--) {
      $rv .= "../";
    }
    $rv .= join('/',@to);
  }
  else {
    # / is common, just return an absolute path
    $rv = $to_dir;
  }

  $rv = Util_normalizePath($rv);
  return $rv;
}



sub Util_testSameDir {
  # given two paths, figure out if they are the same dir
  local($dir1, $dir2) = @_;
  local($old_cwd);

  $old_cwd = cwd();

  chdir($dir1);
  $dir1 = cwd();
  chdir($old_cwd);

  chdir($dir2);
  $dir2 = cwd();
  chdir($old_cwd);

  return ($dir1 eq $dir2);
}




sub Util_mkPath {
  local ($path) = @_;
  local ($dir, $done_path, $cur_dir, @path_parts);
  if ($path !~ /^\//) {
    $path = './'.$path;
  }
  @path_parts = split(/\//, $path);

  foreach $dir (@path_parts) {
    if ($dir ne "") {
      $cur_dir = $done_path."/".$dir;
      if ( ! -d $cur_dir) {
	mkdir ($cur_dir, 0755) || die "Could not make dir $cur_dir";
      }
    }

    if (defined($done_path)) {
      $done_path .= "/";
    }
    $done_path .= "$dir";
  }
}

sub Util_normalizePath {
  local($path) = @_;


  $path =~ s/\/\.\//\//g; # remove /./ from the path
  $path =~ s/\/$//;       # remove trailing /
  $path =~ s/\/\.$//;     # remove trailing ./
  $path =~ s/^\.\///;     # remove leading ./
  $path =~ s/\/+/\//g;    # compress /'s

  return $path;
}

