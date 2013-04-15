package App::mysqlenv::CLI::Rehash;

use strict;
use warnings;
use App::mysqlenv::Util;
use App::mysqlenv::Logger;

sub run {
    my ($class, @argv) = @_;
    my $mysqlenv_home = mysqlenv_home;
    my $install_home  = install_home;
    my $shims         = catdir mysqlenv_home, 'shims';

    my %seen;
    for my $bin (map { basename $_ } grep { -x $_ } glob("$install_home/*/bin/*")) {
        next if $seen{$bin}++;

        my $shimbin = catfile $shims, $bin;
        my $cmd = sprintf q{exec "%s" exec "$program" "$@"}, rel2abs($0);
        write_file $shimbin, sprintf(<<'...', $mysqlenv_home, $cmd);
#!/usr/bin/env bash
set -e
[ -n "$MYSQLENV_DEBUG" ] && set -x

program="${0##*/}"

export MYSQLENV_HOME="%s"
%s
...
        chmod 0755, $shimbin or die "$!: $shimbin";
    }


    return 1;
}

1;

__DATA__

=head1 NAME

App::mysqlenv::CLI::Rehash - Run this command after install, contains executable script.

=head1 SYNOPSIS

    mysqlenv rehash

