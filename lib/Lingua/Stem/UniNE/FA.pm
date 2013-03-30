package Lingua::Stem::UniNE::FA;

use v5.8;
use utf8;
use strict;
use warnings;
use charnames ':full';
use parent 'Exporter';
use Unicode::CaseFold qw( fc );
use Unicode::Normalize qw( NFC );

our $VERSION   = '0.00_1';
our @EXPORT_OK = qw( stem_fa );

sub stem_fa {
    my ($word) = @_;

    $word = NFC fc $word;
    $word = remove_kasra($word);
    $word = remove_suffix($word);
    $word = remove_kasra($word);

    return $word;
}

sub remove_kasra {
    my ($word) = @_;

    if (length $word > 4) {
        return $word
            if $word =~ s{ \N{ARABIC KASRA} $}{}x;
    }

    return $word;
}

sub remove_suffix {
    my ($word) = @_;
    my $length = length $word;

    if ($length > 7) {
        return $word
            if $word =~ s{ (?:
                ﻩﺍیی | ﺂﺑﺍﺩ | ﺐﻧﺩی | ﺕﺭیﻥ | ﺭیﺯی | ﺱﺍﺯی | گیﺭی | 
                گﻱﺮﻳ | ﺕﺮﻴﻧ | ﺏﺍﺮﻫ | ﺐﻧﺪﻳ | ﺱﺍﺰﻳ | ﺮﻳﺰﻳ | ﻩﺎﻴﻳ
            ) $}{}x;
    }

    if ($length > 6) {
        return $word
            if $word =~ s{ (?:
                ایم | اند | ايم | شان | های | هاي
            ) $}{}x;
    }

    if ($length > 5) {
        return normalize($word)
            if $word =~ s{ ان $}{}x;

        return $word
            if $word =~ s{ (?:
                ات | اش | ام | تر | را | هء | ها | ون | ين
            ) $}{}x;
    }

    if ($length > 3) {
        return $word
            if $word =~ s{ (?: ی | ت | ش | م | ه | ي ) $}{}x;
    }

    return $word;
}

sub normalize {
    my ($word) = @_;

    return $word
        if length $word < 4;

    if ($word =~ s{ (?: ت | ر | ش | گ | م | ى ) $}{}x) {
        return $word
            if length $word < 4;

        $word =~ s{ (?: ی | ي ) $}{}x;
    }

    return $word;
}

1;

__END__

=encoding UTF-8

=head1 NAME

Lingua::Stem::UniNE::FA - Persian stemmer

=head1 VERSION

This document describes Lingua::Stem::UniNE::FA v0.00_1.

=head1 SYNOPSIS

    use Lingua::Stem::UniNE::FA qw( stem_fa );

    my $stem = stem_fa($word);

=head1 DESCRIPTION

This is a light stemmer for the Persian (Farsi) language.

=head1 SEE ALSO

=over

=item * L<Lingua::Stem::UniNE> — The collection of University of Neuchâtel
stemmers that includes this module.

=item * L<Persian stemmer in Java|http://members.unine.ch/jacques.savoy/clef/persianStemmerArabic.txt>
by Ljiljana Dolamic — The original implementation from which this module was
ported.

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
