use utf8;
use strict;
use warnings;
use Test::More tests => 1;

eval 'use Test::Pod::Coverage 1.00';

SKIP: {
    skip('Test::Pod::Coverage 1.00 not installed; skipping', 1) if $@;
    pod_coverage_ok('Lingua::Stem::UniNE');
}
