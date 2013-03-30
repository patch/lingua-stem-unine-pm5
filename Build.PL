use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name    => 'Lingua::Stem::UniNE',
    license        => 'bsd',
    create_license => 1,
    create_readme  => 1,
    configure_requires => {
        'Module::Build' => 0.36,
    },
    build_requires => {
        'Test::More' => 0.82,  # note()
    },
    requires => {
        'perl'               => '5.8.0',  # minimum Unicode support
        'parent'             => 0,
        'strict'             => 0,
        'utf8'               => 0,
        'warnings'           => 0,
        'Unicode::CaseFold'  => 0,
        'Unicode::Normalize' => 0,
    },
    meta_merge => {
        resources => {
            repository => 'git://github.com/patch/lingua-stem-unine-pm5.git',
            homepage   => 'https://github.com/patch/lingua-stem-unine-pm5',
            bugtracker => 'https://github.com/patch/lingua-stem-unine-pm5/issues',
        },
    },
);

$builder->create_build_script;
