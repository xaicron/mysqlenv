#!/usr/bin/env perl

use strict;
use warnings;
use App::mysqlenv::CLI;

App::mysqlenv::CLI->new->run;

__END__

=head1 NAME

mysqlenv - MySQL environment manager

=head1 SYNOPSIS

mysqlenv command syntax:

    mysqlenv <command> [options] [arguments]

Commands:

    # show usage
    mysqlenv help

    # list available mysql versions
    mysqlenv available

    # install mysql binary
    mysqlenv install 5.6.10

    # list installed mysqls
    mysqlenv list

    # execute command on current mysql
    mysqlenv exec mysql -uroot test -e '...'

    # change global default mysql to 5.1.68
    mysqlenv global 5.1.68

    # change local mysql to 5.5.30
    mysqlenv local 5.5.30

    # run this command after install, contains executable script.
    mysqlenv rehash

    # locate a program file in the mysql's path
    mysqlenv which mysqladmin

    # show current mysql version
    mysqlenv version

Generic command options:

    -h, --help      Shortcut of `mysqlenv help`.
    --version       Show mysqlenv version.

See C<< mysqlenv help >> for the full documentation of mysqlenv.

See C<< mysqlenv help <command> >> for detail description of the command.

=head1 DESCRIPTION

MySQL A-GO!GO!

=head1 INSTALLATION

=head2 1. Install your system

Run in your terminal the following:

  curl -kL http://bit.ly/mysqlenv | bash

or

  cpanm git://github.com/xaicron/mysqlenv.git
  mysqlenv self-install

=head2 2. Setup your shell

You should run the following:

  echo 'source ~/.mysqlenv/etc/bashrc' >> ~/.bashrc

B<< NOTE: >> if you using C<< zsh >> then modify your ~/.zshrc .

And restart your shell.

=head1 BUG REPORTING

Plese use github issues: L<< https://github.com/xaicron/mysqlenv/issues >>.

=head1 LICENSE

Copyright (C) xaicron.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

xaicron E<lt>xaicron@gmail.comE<gt>

