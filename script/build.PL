#!/usr/bin/env perl

use strict;
use warnings;
use File::pushd;
use File::Find;
use File::Slurp;

mkdir '.tmp', 0777;
system qw(cp -r fatlib lib .tmp);

my $fatpack = do {
    my $dir = pushd '.tmp';

    my $want = sub {
        if (/\.pm$/) {
            print "perlstrip $_\n";
            system 'perlstrip', $_;
        }
    };

    find { wanted => $want, no_chdir => 1 }, qw(fatlib lib);
    `fatpack file`;
};

my @code = ($fatpack, read_file './script/mysqlenv.PL');

write_file 'bin/mysqlenv', '#!perl', @code;
chmod 0755, 'bin/mysqlenv';

END {
    system qw(rm -r .tmp);
}

1;
