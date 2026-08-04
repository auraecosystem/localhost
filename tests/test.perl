Test::Simple:

use Test::Simple;
use strict;
use warnings;

sub main {
    # ...
}

sub my_func {
    my $t = shift;

    return "wibble";
}

sub tests {
    ok( my_func("flibble") eq "wibble", "test_flibble" );
}

if ( grep (/^--unittest$/, @ARGV )) {
    tests();
    exit;
}

main();
