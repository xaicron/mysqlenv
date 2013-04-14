package App::mysqlenv::CLI::Help;

use strict;
use warnings;

sub run {
    my ($class, @args) = @_;
    my $module = $args[0] ? "App::mysqlenv::CLI::$args[0]" : 'App::mysqlenv';
    system 'perldoc', $module;
}

1;

__END__
