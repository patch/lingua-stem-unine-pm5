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

    my $stemmer = Lingua::Stem::UniNE->new('bg');

    my @stems = $stemmer->stem(@words);

=head1 DESCRIPTION

This is a collection of stemmers for multiple languages based on algorithms by
Jacques Savoy et al. of the University of Neuchâtel.  The languages currently
implemented are L<Bulgarian|Lingua::Stem::UniNE::BG>,
L<Czech|Lingua::Stem::UniNE::CS>, and L<Persian|Lingua::Stem::UniNE::FA>.  Work
is ongoing for Arabic, Bengali, Finnish, French, German, Hindi, Hungarian,
Italian, Portuguese, Marathi, Russian, Spanish, and Swedish.  The top priority
is languages for which there are no stemmers available on CPAN.

=over

=item B<Comments on stemmers from UniNE>

In proposing stemmers for other languages than English, we think that a “light”
stemmer (removing inflections only for noun and adjectives) presents some
advantages.  Our stemming procedure for French is described in (Savoy, 1999).
In Italian, the main inflectional rule is to modify the final character (e.g.,
«-o», «-a» or «-e») into another (e.g., «-i», «-e»).  As a second rule, Italian
morphology may also alter the final two letters (e.g., «-io» in «-o», «-co» in
«-chi», «-ga» in «-ghe»).  In German, a few rules may be applied to obtain the
plural form of words (e.g., “Frau” into “Frauen” (woman), “Bild” into “Bilder”
(picture), “Sohn” into “Söhne” (son), “Apfel” into “Äpfel” (apple)), but the
suggested algorithms do not account for person and tense variations, or for the
morphological variations used by verbs (we think that indexing verbs for
Italian, French or German is not of primary importance compared to nouns and
adjectives).

=back

=head1 SEE ALSO

=over

=item * L<IR Multilingual Resources at UniNE|http://members.unine.ch/jacques.savoy/clef/>

=item * L<Lingua::Stem::Snowball>

=item * L<Lingua::Stem>

=back

=head1 ACKNOWLEDGEMENTS

The stemmers included are based on the algorithms and original implementations
by Jacques Savoy and Ljiljana Dolamic of the University of Neuchâtel.

=head1 AUTHOR

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

© 2012 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the terms of the BSD License.
