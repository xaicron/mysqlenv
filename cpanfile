#!perl

on 'configure' => sub {
};

on 'build' => sub {
};

on 'test' => sub {
    requires 'Test::More', '>= 0.98, < 2.0';
};

on 'develop' => sub {
};

