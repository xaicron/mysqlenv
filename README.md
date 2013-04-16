# NAME

mysqlenv - MySQL environment manager

# SYNOPSIS

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

See `mysqlenv help` for the full documentation of mysqlenv.

See `mysqlenv help <command>` for detail description of the command.

# DESCRIPTION

...

# INSTALLATION

## 1\. Install your system

Run in your terminal the following:

    curl -kL https://raw.github.com/xaicron/mysqlenv/master/script/mysqlenv-install | bash

or

    cpanm git://github.com/xaicron/mysqlenv.git
    mysqlenv self-install

## 2\. Setup your shell

You should run the following:

    echo 'source ~/.mysqlenv/etc/bashrc' >> ~/.bashrc

__NOTE:__ if you using `zsh` then modify your ~/.zshrc .

And restart your shell.

# BUG REPORTING

Plese use github issues: [http://github.com/xaicron/mysqlenv/](http://github.com/xaicron/mysqlenv/).

# LICENSE

Copyright (C) xaicron.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

xaicron <xaicron@gmail.com>
