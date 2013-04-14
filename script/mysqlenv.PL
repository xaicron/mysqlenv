#!/usr/bin/env perl

use strict;
use warnings;
use App::mysqlenv::CLI;

App::mysqlenv::CLI->new->run;

__END__

=head1 NAME

mysqlenv - mysq binary manager

=head1 SYNOPSIS

    mysqlenv help

    # list available mysql versions
    mysqlenv available

    # install mysql binary
    mysqlenv install 5.6.10

    # execute command on current mysql
    mysqlenv exec mysql -V

    # change global default mysql to 5.1.68
    mysqlenv global 5.1.68

    # change local mysql to 5.5.30
    mysqlenv local 5.5.30

    # run this command after install, contains executable script.
    mysqlenv rehash

    # locate a program file in the mysql's path
    mysqlenv which cpanm

=head1 DESCRIPTION

...

=head1 INSTALLATION

...

=head1 BUG REPORTING

Plese use github issues: L<< http://github.com/xaicron/mysqlenv/ >>.

=head1 LICENSE

Copyright (C) xaicron.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

xaicron E<lt>xaicron@gmail.comE<gt>

