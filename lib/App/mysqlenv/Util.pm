package App::mysqlenv::Util;

use strict;
use warnings;
use parent 'Exporter';

use Cwd;
use File::Path;
use File::Spec::Functions;
use File::Slurp;

use App::mysqlenv;
use App::mysqlenv::Logger;

our @EXPORT = qw{
    command mkpath rmtree catdir getcwd
    write_file read_file
    mysqlenv_home
};

sub mysqlenv_home {
    App::mysqlenv->home;
}

sub command {
    my @commands = @_;
    infof 'run %s', join ' ', @_;
    !system(@_) or die "$!";
}

1;
