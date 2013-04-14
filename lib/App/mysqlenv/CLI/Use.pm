package App::mysqlenv::CLI::Use;

use strict;
use warnings;

sub run {
    my ($class, @commands) = @_;
    warn join "\n", @commands;
}

1;

__END__
