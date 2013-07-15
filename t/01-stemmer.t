use utf8;
use strict;
use warnings;
use open qw( :encoding(UTF-8) :std );
use Test::More tests => 31;
use Lingua::Stem::UniNE;

my (@words, @words_copy);

my $stemmer = new_ok 'Lingua::Stem::UniNE', [language => 'cs'];

can_ok $stemmer, qw( stem language languages );

is $stemmer->language, 'cs', 'language read-accessor';

my @langs = qw( bg cs fa );
my $langs = @langs;
is_deeply [$stemmer->languages],            \@langs, 'object method list';
is_deeply [Lingua::Stem::UniNE->languages], \@langs, 'class method list';
is_deeply [Lingua::Stem::UniNE::languages], \@langs, 'function list';
is scalar $stemmer->languages,               $langs, 'object method scalar';
is scalar Lingua::Stem::UniNE->languages,    $langs, 'class method scalar';
is scalar Lingua::Stem::UniNE::languages,    $langs, 'function scalar';

@words = @words_copy = qw( že dobře ještě );
is_deeply [$stemmer->stem(@words)], [qw( že dobř jesk )], 'list of words';
is_deeply \@words, \@words_copy, 'not destructive on arrays';

$stemmer->stem(\@words);
is_deeply \@words, [qw( že dobř jesk )], 'arrayref modified in place';

is_deeply scalar $stemmer->stem(@words), 'jesk', 'list of words in scalar';

is_deeply [$stemmer->stem('prosím')], ['pro'], 'word in list context';
is_deeply [$stemmer->stem()],         [],      'empty list in list context';
is scalar $stemmer->stem('prosím'),   'pro',   'word in scalar context';
is scalar $stemmer->stem(),           undef,   'empty list in scalar context';

is $stemmer->stem('работа'), 'работа', 'only stem for current language';

SKIP: {
    skip 'aggressive attribute NYI', 4;

    ok !$stemmer->aggressive,               'light stemmer by default';
    is $stemmer->stem('všechno'), 'všechn', 'light stemmer';
    $stemmer->aggressive(1);
    ok $stemmer->aggressive,                'aggressive stemmer explicitly set';
    is $stemmer->stem('všechno'), 'všech',  'aggressive stemmer';
}

$stemmer->language('bg');
is $stemmer->language,       'bg',  'language changed via write-accessor';
is $stemmer->stem('работа'), 'раб', 'language change confirmed by stemming';

$stemmer->language('CS');
is $stemmer->language,       'cs',  'language coerced via write-accessor';
is $stemmer->stem('prosím'), 'pro', 'language coersion confirmed by stemming';

eval { $stemmer->language('xx') };
like $@, qr/Invalid language 'xx'/, 'invalid language via write-accessor';

eval { $stemmer->language('') };
like $@, qr/Invalid language ''/, 'empty string as language via write-accessor';

eval { $stemmer->language(undef) };
like $@, qr/Invalid language ''/, 'undef as language via write-accessor';

eval { Lingua::Stem::UniNE->new(language => 'xx') };
like $@, qr/Invalid language 'xx'/, 'invalid language via instantiator';

eval { Lingua::Stem::UniNE->new() };
like $@, qr/Missing required arguments: language/, 'instantiator w/o language';
