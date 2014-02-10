package Lingua::Stem::UniNE::DE;

use v5.8.1;
use utf8;
use strict;
use warnings;
use parent 'Exporter';
use Unicode::CaseFold qw( fc );
use Unicode::Normalize qw( NFC );

our $VERSION   = '0.04_1';
our @EXPORT_OK = qw( stem stem_de );

*stem_de = \&stem;

sub stem {
    my ($word) = @_;

    $word = NFC fc $word;
    $word = remove_plural($word);

    return $word;
}

sub remove_plural {
    my ($word) = @_;
    my $length = length $word;

    return $word
        if $length < 4;

    $word = remove_diacritic($word);

    return $word
        if $length > 5
        && $word =~ s{ nen $}{}x;  # -nen

    return $word
        if $length > 4
        && $word =~ s{ (?: e[nrs] | se ) $}{}x;  # -en -er -es -se

    return $word
        if $word =~ s{ [enrs] $}{}x;  # -e -n -r -s

    return $word;
}

sub remove_diacritic {
    my ($word) = @_;

    $word =~ tr{äöü}{aou};

    return $word;
}

1;

__END__

=encoding UTF-8

=head1 NAME

Lingua::Stem::UniNE::DE - German stemmer

=head1 VERSION

This document describes Lingua::Stem::UniNE::DE v0.04_1.

=head1 SYNOPSIS

    use Lingua::Stem::UniNE::DE qw( stem_de );

    my $stem = stem_de($word);

    # alternate syntax
    $stem = Lingua::Stem::UniNE::DE::stem($word);

=head1 DESCRIPTION

A stemmer for the German language, which removes plural endings and umlauts. 

This module provides the C<stem> and C<stem_de> functions, which are synonymous
and can optionally be exported. They accept a single word and return a single
stem.

=head1 SEE ALSO

L<Lingua::Stem::UniNE> provides a stemming object with access to all of the
implemented University of Neuchâtel stemmers including this one. It has
additional features like stemming lists of words.

L<Lingua::Stem::Any> provides a unified interface to any stemmer on CPAN,
including this one, as well as additional features like normalization,
casefolding, and in-place stemming.

This stemming algorithm was originally implemented by Jacques Savoy in
L<C|http://members.unine.ch/jacques.savoy/clef/germanStemmer.txt>.

=head1 ACKNOWLEDGEMENTS

Jacques Savoy of the University of Neuchâtel authored the original stemming
algorithm that was implemented in this module.

=head1 AUTHOR

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

© 2014 Shutterstock, Inc.

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.
