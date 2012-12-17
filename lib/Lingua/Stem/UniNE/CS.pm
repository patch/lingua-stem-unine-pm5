package Lingua::Stem::UniNE::CS;

use 5.008;
use strict;
use warnings;
use utf8;

our $VERSION = '0.00_1';

1;

__END__

=encoding UTF-8

=head1 NAME

Lingua::Stem::UniNE::CS - Czech stemmer

=head1 VERSION

This document describes Lingua::Stem::UniNE::CS version 0.00_1.

=head1 SYNOPSIS

    use Lingua::Stem::UniNE::BG qw( stem_cs );

    my $stem = stem_cs($word);

=head1 DESCRIPTION

This is a light stemmer for the Czech language.  It removes case endings from
nouns and adjectives, possesive adjective endings from names, and takes care of
palatalization.

=head1 SEE ALSO

=over

=item * L<Lingua::Stem::UniNE> — The collection of University of Neuchâtel
stemmers that includes this module.

=item * L<Czech stemmer in Java|http://members.unine.ch/jacques.savoy/clef/CzechStemmerLight.txt>
— The original implementation from which this module was ported.

=back

=head1 AUTHORS

Ljiljana Dolamic <Ljiljana.Dolamic@unine.ch>, University of Neuchâtel

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

© 2005 Jacques Savoy

© 2012 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the terms of the BSD License.
