# NAME

Lingua::Stem::UniNE - University of Neuchâtel stemmers

# VERSION

This document describes Lingua::Stem::UniNE v0.04_1.

# SYNOPSIS

```perl
use Lingua::Stem::UniNE;

# create Bulgarian stemmer
$stemmer = Lingua::Stem::UniNE->new(language => 'bg');

# get stem for word
$stem = $stemmer->stem($word);

# get list of stems for list of words
@stems = $stemmer->stem(@words);
```

# DESCRIPTION

This module contains a collection of stemmers for multiple languages based on
stemming algorithms provided by Jacques Savoy of the University of Neuchâtel
(UniNE). The languages currently implemented are
[Bulgarian](https://metacpan.org/pod/Lingua::Stem::UniNE::BG), [Czech](https://metacpan.org/pod/Lingua::Stem::UniNE::CS), and
[Persian](https://metacpan.org/pod/Lingua::Stem::UniNE::FA). Work is ongoing for Arabic, Bengali,
Finnish, French, German, Hindi, Hungarian, Italian, Portuguese, Marathi,
Russian, Spanish, and Swedish. The top priority is languages for which there are
no stemmers available on CPAN.

## Attributes

- language

    The following language codes are currently supported.

        ┌───────────┬────┐
        │ Bulgarian │ bg │
        │ Czech     │ cs │
        │ German    │ de │
        │ Persian   │ fa │
        └───────────┴────┘

    They are in the two-letter ISO 639-1 format and are case-insensitive but are
    always returned in lowercase when requested.

    ```perl
    # instantiate a stemmer object
    $stemmer = Lingua::Stem::UniNE->new(language => $language);

    # get current language
    $language = $stemmer->language;

    # change language
    $stemmer->language($language);
    ```

    Country codes such as `cz` for the Czech Republic are not supported, nor are
    IETF language tags such as `fa-AF` or `fa-IR`.

- aggressive

    By default, if there are multiple strenghs of stemmers, the light stemmers will
    be used. When `aggressive` is set to true, aggressive stemmers will be used if
    available.

    ```perl
    $stemmer->aggressive(1);
    ```

## Methods

- stem

    Accepts a list of words, stems each word, and returns a list of stems. The list
    returned will always have the same number of elements in the same order as the
    list provided. When no stemming rules apply to a word, the original word is
    returned.

    ```perl
    @stems = $stemmer->stem(@words);

    # get the stem for a single word
    $stem = $stemmer->stem($word);
    ```

    The words should be provided as character strings and the stems are returned as
    character strings. Byte strings in arbitrary character encodings are
    intentionally not supported.

- languages

    Returns a list of supported two-letter language codes using lowercase letters.

    ```perl
    # object method
    @languages = $stemmer->languages;

    # class method
    @languages = Lingua::Stem::UniNE->languages;
    ```

# SEE ALSO

[IR Multilingual Resources at UniNE](http://members.unine.ch/jacques.savoy/clef/)
provides the original stemming algorithms that were implemented in this module.

[Lingua::Stem::Any](https://metacpan.org/pod/Lingua::Stem::Any) provides a unified interface to any stemmer on CPAN,
including this module, as well as additional features like normalization,
casefolding, and in-place stemming.

[Lingua::Stem::Snowball](https://metacpan.org/pod/Lingua::Stem::Snowball) provides alternate stemming algorithms for Finnish,
French, German, Hungarian, Italian, Portuguese, Russian, Spanish, and Swedish,
as well as other languages.

# ACKNOWLEDGEMENTS

[Jacques Savoy](http://members.unine.ch/jacques.savoy/) and Ljiljana Dolamic of
the University of Neuchâtel authored the original stemming algorithms that were
implemented in this module.

This project is brought to you by [Shutterstock](http://www.shutterstock.com/).
Additional open source projects from Shutterstock can be found at
[code.shutterstock.com](http://code.shutterstock.com/).

# AUTHOR

Nick Patch <patch@cpan.org>

# COPYRIGHT AND LICENSE

© 2012–2014 Shutterstock, Inc.

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.
