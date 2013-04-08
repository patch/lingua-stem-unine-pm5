package Lingua::Stem::UniNE::BG;

use v5.8;
use utf8;
use strict;
use warnings;
use parent 'Exporter';
use Unicode::CaseFold qw( fc );
use Unicode::Normalize qw( NFC );

our $VERSION   = '0.02';
our @EXPORT_OK = qw( stem stem_bg );

*stem_bg = \&stem;

sub stem {
    my ($word) = @_;

    $word = NFC fc $word;

    my $length = length $word;

    return $word
        if $length < 4;

    if ($length > 5) {
        return $word
            if $word =~ s{ ища $}{}x;  # -HWa
    }

    $word = remove_article($word);
    $word = remove_plural($word);
    $length = length $word;

    if ($length > 3) {
        $word =~ s{ я $}{}x;  # -(R) (masc)

        # normalization (e.g., -a could be a definite article or plural form)
        $word =~ s{ [аео] $}{}x;  # -a -e -o

        $length = length $word;
    }

    if ($length > 4) {
        $word =~ s{ е (?= н $) }{}x;  # -eH → -H

        $length = length $word;
    }

    if ($length > 5) {
        $word =~ s{ ъ (?= \p{Cyrl} $) }{}x;  # -b� → -�
    };

    return $word;
}

sub remove_article {
    my ($word) = @_;
    my $length = length $word;

    if ($length > 6) {
        # definite article with adjectives and masc
        return $word
            if $word =~ s{ ият $}{}x;  # -H(R)T
    }

    if ($length > 5) {
        return $word
            if $word =~ s{ (?:
                  ия  # -H(R)
                      # definite article for nouns:
                | ът  # -bT (art for masc)
                | та  # -Ta (art for femi)
                | то  # -To (art for neutral)
                | те  # -Te (art in plural)
            ) $}{}x;
    }

    if ($length > 4) {
        return $word
            if $word =~ s{ ят $}{}x;  # -(R)T (art for masc)
    }

    return $word;
}

sub remove_plural {
    my ($word) = @_;
    my $length = length $word;

    # specific plural rules for some words (masc)
    if ($length > 6) {
        return $word
            if $word =~ s{ ове  $}{}x    # -OBe
            || $word =~ s{ еве  $}{й}x   # -eBe  → N
            || $word =~ s{ овци $}{о}x;  # -oBUH → O
    }

    if ($length > 5) {
        return $word
            if $word =~ s{ зи               $}{г}x    # -(e)H → -T
            || $word =~ s{ е ( \p{Cyrl} ) и $}{я$1}x  # -e�H  → -(R)�
            || $word =~ s{ ци               $}{к}x    # -UH   → -k
            || $word =~ s{ (?: та | ища )   $}{}x;    # -Ta -HWa
    }

    if ($length > 4) {
        return $word
            if $word =~ s{ си $}{х}x  # -cH → -x
            || $word =~ s{ и  $}{}x;  # -H (plural for various nouns/adjectives)
    }

    return $word;
}

1;

__END__

=encoding UTF-8

=head1 NAME

Lingua::Stem::UniNE::BG - Bulgarian stemmer

=head1 VERSION

This document describes Lingua::Stem::UniNE::BG v0.02.

=head1 SYNOPSIS

    use Lingua::Stem::UniNE::BG qw( stem_bg );

    my $stem = stem_bg($word);

    # alternate syntax
    $stem = Lingua::Stem::UniNE::BG::stem($word);

=head1 DESCRIPTION

A stemmer for the Bulgarian language.

This module provides the C<stem> and C<stem_bg> functions, which are synonymous
and can optionally be exported.  They accept a single word and return a single
stem.

=head1 SEE ALSO

L<Lingua::Stem::UniNE> provides a stemming object with access to all of the
implemented University of Neuchâtel stemmers including this one.  It has
additional features like stemming lists or array references of words.

This stemming algorithm was defined in
L<Searching Strategies for the Bulgarian Language|http://dl.acm.org/citation.cfm?id=1298736>
(PDF) by Jacques Savoy and originally implemented by him as a
L<Perl script|http://members.unine.ch/jacques.savoy/clef/bulgarianStemmer.txt>.

=head1 ACKNOWLEDGEMENTS

Jacques Savoy of the University of Neuchâtel authored the original stemming
algorithm that was implemented in this module.

=head1 AUTHOR

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

© 2012–2013 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.
