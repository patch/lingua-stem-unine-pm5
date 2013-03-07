use strict;
use warnings;
use utf8;
use open qw( :encoding(UTF-8) :std );
use Test::More tests => 12;
use Lingua::Stem::UniNE::CS qw( stem_cs );

is stem_cs('zvířatech'), 'zvíř',  'remove -atech';
is stem_cs('zvířatům'),  'zvíř',  'remove -atům';
is stem_cs('dítětem'),   'dít',   'remove -tem from -ětem';
is stem_cs('kterými'),   'kter',  'remove -ými';
is stem_cs('rukama'),    'ruk',   'remove -ama';
is stem_cs('ženami'),    'žen',   'remove -ami';
is stem_cs('zvířata'),   'zvíř',  'remove -ata';
is stem_cs('zvířaty'),   'zvíř',  'remove -aty';
is stem_cs('pánové'),    'pán',   'remove -ové';
is stem_cs('tátovi'),    'tát',   'remove -ovi';
is stem_cs('novinách'),  'novin', 'remove -ách';
is stem_cs('kterých'),   'kter',  'remove -ých';
