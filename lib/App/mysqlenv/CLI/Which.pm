package App::mysqlenv::CLI::Which;

use strict;
use warnings;
use App::mysqlenv::Util;
use App::mysqlenv::Logger;

sub run {
    my ($class, @argv) = @_;

    my $bin = shift @argv || show_usage('which');
    my ($version, $file) = detect_version();

    my $shims_path = shims_path;
    my @path = grep { canonpath($_) ne $shims_path } File::Spec->path;

    unshift @path, bin_path $version if $version;

    if (my $fullpath = which $bin, @path) {
        print "$fullpath\n";
    }
    else {
        errorf '[mysqlenv] command not found: %s', $bin;
    }

    return 1;
}

1;

__DATA__

=head1 NAME

App::mysqlenv::CLI::Which - Locate a program file int the mysqlenv's path

=head1 SYNOPSIS

    mysqlenv which <command>

