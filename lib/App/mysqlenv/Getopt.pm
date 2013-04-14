package App::mysqlenv::Getopt;

use strict;
use warnings;
use Getopt::Long;

sub parse_options {
    my ($class, $argv, @options) = @_;

    my $parser = Getopt::Long::Parser->new(
        config => [qw{
            posix_default no_ignore_case
            gnu_compat pass_through
        }],
    );

    $parser->getoptionsfromarray($argv => @options) or return;
    return $argv;
}

1;
