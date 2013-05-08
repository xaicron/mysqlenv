package App::mysqlenv::CLI::SelfUpgrade;

use strict;
use warnings;
use App::mysqlenv::Util;
use App::mysqlenv::Logger;
use App::mysqlenv::Getopt;

sub run {
    my ($class, @args) = @_;
    my $install_code = http_get 'http://bit.ly/mysqlenv';
    unless ($install_code) {
        errorf 'Could not fetch upgrade script';
    }

    open my $pipe, '|-', 'bash' or die $!;
    print {$pipe} $install_code;
    close $pipe;

    my $mysql_build_path = catdir mysqlenv_home, 'mysql-build';
    chdir $mysql_build_path or errorf "$!: $mysql_build_path";
    command qw/git pull origin master/;

    return 1;
}

1;

__DATA__

=head1 NAME

App::mysqlenv::CLI::SelfUpgrade - Upgrades itself

=head1 SYNOPSIS

    mysqlenv self-upgrade

