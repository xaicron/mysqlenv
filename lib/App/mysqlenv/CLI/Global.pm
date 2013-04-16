package App::mysqlenv::CLI::Global;

use strict;
use warnings;
use App::mysqlenv::Util;
use App::mysqlenv::Logger;

sub run {
    my ($class, @argv) = @_;
    my $version_file = find_global_mysqlenv_version_file;

    my $global_version = '';
    if ($version_file && -f $version_file) {
        $global_version = slurp_version($version_file);
    }

    my $new_version = shift @argv;

    unless ($new_version || $global_version) {
        show_usage('global');
    }

    if (!$new_version || $global_version eq $new_version) {
        print "$global_version\n";
        exit;
    }

    unless (-d catdir install_home, $new_version) {
        errorf "$new_version was not found";
    }

    $version_file ||= catfile mysqlenv_home, 'version';
    write_file $version_file, $new_version;

    return 1;
}

1;

__DATA__

=head1 NAME

App::mysqlenv::CLI::Global - Change global mysql version

=head1 SYNOPSIS

    mysqlenv global [version]

