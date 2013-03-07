use strict;
use warnings;
use utf8;
use open qw( :encoding(UTF-8) :std );
use Test::More tests => 3;
use Lingua::Stem::UniNE::CS qw( stem_cs );

is stem_cs('zvířatech'), 'zvíř', 'remove -atech';
is stem_cs('zvířatům'),  'zvíř', 'remove -atům';
is stem_cs('dítětem'),   'dít',  'replace -ětem with -ě';
