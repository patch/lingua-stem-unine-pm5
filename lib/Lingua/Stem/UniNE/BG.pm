package Lingua::Stem::UniNE::BG;

use 5.008;
use strict;
use warnings;
use utf8;
use parent 'Exporter';

our $VERSION   = '0.00_1';
our @EXPORT_OK = qw( stem_bg );

sub stem_bg {
    my ($word) = @_;
    my $length = length $word;

    return $word
        if $length < 4;

    return $word
        if $length > 5
        && $word =~ s/ища$//;

    $word = remove_article($word);
    $word = remove_plural($word);
    $length = length $word;

    if ($length > 3) {
        $word =~ s/я$//;  # final -(R) (masc)

        # normalization (e.g., -a could be a definite article or plural form)
        $word =~ s/[аое]$//;  # final -[aoe]

        $length = length $word;
    }

    if ($length > 4) {
        $word =~ s/ен$/н/;  # final -eH → H

        $length = length $word;
    }

    if ($length > 5) {
        # rewritting rule -...b. into -....
        $word =~ s/ъ(?=.$)//;
    };

    return $word;
}

sub remove_article {
    my ($word) = @_;
    my $length = length $word;

    if ($length > 6) {
        # definite article with adjectives and masc
        return $word
            if $word =~ s/ият$//;  # final -H(R)T
    }

    if ($length > 5) {
        return $word
            if $word =~ s/ия$//   # final -H(R)
            # definite article (the) for nouns
            || $word =~ s/та$//   # final -Ta (art for femi)
            || $word =~ s/ът$//   # final -bT (art for masc)
            || $word =~ s/то$//   # final -To (art for neutral)
            || $word =~ s/те$//;  # final -Te (art in plural)
    }

    if ($length > 4) {
        return $word
            if $word =~ s/ят$//;  # final -(R)T (art for masc)
    }

    return $word;
}

sub remove_plural {
    my ($word) = @_;
    my $length = length $word;

    # specific plural rules for some words (masc)
    if ($length > 6) {
        return $word
            if $word =~ s/ове$//     # final -OBe
            || $word =~ s/еве$/й/    # final -eBe  → N
            || $word =~ s/овци$/о/;  # final -oBUH → O
    }

    if ($length > 5) {
        return $word
            if $word =~ s/ища$//       # final -HWa
            || $word =~ s/зи$/г/       # final -(e)H → T
            || $word =~ s/е(.)и$/я$1/
            || $word =~ s/та$//        # final -Ta
            || $word =~ s/ци$/к/;      # final -UH → k
    }

    if ($length > 4) {
        return $word
            if $word =~ s/си$/х/  # final -cH → x
            || $word =~ s/и$//;   # final -H plural for various
                                  # nouns and adjectives
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

=head1 AUTHORS

Jacques Savoy <Jacques.Savoy@unine.ch>, University of Neuchâtel

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

© 2005 Jacques Savoy

© 2012 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the terms of the BSD License.
