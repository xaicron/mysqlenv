package App::mysqlenv::CLI;

use strict;
use warnings;

use App::mysqlenv;
use App::mysqlenv::CLI::Init;
use App::mysqlenv::CLI::Help;
use App::mysqlenv::CLI::Available;
use App::mysqlenv::CLI::Install;
use App::mysqlenv::CLI::List;
use App::mysqlenv::CLI::Global;
use App::mysqlenv::CLI::Local;
use App::mysqlenv::CLI::Rehash;
use App::mysqlenv::CLI::Exec;
use App::mysqlenv::CLI::Version;
use App::mysqlenv::CLI::Which;
use App::mysqlenv::Logger;
use App::mysqlenv::Getopt;

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
    App::mysqlenv::Getopt->parse_options(
        \@argv => (
            'h|help'    => sub { unshift @commands, 'help' },
            'debug!'    => \$App::mysqlenv::DEBUG,
            'color!'    => \$App::mysqlenv::Logger::COLOR,
            'V|version' => \&show_version,
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
    print "mysqlenv (App::mysqlenv) version $App::mysqlenv::VERSION\n";
    exit 0;
}

1;
__END__
