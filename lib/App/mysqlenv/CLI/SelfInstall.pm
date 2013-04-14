package App::mysqlenv::CLI::SelfInstall;

use strict;
use warnings;
use App::mysqlenv::Util;
use App::mysqlenv::Logger;

sub run {
    my ($class, @args) = @_;
    my $target = catdir mysqlenv_home, 'bin', 'mysqlenv';

    my @files = read_file $0;
    write_file $target, read_file $0 or die "$!: $target";

    chmod 0755, $target or die "$!: $target";

    system $target, 'init';
}

1;
