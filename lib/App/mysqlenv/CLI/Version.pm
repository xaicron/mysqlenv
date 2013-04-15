package App::mysqlenv::CLI::Version;

use strict;
use warnings;
use App::mysqlenv::Util;
use App::mysqlenv::Logger;

sub run {
    my ($class, @argv) = @_;
    my ($current_version, $file) = detect_version;

    unless ($current_version) {
        errorf '[mysqlenv] Could not detect mysql version.';
    }

    print "$current_version (set by $file)";

    return 1;
}

1;

__DATA__

=head1 NAME

App::mysqlenv::CLI::Version - Show current mysql version

=head1 SYNOPSIS

    mysqlenv version

