package App::mysqlenv::CLI::Global;

use strict;
use warnings;
use App::mysqlenv::Util;
use App::mysqlenv::Logger;

sub run {
    my ($class, @argv) = @_;
    my $version_file = catdir mysqlenv_home, 'version';

    my $global_version = '';
    unless (-f $version_file) {
        $global_version = 'no set';
    }
    else {
        ($global_version) = read_file $version_file;
    }

    my $new_version = shift @argv;

    if (!$new_version || $global_version eq $new_version) {
        print "$global_version\n";
        exit;
    }

    unless (-d catdir install_home, $new_version) {
        errorf "$new_version was not found";
    }

    write_file $version_file, $new_version;

    return 1;
}

1;
