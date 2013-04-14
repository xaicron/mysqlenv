package App::mysqlenv::CLI::Exec;

use strict;
use warnings;

sub run {
    my ($class, @commands) = @_;
    warn join "\n", @commands;
}

1;

__END__
