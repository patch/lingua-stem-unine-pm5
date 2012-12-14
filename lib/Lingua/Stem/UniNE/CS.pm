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

    ...

=head1 DESCRIPTION

Removes case endings from nouns and adjectives, possesive adjective endings from
names, and takes care of palatalization.

=head1 SEE ALSO

L<http://members.unine.ch/jacques.savoy/clef/CzechStemmerLight.txt>

=head1 AUTHORS

Dolamic Ljiljana, University of Neuchâtel

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

© 2005 Jacques Savoy

© 2012 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the terms of the BSD License.
