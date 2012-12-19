package Lingua::Stem::UniNE::FA;

use 5.008;
use strict;
use warnings;
use utf8;
use charnames ':full';
use parent 'Exporter';

our $VERSION   = '0.00_1';
our @EXPORT_OK = qw( stem_fa );

sub stem_fa {
    my ($word) = @_;

    $word = remove_kasra($word);
    $word = remove_suffix($word);
    $word = remove_kasra($word);

    return $word;
}

sub remove_kasra {
    my ($word) = @_;

    return $word
        if length $word > 4
        && $word =~ s{ \N{ARABIC KASRA} $}{}x;

    return $word;
}

sub remove_suffix {
    my ($word) = @_;
    my $length = length $word;

    if ($length > 7) {
        return $word
            if $word =~ s{ (?:
                ترین | آباد | ترين | گيري | هايي | هایی | گیری | سازي |
                سازی | ريزي | ریزی | بندي | بندی | آباد | باره
            ) $}{}x;
    }

    if ($length > 6) {
        return $word
            if $word =~ s{ (?: هاي | های | اند | ايم | ایم | شان ) $}{}x;
    }

    if ($length > 5) {
        return normalize1($word)
            if $word =~ s{ ان $}{}x;

        return $word
            if $word =~ s{ (?:
                ها | ين | ين | ات | هء | اش | تر | را | ون | ام
            ) $}{}x;
    }

    if ($length > 3) {
        return $word
            if $word =~ s{ (?: ه | ی | ي | م | ت | ش ) $}{}x;
    }

    return $word;
}

sub normalize1 {
    my ($word) = @_;

    return normalize2($word)
        if length $word > 3
        && $word =~ s{ (?: ى | گ | م | ت | ر | ش ) $}{}x;

    return $word;
}

sub normalize2 {
    my ($word) = @_;

    return $word
        if length $word > 3
        && $word =~ s{ (?: ی | ي ) $}{}x;

    return $word;
}

1;

__END__

=encoding UTF-8

=head1 NAME

Lingua::Stem::UniNE::FA - Persian stemmer

=head1 VERSION

This document describes Lingua::Stem::UniNE::FA version 0.00_1.

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
