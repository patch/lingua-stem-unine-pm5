package Lingua::Stem::UniNE::FA;

use v5.8;
use utf8;
use strict;
use warnings;
use charnames ':full';
use parent 'Exporter';
use Unicode::CaseFold qw( fc );
use Unicode::Normalize qw( NFC );

our $VERSION   = '0.01';
our @EXPORT_OK = qw( stem stem_fa );

*stem_fa = \&stem;

sub stem {
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
                آباد | باره | بندی | بندي | ترین | ترين | ریزی |
                ريزي | سازی | سازي | گیری | گيري | هایی | هايي
            ) $}{}x;
    }

    if ($length > 6) {
        return $word
            if $word =~ s{ (?:
                اند | ایم | ايم | شان | های | هاي
            ) $}{}x;
    }

    if ($length > 5) {
        return normalize($word)
            if $word =~ s{ ان $}{}x;

        return $word
            if $word =~ s{ (?:
                ات | اش | ام | تر | را | ون | ها | هء | ین | ين
            ) $}{}x;
    }

    if ($length > 3) {
        return $word
            if $word =~ s{ (?: ت | ش | م | ه | ی | ي ) $}{}x;
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

This document describes Lingua::Stem::UniNE::FA v0.01.

=head1 SYNOPSIS

    use Lingua::Stem::UniNE::FA qw( stem_fa );

    my $stem = stem_fa($word);

    # alternate syntax
    $stem = Lingua::Stem::UniNE::FA::stem($word);

=head1 DESCRIPTION

A stemmer for the Persian (Farsi) language.

=head1 SEE ALSO

L<Lingua::Stem::UniNE> provides a stemming object with access to all of the
implemented University of Neuchâtel stemmers including this one.

This stemming algorithm was originally implemented by Ljiljana Dolamic in
L<Java|http://members.unine.ch/jacques.savoy/clef/persianStemmerUnicode.txt>.

=head1 ACKNOWLEDGEMENTS

Ljiljana Dolamic and Jacques Savoy of the University of Neuchâtel authored the
original stemming algorithm that was implemented in this module.

=head1 AUTHOR

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

© 2012–2013 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.
