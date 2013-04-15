package App::mysqlenv::CLI::Which;

use strict;
use warnings;
use App::mysqlenv::Util;
use App::mysqlenv::Logger;

sub run {
    my ($class, @argv) = @_;

    my $bin = shift @argv || show_usage('which');
    my ($version, $file) = detect_version();

    my $shims_path = shims_path;
    my @path = grep { canonpath($_) ne $shims_path } File::Spec->path;

    if (my $fullpath = which $bin, @path) {
        print "$fullpath\n";
    }
    else {
        errorf '[mysqlenv] command not found: %s', $bin;
    }

    return 1;
}

1;

__END__
