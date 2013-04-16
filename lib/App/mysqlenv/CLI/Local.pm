package App::mysqlenv::CLI::Local;

use strict;
use warnings;
use App::mysqlenv::Util;
use App::mysqlenv::Logger;

sub run {
    my ($class, @argv) = @_;

    my $version = shift @argv;
    if ($version) {
        unless (-d catfile install_home, $version) {
            errorf '[mysqlenv] %s is not installed', $version;
        }
        write_file '.mysql-version', $version;
    }
    else {
        if (my $file = find_lcoal_mysqlenv_version_file) {
            print slurp_version($file), "\n";
        }
        else {
            errorf '[mysqlenv] no local version configured for this directory';
        }
    }

    return 1;
}

1;

__DATA__

=head1 NAME

App::mysqlenv::CLI::SelfInstall - Setes local mysql version under the directory

=head1 SYNOPSIS

    mysqlenv local [version]

