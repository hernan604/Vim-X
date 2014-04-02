package TestsFor::Vim::X;

use strict;
use warnings;

use Vim::X;

use Test::Class::Moose;

sub test_setup {
    vim_command('new');
}

sub test_teardown {
    vim_command('close!');
}

sub test_vim_window :Tests {
    my $window = vim_window;

    isa_ok $window => 'Vim::X::Window', "get the right object";
}

sub test_vim_cursor :Tests {
    my $x = vim_cursor();

    isa_ok $x => 'Vim::X::Line', 'scalar invocation gives a line';

    is_deeply [ vim_cursor ] => [1,0], 'list context gives coordinates';
}

sub test_vim_append :Tests {
    
    vim_append( 'a'..'c' );

    is join( '!', vim_lines() ) => '!a!b!c', "append";

    vim_command( 'normal 3G' );
    vim_append( 'z' );
    is join( '!', vim_lines() ) => '!a!b!z!c', "append after line 2";

    vim_append( "foo\nbar" );
    is join( '!', vim_lines() ) => '!a!b!foo!bar!z!c', "split on CRs";

};

__PACKAGE__->new->runtests;

1;