#!/usr/bin/env perl

use strict;
use warnings;
use File::pushd;
use File::Find;
use File::Slurp;

mkdir '.build', 0777;
system qw(cp -r fatlib lib .build/);

my $fatpack = do {
    my $dir = pushd '.build';

    my $want = sub {
        if (/\.pm$/) {
            print "perlstrip $_\n";
            system 'perlstrip', $_;
        }
    };

    find { wanted => $want, no_chdir => 1 }, 'fatlib', 'lib';
    `fatpack file`;
};

write_file 'bin/mysqlenv', $fatpack;
chmod 0755, 'bin/mysqlenv';

END {
    system qw(rm -r .build);
}

1;
