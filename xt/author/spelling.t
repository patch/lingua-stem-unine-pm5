use utf8;
use strict;
use warnings;
use Test::More;

eval 'use Test::Spelling';
plan skip_all => 'Test::Spelling not installed; skipping' if $@;

# Test::Spelling only supports byte strings, not character strings :(
binmode DATA, ':bytes';

add_stopwords(<DATA>);
all_pod_files_spelling_ok();

__DATA__
Apfel
Äpfel
Bild
Bilder
casefolding
CPAN
derivational
Dolamic
IETF
Ljiljana
Neuchâtel
O’Regan
PDF
Shutterstock
Sohn
Söhne
stemmer
stemmers
UniNE
