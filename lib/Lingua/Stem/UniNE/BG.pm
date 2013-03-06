package Lingua::Stem::UniNE::BG;

use 5.008;
use strict;
use warnings;
use utf8;
use parent 'Exporter';
use Unicode::CaseFold qw( fc );
use Unicode::Normalize qw( NFC );

our $VERSION   = '0.00_1';
our @EXPORT_OK = qw( stem_bg );

sub stem_bg {
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
        $word =~ s{ ъ (?= . $) }{}x;  # -b� → -�
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
            if $word =~ s{ зи             $}{г}x    # -(e)H → -T
            || $word =~ s{ е ( . ) и      $}{я$1}x  # -e�H  → -(R)�
            || $word =~ s{ ци             $}{к}x    # -UH   → -k
            || $word =~ s{ (?: та | ища ) $}{}x;    # -Ta -HWa
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

This document describes Lingua::Stem::UniNE::BG version 0.00_1.

=head1 SYNOPSIS

    use Lingua::Stem::UniNE::BG qw( stem_bg );

    my $stem = stem_bg($word);

=head1 DESCRIPTION

This is a light stemmer for the Bulgarian language.

=head1 SEE ALSO

=over

=item * L<Lingua::Stem::UniNE> — The collection of University of Neuchâtel
stemmers that includes this module.

=item * L<Bulgarian stemmer as Perl script|http://members.unine.ch/jacques.savoy/clef/bulgarianStemmer.txt>
by Jacques Savoy — The original implementation from which this module was
ported.

=item * L<Searching Strategies for the Bulgarian Language|http://dl.acm.org/citation.cfm?id=1598600>
(PDF) by Jacques Savoy — Article defining the algorithm implemented by this
module.

=back

=head1 ACKNOWLEDGEMENTS

Jacques Savoy of the University of Neuchâtel authored the algorithm for this
stemmer and wrote the original implementation as a Perl script.

=head1 AUTHOR

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

© 2012 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the terms of the BSD License.
