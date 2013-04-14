package App::mysqlenv::Logger;

use strict;
use warnings;
use parent 'Exporter';

use Term::ANSIColor qw(colored);

use App::mysqlenv::Exception;

our @EXPORT = qw{ debugf infof warnf errorf };

our $COLOR;

use constant {
    DEBUG => 1,
    INFO  => 2,
    WARN  => 3,
    ERROR => 4,
};

our $Colors = {
    DEBUG ,=> 'green',
    INFO  ,=> 'cyan',
    WARN  ,=> 'yellow',
    ERROR ,=> 'red',
};

sub _print {
    my($msg, $type) = @_;
    return if $type == DEBUG && !App::mysqlenv->debug;
    $msg = colored $msg, $Colors->{$type} if defined $type && $COLOR;
    my $fh = $type && $type >= WARN ? *STDERR : *STDOUT;
    print {$fh} $msg, "\n";
}

sub _printf {
    my $type = pop;
    my($temp, @args) = @_;
    _print sprintf($temp, map { defined $_ ? $_ : '-' } @args), $type;
}

sub debugf {
    _printf @_, DEBUG;
}

sub infof {
    _printf @_, INFO;
}

sub warnf {
    _printf @_, WARN;
}

sub errorf {
    _printf @_, ERROR;
    App::mysqlenv::Exception->throw;
}

1;

__END__
