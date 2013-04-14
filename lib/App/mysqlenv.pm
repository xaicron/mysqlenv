package App::mysqlenv;
use 5.008005;
use strict;
use warnings;

our $VERSION = "0.01";

our $DEBUG;
our $MYSQLENV_HOME;

sub debug { $DEBUG }

sub home {
    return $MYSQLENV_HOME if $MYSQLENV_HOME;

    if ($ENV{MYSQLENV_HOME}) {
        $MYSQLENV_HOME = $ENV{MYSQLENV_HOME};
    }
    elsif ($ENV{HOME}) {
        $MYSQLENV_HOME = File::Spec->catdir($ENV{HOME}, ".mysqlenv");
        $ENV{MYSQLENV_HOME} = $MYSQLENV_HOME;
    }
    else {
        die "There is no ENV[MYSQLENV_HOME] or ENV[HOME]. Please set ENV[MYSQLENV_HOME].\n";
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

App::mysqlenv - It's new $module

=head1 SYNOPSIS

    use App::mysqlenv;

=head1 DESCRIPTION

App::mysqlenv is ...

=head1 LICENSE

Copyright (C) xaicron.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

xaicron E<lt>xaicron@gmail.comE<gt>

