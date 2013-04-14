package App::mysqlenv::Exception;

use strict;
use warnings;
use overload '""' => 'to_string', fallback => 1;
use Carp qw();

sub throw {
    my $class = shift;
    my $self = bless { msg => Carp::longmess($class) }, $class;
    die $self;
}

sub to_string {
    my $self = shift;
    $self->{msg};
}

1;

__END__
