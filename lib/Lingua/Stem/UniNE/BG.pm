package Lingua::Stem::UniNE::BG;

use 5.008;
use strict;
use warnings;
#use utf8;
use parent 'Exporter';

our $VERSION   = '0.00_1';
our @EXPORT_OK = qw( stem_bg );

sub stem_bg {
  my($line, $i);
  $line = $_[0];

  $i = length($line);
  if ($i > 10) { 
     if ($line =~ m/ища$/) {  
         $line = substr($line,0,$i-6);
         return($line);
         }
     }
  if ($i < 8) {  # consider only words having 5 characters or more
   return($line);
   }
  $line = remove_article($line);
  $line = remove_plural($line);

  $i = length($line);
  if ($i > 6) { 
     if ($line =~ m/я$/) {   #  final -(R) (masc)
         $line = substr($line,0,$i-2);
         }
# normalization (e.g., -a could be a definite article or plural form)
     if ($line =~ m/[аое]$/) {   #  final -[aoe]
         $line = substr($line,0,$i-2);
         }
      }
# rewritting rule -eH into -H
  $i = length($line);
  if ($i > 8) {
     if ($line =~ m/ен$/) {   #  final -eH -> H
         $line =~ s/ен$/н/; 
         $i -= 2; 
         }
      }
# rewritting rule -...b. into -....
  if (($i > 10) && (substr($line,$i-4,2) eq "ъ")) {
    substr($line,$i-4,4) = substr($line,$i-2,2);
    };
  return($line);
} 


sub remove_article {
  my($word, $i);   # use a local var $word and $i
  $word = $_[0];
  $i = length($word);

# definite article with adjectives and masc
  if (($i > 12) && ($word =~ m/ият$/)) {   #  final -H(R)T
      return(substr($word,0,$i-6));
      }
  if ($i > 10) {
      if ($word =~ m/ия$/) {  # final -H(R)
         return(substr($word,0,$i-4));  
         }
# definite article (the) for nouns 
     if ($word =~ m/та$/) {  # final -Ta (art for femi)
         return(substr($word,0,$i-4));
         }
     if ($word =~ m/ът$/) {  # final -bT (art for masc)
         return(substr($word,0,$i-4));
         }
     if ($word =~ m/то$/) {  # final -To (art for neutral)
        return(substr($word,0,$i-4));
        }
     if ($word =~ m/те$/) {  # final -Te (art in plural)
         return(substr($word,0,$i-4));
         }
      }
  if (($i > 8) && ($word =~ m/ят$/)) {  # final -(R)T (art for masc)
     return(substr($word,0,$i-4));
   }
  return($word);
} 

sub remove_plural {
  my($word, $i);    # use local var $word and $i
  $word = $_[0];
  $i = length($word);

# specific plural rules for some words (masc)
  if ($i > 12)  { # for words having more than 6 characters  
     if ($word =~ m/ове$/) {  # final -OBe 
         return(substr($word,0,$i-6));
         }
     if ($word =~ m/еве$/) {  # final -eBe --> N
         $word =~ s/еве$/й/;
         return($word);
         }   
     if ($word =~ m/овци$/) {  #  final -oBUH --> O
         $word =~ s/овци$/о/;
         return($word);
         }
      }

  if ($i > 10) {  # for words having more than 5 characters
     if ($word =~ m/ища$/) {  # final -HWa
         return(substr($word,0,$i-6));
         }
     if ($word =~ m/зи$/) {  #  final -(e)H --> T
         $word =~ s/зи$/г/;
         return($word);
         }
     if ($word =~ m/е..и$/) { # rewritting rule
        substr($word,$i-6,2) = "я";
        substr($word,$i-2,2) = "";
        return($word);
        }
     if ($word =~ m/та$/) { # final -Ta
        return(substr($word,0,$i-4));
        }
     if ($word =~ m/ци$/) {  #  final -UH --> k
         $word =~ s/ци$/к/;
         return($word);
         }
      }
  if ($i > 8) {  # for words having more than 4 characters
     if ($word =~ m/си$/) {  #  final -cH --> x
         $word =~ s/си$/х/;
         return($word);
         }
     $word =~ s/и$//;  #  final -H plural for various nouns and adjectives
     }
  return($word);
} 

1;

__END__

=encoding UTF-8

=head1 NAME

Lingua::Stem::UniNE::BG - Bulgarian stemmer

=head1 VERSION

This document describes Lingua::Stem::UniNE::BG version 0.00_1.

=head1 SYNOPSIS

    ...

=head1 DESCRIPTION

...

=head1 SEE ALSO

L<http://members.unine.ch/jacques.savoy/clef/bulgarianStemmer.txt>

=head1 AUTHORS

Jacques Savoy, University of Neuchâtel

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

© 2005 Jacques Savoy

© 2012 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the terms of the BSD License.
