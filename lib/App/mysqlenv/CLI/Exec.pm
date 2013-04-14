package App::mysqlenv::CLI::Exec;

use strict;
use warnings;
use App::mysqlenv::Util;
use App::mysqlenv::Logger;

sub run {
    my ($class, @args) = @_;
    my $bin = shift @args || show_usage('Exec');

    my $shims_path = shims_path;
    my ($version, $file) = detect_version;
    unless ($version) {
        $ENV{PATH} = join ':', grep { canonpath($_) ne $shims_path } File::Spec->path;
    }
    else {
        my $bindir = catdir install_home, $version, 'bin';
        unless (-x catfile $bindir, $bin) {
            errorf "[mysqlenv] $bin is not found in $bindir";
        }
        $ENV{PATH} = join ':', $bindir, $ENV{PATH};
    }

    exec $bin, @args;
    die $!;
}

1;

__END__
