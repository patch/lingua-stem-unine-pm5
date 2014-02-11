use utf8;
use strict;
use warnings;
use open qw( :encoding(UTF-8) :std );
use Test::More tests => 57;
use Lingua::Stem::UniNE::DE qw( stem stem_aggressive );

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

*stem2 = \&stem_aggressive;

is stem2('capitán'),   'capitan', 'replace: á → a';
is stem2('voilà'),     'voila',   'replace: à → a';
is stem2('château'),   'chateau', 'replace: â → a';
is stem2('hätt'),      'hatt',    'replace: ä → a';
is stem2('sí'),        'si',      'replace: í → i';
is stem2('ìadch'),     'iadch',   'replace: ì → i';
is stem2('nothîng'),   'nothing', 'replace: î → i';
is stem2('sï'),        'si',      'replace: ï → i';
is stem2('ramón'),     'ramon',   'replace: ó → o';
is stem2('totò'),      'toto',    'replace: ò → o';
is stem2('kônig'),     'konig',   'replace: ô → o';
is stem2('schön'),     'schon',   'replace: ö → o';
is stem2('jesús'),     'jesus',   'replace: ú → u';
is stem2('où'),        'ou',      'replace: ù → u';
is stem2('fûr'),       'fur',     'replace: û → u';
is stem2('für'),       'fur',     'replace: ü → u';
is stem2('gestern'),   'gest',    'step 1 remove: -ern';
is stem2('einem'),     'ein',     'step 1 remove: -em';
is stem2('eigen'),     'eig',     'step 1 remove: -en';
is stem2('unser'),     'uns',     'step 1 remove: -er';
is stem2('alles'),     'all',     'step 1 remove: -es';
is stem2('eine'),      'ein',     'step 1 remove: -e';
is stem2('krebs'),     'kreb',    'step 1 remove: -s from -bs';
is stem2('abends'),    'abend',   'step 1 remove: -s from -ds';
is stem2('aufs'),      'auf',     'step 1 remove: -s from -fs';
is stem2('jungs'),     'jung',    'step 1 remove: -s from -gs';
is stem2('sechs'),     'sech',    'step 1 remove: -s from -hs';
is stem2('links'),     'link',    'step 1 remove: -s from -ks';
is stem2('niemals'),   'niemal',  'step 1 remove: -s from -ls';
is stem2('films'),     'film',    'step 1 remove: -s from -ms';
is stem2('eins'),      'ein',     'step 1 remove: -s from -ns';
is stem2('nichts'),    'nicht',   'step 1 remove: -s from -ts';
is stem2('schwester'), 'schw',    'step 2 remove: -est';
is stem2('eigenen'),   'eig',     'step 2 remove: -en';
is stem2('unsere'),    'uns',     'step 2 remove: -er';
is stem2('selbst'),    'selb',    'step 2 remove: -st from -bst';
is stem2('lädst'),     'lad',     'step 2 remove: -st from -dst';
is stem2('darfst'),    'darf',    'step 2 remove: -st from -fst';
is stem2('angst'),     'ang',     'step 2 remove: -st from -gst';
is stem2('machst'),    'mach',    'step 2 remove: -st from -hst';
is stem2('denkst'),    'denk',    'step 2 remove: -st from -kst';
is stem2('willst'),    'will',    'step 2 remove: -st from -lst';
is stem2('kommst'),    'komm',    'step 2 remove: -st from -mst';
is stem2('kannst'),    'kann',    'step 2 remove: -st from -nst';
is stem2('hältst'),    'halt',    'step 2 remove: -st from -tst';