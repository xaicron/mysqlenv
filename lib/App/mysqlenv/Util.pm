package App::mysqlenv::Util;

use strict;
use warnings;
use parent 'Exporter';

use Cwd qw(getcwd);
use File::Basename qw(basename);
use File::Path qw(mkpath rmtree);
use File::Spec::Functions qw(catdir catfile rel2abs);
use File::Slurp qw(write_file read_file);

use App::mysqlenv ();
use App::mysqlenv::Logger;

our @EXPORT = qw{
    mkpath
    rmtree
    catdir
    catfile
    rel2abs
    basename
    getcwd
    write_file
    read_file
    command
    mysqlenv_home
    install_home
    current_version
    show_usage
};

sub mysqlenv_home {
    App::mysqlenv->home;
}

sub install_home {
    catdir mysqlenv_home(), 'mysqls';
}

sub current_version {
    $ENV{MYSQLENV_VERSION} || '-';
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

1;
