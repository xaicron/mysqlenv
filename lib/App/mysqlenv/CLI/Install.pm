package App::mysqlenv::CLI::Install;

use strict;
use warnings;
use App::mysqlenv::Util;
use App::mysqlenv::Logger;
use App::mysqlenv::Getopt;

sub run {
    my ($class, @args) = @_;
    my $install_home = install_home;

    App::mysqlenv::Getopt->parse_options(
        \@args => (
            'v|verbose!' => \my $verbose,
            '--as=s'     => \my $as,
        ),
    );

    my $version = shift @args || show_usage('install');

    my $install_path = catdir $install_home, $as || $version;
    if (-d $install_path) {
        errorf '%s is exists', $install_path;
    }

    command 'mysql-build',
        ($verbose ? '-v' : ()),
        $version, $install_path,
        (@args ? ('--', @args) : ()),
    ;

    chdir $install_path or die "$!: $install_path";
    command './scripts/mysql_install_db';

    infof 'Successfully install!';

    print << "NOTE";

You can try

\$ mysqlenv global $version

NOTE

    system $0, 'rehash';

    return 1;
}

1;

__DATA__

=head1 NAME

App::mysqlenv::CLI::Install - Build and install mysql binary

=head1 SYNOPSIS

    mysqlenv install [options] <version> [arguments]

=head1 OPTIONS

    -v, --verbose       Chatty build log.
        --as            Install the given version of MySQL by a name.

