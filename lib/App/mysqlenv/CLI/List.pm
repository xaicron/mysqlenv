package App::mysqlenv::CLI::List;

use strict;
use warnings;
use App::mysqlenv::Util;
use App::mysqlenv::Logger;

sub run {
    my ($class, @argv) = @_;
    my $install_home = install_home;

    my ($current_version) = detect_version;
    chdir $install_home or die "$!: $install_home";
    opendir my $dh, '.' or die "$!: $install_home";
    for my $version (grep !/^\./ && -d, readdir $dh) {
        if ($version eq $current_version) {
            print "* $version\n";
        }
        else {
            print "  $version\n";
        }
    }

    return 1;
}

1;

__END__
