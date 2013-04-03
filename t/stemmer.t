use utf8;
use strict;
use warnings;
use open qw( :encoding(UTF-8) :std );
use Test::More tests => 21;
use Test::Deep;
use Lingua::Stem::UniNE;

my ($stemmer, @words, @words_copy);

$stemmer = new_ok 'Lingua::Stem::UniNE', [language => 'cs'];

can_ok $stemmer, qw( stem language languages );

is $stemmer->language, 'cs', 'language read-accessor';

is scalar $stemmer->languages, 3, 'supported number of languages';
cmp_deeply [$stemmer->languages], qr/^[a-z]{2}$/, 'supported language codes';

@words = @words_copy = qw( že dobře ještě );
is_deeply [$stemmer->stem(@words)], [qw( že dobř jesk )], 'list of words';
is_deeply \@words, \@words_copy, 'not destructive on arrays';

$stemmer->stem(\@words);
is_deeply \@words, [qw( že dobř jesk )], 'arrayref modified in place';

is scalar $stemmer->stem('prosím'),   'pro',   'word in scalar context';
is_deeply [$stemmer->stem('prosím')], ['pro'], 'word in list context';
is scalar $stemmer->stem(),           undef,   'empty list in scalar context';
is_deeply [$stemmer->stem()],         [],      'empty list in list context';

is $stemmer->stem('работа'), 'работа', 'only stem for current language';

$stemmer->language('fa');
is $stemmer->language,       'fa',  'language changed via write-accessor';
is $stemmer->stem('работа'), 'раб', 'language change confirmed by stemming';

$stemmer = new_ok 'Lingua::Stem::UniNE', [], 'instantiate with no language';

is $stemmer->language, undef, 'language read-accessor w/o language';

@words = @words_copy = qw( ještě работа );
is_deeply [$stemmer->stem(@words)], \@words_copy, 'no stemming w/o language';

$stemmer->stem(\@words);
is_deeply \@words, \@words_copy, 'no in-place stemming w/o language set';

$stemmer->language('cs');
is $stemmer->language,       'cs',  'language changed after no language';
is $stemmer->stem('prosím'), 'pro', 'language change confirmed by stemming';
