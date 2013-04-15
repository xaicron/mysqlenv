package App::mysqlenv::CLI::Available;

use strict;
use warnings;
use App::mysqlenv::Util;
use App::mysqlenv::Logger;

sub run {
    my ($class, @argv) = @_;
    system 'mysql-build', '--definitions' and die "$!";

    return 1;
}

1;

__DATA__

=head1 NAME

App::mysqlenv::CLI::Available - List available mysql versions

=head1 SYNOPSIS

    mysqlenv available

