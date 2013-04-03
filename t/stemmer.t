use utf8;
use strict;
use warnings;
use open qw( :encoding(UTF-8) :std );
use Test::More tests => 9;
use Lingua::Stem::UniNE;

my $stemmer = new_ok 'Lingua::Stem::UniNE', [language => 'cs'];

can_ok $stemmer, qw( stem language languages );

is scalar $stemmer->stem('prosím'),   'pro',   'word in scalar context';
is_deeply [$stemmer->stem('prosím')], ['pro'], 'word in list context';
is scalar $stemmer->stem(),           undef,   'empty list in scalar context';
is_deeply [$stemmer->stem()],         [],      'empty list in list context';

my @words = qw( že dobře ještě );
is_deeply [$stemmer->stem(@words)], [qw( že dobř jesk )], 'list of words';
is_deeply \@words, [qw( že dobře ještě )], 'not destructive on arrays';

$stemmer->stem(\@words);
is_deeply \@words, [qw( že dobř jesk )], 'arrayref modified in place';
