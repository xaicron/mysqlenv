package App::mysqlenv::Util;

use strict;
use warnings;
use parent 'Exporter';

use Cwd qw(getcwd);
use File::Basename qw(basename dirname);
use File::Path qw(mkpath rmtree);
use File::Spec::Functions qw(catdir catfile canonpath rel2abs);
use File::Slurp qw(write_file read_file);

use App::mysqlenv::Logger;

our @EXPORT = qw{
    mkpath
    rmtree
    catdir
    catfile
    rel2abs
    canonpath
    basename
    dirname
    getcwd
    write_file
    read_file
    command
    mysqlenv_home
    install_home
    shims_path
    bin_path
    detect_version
    find_mysqlenv_version_file
    find_lcoal_mysqlenv_version_file
    find_global_mysqlenv_version_file
    slurp_version
    show_usage
    which
    http_get_command
    http_get
};

sub mysqlenv_home {
    my $home;
    if ($ENV{MYSQLENV_HOME}) {
        $home = $ENV{MYSQLENV_HOME};
    }
    elsif ($ENV{HOME}) {
        $home = catdir $ENV{HOME}, '.mysqlenv';
        $ENV{MYSQLENV_HOME} = $home;
    }
    else {
        die "There is no ENV[MYSQLENV_HOME] or ENV[HOME]. Please set ENV[MYSQLENV_HOME].\n";
    }

    $ENV{MYSQLENV_HOME} = canonpath $home;
}

sub install_home {
    canonpath catdir mysqlenv_home(), 'mysqls';
}

sub shims_path {
    canonpath catdir mysqlenv_home, 'shims';
}

sub bin_path {
    my $version = shift;
    canonpath catdir install_home, $version, 'bin';
}

sub which {
    my ($bin, @path) = @_;
    @path = File::Spec->path unless @path;
    for my $dir (@path) {
        my $fullpath = catfile $dir, $bin;
        next unless -x $fullpath;
        return $fullpath;
    }

    return undef;
}

sub detect_version {
    return $ENV{MYSQLENV_VERSION} if $ENV{MYSQLENV_VERSION};
    if (my $file = find_mysqlenv_version_file()) {
        my $version = slurp_version($file);
        return ($version, $file);
    }
    return undef;
}

sub find_mysqlenv_version_file {
    find_lcoal_mysqlenv_version_file() || find_global_mysqlenv_version_file();
}

sub find_lcoal_mysqlenv_version_file {
    my $dir = getcwd();
    my %seen;
    while (-d $dir) {
        return undef if $seen{$dir}++; # for symlink
        if (-f "$dir/.mysql-version") {
            return "$dir/.mysql-version";
        }
        $dir = dirname $dir;
    }

    return undef;
}

sub find_global_mysqlenv_version_file {
    my $mysqlenv_version_file = catfile mysqlenv_home(), 'version';
    return $mysqlenv_version_file if -f $mysqlenv_version_file;
    return undef;
}

sub slurp_version {
    my $file = shift;
    return unless -f $file;
    my ($version) = read_file $file or die "$!: $file";
    return $version;
}

sub command {
    my @commands = @_;
    infof 'run: %s', join ' ', @_;
    !system(@_) or die "$?";
}

sub show_usage {
    require App::mysqlenv::CLI::Help;
    App::mysqlenv::CLI::Help->run(@_);
    exit 1;
}

sub http_get_command {
    my $http_get_command;
    if (which 'curl') {
        $http_get_command = 'curl -kfsSL';
    }
    elsif (which 'wget') {
        $http_get_command = 'wget -O -';
    }
    else {
        errorf '`curl` or `wget` command  should be installed.';
    }

    $http_get_command;
}

sub http_get {
    my ($url) = @_;
    my $http_get_command = http_get_command();
    my $devnull = File::Spec->devnull;
    `$http_get_command $url 2> $devnull`;
}

1;
