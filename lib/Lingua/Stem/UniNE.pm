package Lingua::Stem::UniNE;

use v5.8;
use utf8;
use strict;
use warnings;

our $VERSION = '0.00_1';

1;

__END__

=encoding UTF-8

=head1 NAME

Lingua::Stem::UniNE - University of Neuchâtel stemmers

=head1 VERSION

This document describes Lingua::Stem::UniNE v0.00_1.

=head1 SYNOPSIS

    use Lingua::Stem::UniNE;

    # create Bulgarian stemmer
    $stemmer = Lingua::Stem::UniNE->new(language => 'bg');

    # get stem for word
    $stem = $stemmer->stem($word);

    # get list of stems for list of words
    @stems = $stemmer->stem(@words);

    # replace words in array reference with stems
    $stemmer->stem(\@words);

=head1 DESCRIPTION

This module contains a collection of stemmers for multiple languages based on
stemming algorithms provided by Jacques Savoy of the University of Neuchâtel.
The languages currently implemented are L<Bulgarian|Lingua::Stem::UniNE::BG>,
L<Czech|Lingua::Stem::UniNE::CS>, and L<Persian|Lingua::Stem::UniNE::FA>.  Work
is ongoing for Arabic, Bengali, Finnish, French, German, Hindi, Hungarian,
Italian, Portuguese, Marathi, Russian, Spanish, and Swedish.  The top priority
is languages for which there are no stemmers available on CPAN.

=head2 Attributes

=over

=item language

The following language codes are currently supported.

    ┌───────────┬────┐
    │ Bulgarian │ bg │
    │ Czech     │ cs │
    │ Persian   │ fa │
    └───────────┴────┘

They are in the two-letter ISO 639-1 format and are case-insensitive but are
always returned in lowercase when requested.

    $stemmer = Lingua::Stem::UniNE->new(language => $language);

    # get current language
    $language = $stemmer->language;

    # change language
    $stemmer->language($language);

Country codes such as C<cz> for the Czech Republic are not supported, nor are
IETF language tags such as C<pt-PT> or C<pt-BR>.

=back

=head2 Methods

=over

=item stem

When a list of strings is provided, each string is stemmed and a list of stems
is returned.  The list returned will always have the same number of elements as
the list provided.

    @stems = $stemmer->stem(@words);

    # get the stem for a single word
    $stem = $stemmer->stem($word);

When an array reference is provided, each element is stemmed and replaced with
the resulting stem.

    $stemmer->stem(\@words);

The words should be provided as character strings and the stems are returned as
character strings.  Byte strings in arbitrary character encodings are not
supported.

=item languages

Returns a list of supported two-letter language codes using lowercase letters.

    @languages = $stemmer->languages;

=back

=head1 SEE ALSO

L<IR Multilingual Resources at UniNE|http://members.unine.ch/jacques.savoy/clef/>
provides the original stemming algorithms that were implemented in this module.

L<Lingua::Stem::Snowball> provides alternate stemming algorithms for Finnish,
French, German, Hungarian, Italian, Portuguese, Russian, Spanish, and Swedish,
as well as other languages.

L<Lingua::Stem::Any> provides a consistent unified interface for
Lingua::Stem::UniNE, Lingua::Stem::Snowball, and other stemming modules on CPAN.

=head1 ACKNOWLEDGEMENTS

L<Jacques Savoy|http://members.unine.ch/jacques.savoy/> and Ljiljana Dolamic of
the University of Neuchâtel authored the original stemming algorithms that were
implemented in this module.

This module is brought to you by L<Shutterstock|http://www.shutterstock.com/>
(L<@ShutterTech|https://twitter.com/ShutterTech>).  Additional open source
projects from Shutterstock can be found at
L<code.shutterstock.com|http://code.shutterstock.com/>.

=head1 AUTHOR

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

© 2012 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the terms of the BSD License.
