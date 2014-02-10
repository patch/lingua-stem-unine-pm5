use utf8;
use strict;
use warnings;
use open qw( :encoding(UTF-8) :std );
use Test::More tests => 12;
use Lingua::Stem::UniNE::DE qw( stem );

is stem('wäre'),   'war', 'replace: ä → a';
is stem('können'), 'kon', 'replace: ö → o';
is stem('über'),   'ube', 'replace: ü → u';
is stem('meinen'), 'mei', 'remove plural: -nen';
is stem('haben'),  'hab', 'remove plural: -en';
is stem('immer'),  'imm', 'remove plural: -er';
is stem('alles'),  'all', 'remove plural: -es';
is stem('diese'),  'die', 'remove plural: -se';
is stem('eine'),   'ein', 'remove plural: -e';
is stem('wenn'),   'wen', 'remove plural: -n';
is stem('aber'),   'abe', 'remove plural: -r';
is stem('dass'),   'das', 'remove plural: -s';
