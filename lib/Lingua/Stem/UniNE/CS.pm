package Lingua::Stem::UniNE::CS;

use 5.008;
use strict;
use warnings;
use utf8;
use parent 'Exporter';
use Unicode::CaseFold qw( fc );
use Unicode::Normalize qw( NFC );

our $VERSION   = '0.00_1';
our @EXPORT_OK = qw( stem_cs );

sub stem_cs {
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
by Ljiljana Dolamic — The original implementation from which this module was
ported.

=item * L<Czech stemmer in Snowball|http://snowball.tartarus.org/otherapps/oregan/intro.html>
by Jimmy O’Regan — An implementation hosted on the Snowball site but not
included in the official distribution and therefore not included in
L<Lingua::Stem::Snowball>.

=item * L<Indexing and stemming approaches for the Czech language|http://dl.acm.org/citation.cfm?id=1598600>
by Ljiljana Dolamic and Jacques Savoy — Article defining the algorithm
implemented by this module.

=back

=head1 ACKNOWLEDGEMENTS

Ljiljana Dolamic of the University of Neuchâtel wrote the original
implementation of this stemmer in Java and authored the algorithm along with
Jacques Savoy, also of UniNE.

=head1 AUTHOR

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

© 2012 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the terms of the BSD License.
