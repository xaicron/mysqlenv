package App::mysqlenv::CLI::Help;

use strict;
use warnings;

sub run {
    my ($class, @args) = @_;
    my $target = $args[0] ? "App::mysqlenv::CLI::$args[0]" : $0;
    system 'perldoc', $target;
}

1;

__END__
