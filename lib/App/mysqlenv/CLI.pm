package App::mysqlenv::CLI;

use strict;
use warnings;
use Path::Tiny;
use File::Which qw(which);
use Getopt::Long;

use App::mysqlenv;
use App::mysqlenv::CLI::Init;
use App::mysqlenv::CLI::Help;
use App::mysqlenv::CLI::Install;
use App::mysqlenv::CLI::List;
use App::mysqlenv::CLI::Use;
use App::mysqlenv::CLI::Exec;
use App::mysqlenv::CLI::Switch;
use App::mysqlenv::CLI::Version;
use App::mysqlenv::Logger;

sub new {
    my $class = shift;
    bless {}, $class;
}

sub run {
    my ($self, @argv) = @_;
    @argv = @ARGV unless @argv;

    local $App::mysqlenv::DEBUG = 0;
    local $App::mysqlenv::Logger::COLOR = -t STDOUT ? 1 : 0;

    my @commands;
    my $parser = Getopt::Long::Parser->new(
        config => [qw{
            posix_default no_ignore_case
            gnu_compat pass_through
        }],
    );
    $parser->getoptionsfromarray(
        \@argv => (
            'h|help'  => sub { unshift @commands, 'help' },
            'debug!'  => \$App::mysqlenv::DEBUG,
            'color!'  => \$App::mysqlenv::Logger::COLOR,
            'version' => \&show_version,
        ),
    );

    push @commands, @argv;

    my $cmd   = shift @commands || 'help';
    my $klass = sprintf 'App::mysqlenv::CLI::%s',
        join '', map { ucfirst $_ } split '-', $cmd;

    unless (eval "require $klass; 1") { ## no critic
        warnf("Could not find command '%s'\n", $cmd);
        exit 2;
    }

    eval {
        $klass->run(@commands);
    };
    if (my $e = $@) {
        errorf("%s\n", $e);
        exit 1;
    }

    return 1;
}

sub show_version {
    print "mysqlenv (App::mysqlenv) $App::mysqlenv::VERSION\n";
    exit 0;
}

1;
__END__
