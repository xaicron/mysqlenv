package App::mysqlenv::CLI::Init;

use strict;
use warnings;
use App::mysqlenv::Util;
use App::mysqlenv::Logger;

my $MYSQLBUILD_REPOS = 'https://github.com/kamipo/mysql-build.git';

sub run {
    my ($class, @args) = @_;
    my $home = mysqlenv_home;

    mkdir $home or errorf "$!: $home" unless -d $home;
    chdir $home or errorf "$!: $home";

    mkpath $_ for qw{ bin mysqls etc shims };
    unless (-d 'mysql-build') {
        command 'git', 'clone', $MYSQLBUILD_REPOS, 'mysql-build';
    }

    my $etc = catdir $home, 'etc';
    chdir $etc or errorf "$!: $etc";

    for my $data (
        [ 'bashrc' => '_BASHRC_CONTENT' ],
#        [ 'cshrc'  => '_CSHRC_CONTENT'  ],
    ) {
        my ($file, $method) = @$data;
        write_file $file, $class->$method or die "$!: $etc/$file";
    }

    print << "INSTRUCTION";

mysqlenv is initialized ($home).

Append the following piece of code to the end of your ~/.bashrc or ~/.zshrc
and start a new shell.

    source ~/.mysqlenv/etc/bashrc

Simply run `mysqlenv` for usage details.

INSTRUCTION

    return 1;
}

sub _BASHRC_CONTENT {
    my $home = mysqlenv_home;
    return << "ERC";
export PATH=$home/bin:$home/shims:$home/mysql-build/bin:\$PATH
ERC
}

1;

__END__
