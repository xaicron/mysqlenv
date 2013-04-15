package App::mysqlenv::CLI::SelfInstall;

use strict;
use warnings;
use App::mysqlenv::Util;
use App::mysqlenv::Logger;

sub run {
    my ($class, @args) = @_;
    my $bindir = catdir mysqlenv_home, 'bin';
    unless (-d $bindir) {
        mkpath $bindir or die "$!: $bindir";
    }

    my $target = catfile $bindir, 'mysqlenv';
    my @lines  = read_file $0 or die "$!: $0";
    $lines[0]  = '#!/usr/bin/env perl'; # replace from #!perl

    write_file $target, @lines or die "$!: $target";

    chmod 0755, $target or die "$!: $target";

    system $target, 'init';
}

1;

__DATA__

=head1 NAME

App::mysqlenv::CLI::SelfInstall - Install mysqlenv itself $MYSQLENV_HOME/bin

=head1 SYNOPSIS

    mysqlenv self-install

