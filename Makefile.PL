use inc::Module::Install;
name 'Jobeet';
all_from 'lib/Jobeet.pm';

requires 'Ark';

tests 't/*.t';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
