package Lingua::Stem::UniNE::CS;

use v5.8;
use utf8;
use strict;
use warnings;
use parent 'Exporter';
use Unicode::CaseFold qw( fc );
use Unicode::Normalize qw( NFC );

our $VERSION   = '0.03';
our @EXPORT_OK = qw( stem stem_cs );

*stem_cs = \&stem;

sub stem {
    my ($word) = @_;

    $word = NFC fc $word;
    $word = remove_case($word);
    $word = remove_possessives($word);

    return $word;
}

# remove case endings from nouns and adjectives
sub remove_case {
    my ($word) = @_;
    my $length = length $word;

    if ($length > 7) {
        return $word
            if $word =~ s{ atech $}{}x;  # -atech
    }

    if ($length > 6) {
        return $word
            if $word =~ s{ atům $}{}x;  # -atům

        return palatalize($word)
            if $word =~ s{ (?<= ě ) tem $}{}x;  # -ětem → -ě
    }

    if ($length > 5) {
        return $word
            if $word =~ s{ (?:
                  ými     # -ými
                | am[ai]  # -ama -ami
                | at[ay]  # -ata -aty
                | ov[éi]  # -ové -ovi
                | [áý]ch  # -ách -ých
            ) $}{}x;

        return palatalize($word)
            if $word =~ s{ (?:
                  (?<= ě     ) t[ei]  # -ěte -ěti      → -ě
                | (?<= [éi]  ) mu     # -ému -imu      → -é -i
                | (?<= [eií] ) ch     # -ech -ich -ích → -e -i -í
                | (?<= [eěí] ) mi     # -emi -ěmi -ími → -e -ě -í
                | (?<= [éií] ) ho     # -ého -iho -ího → -é -i -í
            ) $}{}x;
    }

    if ($length > 4) {
        return $word
            if $word =~ s{ (?:
                  at      # -at
                | mi      # -mi
                | us      # -us
                | o[su]   # -os -ou
                | [áůý]m  # -ám -ům -ým
            ) $}{}x;

        return palatalize($word)
            if $word =~ s{ (?:
                  es          # -es
                | [éí]m       # -ém -ím
                | (?<= e ) m  # -em → -e
            ) $}{}x;
    }

    if ($length > 3) {
        return $word
            if $word =~ s{ [aáéouůyý] $}{}x;  # -a -á -é -o -u -ů -y -ý

        return palatalize($word)
            if $word =~ m{ [eěií] $}x;  # -e -ě -i -í
    }

    return $word;
}

# remove possesive endings from names -ov- and -in-
sub remove_possessives {
    my ($word) = @_;

    return $word
        if length $word < 6;

    return $word
        if $word =~ s{ [oů]v $}{}x;  # -ov -ův

    return palatalize($word)
        if $word =~ s{ (?<= i ) n $}{}x;  # -in → -i

    return $word;
}

sub palatalize {
    my ($word) = @_;

    return $word
        if $word =~ s{ čt[ěií]  $}{ck}x  # -čtě -čti -čtí  → -ck
        || $word =~ s{ št[ěií]  $}{sk}x  # -ště -šti -ští  → -sk
        || $word =~ s{ [cč][ei] $}{k}x   # -ce -ci -če -či → -k
        || $word =~ s{ [zž][ei] $}{h}x;  # -ze -zi -že -ži → -h

    chop $word;

    return $word;
}

1;

__END__

=encoding UTF-8

=head1 NAME

Lingua::Stem::UniNE::CS - Czech stemmer

=head1 VERSION

This document describes Lingua::Stem::UniNE::CS v0.03.

=head1 SYNOPSIS

    use Lingua::Stem::UniNE::CS qw( stem_cs );

    $stem = stem_cs($word);

    # alternate syntax
    $stem = Lingua::Stem::UniNE::CS::stem($word);

=head1 DESCRIPTION

A light stemmer for the Czech language that removes case endings from nouns and
adjectives, possessive adjective endings from names, and takes care of
palatalization.

This module provides the C<stem> and C<stem_cs> functions, which are synonymous
and can optionally be exported.  They accept a single word and return a single
stem.

=head1 SEE ALSO

L<Lingua::Stem::UniNE> provides a stemming object with access to all of the
implemented University of Neuchâtel stemmers including this one.  It has
additional features like stemming lists or array references of words.

This stemming algorithm was defined in
L<Indexing and stemming approaches for the Czech language|http://dl.acm.org/citation.cfm?id=1598600>
(PDF) by Ljiljana Dolamic and Jacques Savoy and originally implemented by
Ljiljana Dolamic in L<Java|http://members.unine.ch/jacques.savoy/clef/CzechStemmerLight.txt>.

A L<Czech stemmer for Snowball|http://snowball.tartarus.org/otherapps/oregan/intro.html>
by Jimmy O’Regan is available on the Snowball site but not included in the
official distribution and therefore not included in L<Lingua::Stem::Snowball>.

=head1 ACKNOWLEDGEMENTS

Ljiljana Dolamic and Jacques Savoy of the University of Neuchâtel authored the
original stemming algorithm that was implemented in this module.

=head1 AUTHOR

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

© 2012–2013 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.
