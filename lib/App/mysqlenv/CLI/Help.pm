package App::mysqlenv::CLI::Help;

use strict;
use warnings;
use Pod::Usage qw(pod2usage);
use App::mysqlenv::Logger;

sub run {
    my ($class, $command) = @_;

    my $target  = $0;
    my $verbose = 2;

    if ($command) {
        my $suffix = join '', map { ucfirst $_ } split '-', $command;
        my $module = "App::mysqlenv::CLI::$suffix";
        unless (eval "require $module; 1") { ## no critic
            errorf '[mysqlenv] command not implemented: %s', $command;
        }

        no strict 'refs';
        $target  = \*{"$module\::DATA"};
        $verbose = 1;
    }

    pod2usage(
        -verbose => $verbose,
        -input   => $target,
    );
}

1;

__END__
