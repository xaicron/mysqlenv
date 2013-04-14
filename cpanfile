#!perl

on 'configure' => sub {
};

on 'build' => sub {
};

on 'test' => sub {
    requires 'Test::More', '>= 0.98, < 2.0';
};

on 'develop' => sub {
    requires 'File::Slurp'  => '9999.19';
    requires 'File::pushd'  => '1.005';
    requires 'Getopt::Long' => '2.39';
};

