use strict;
use warnings;
use Test::More;

use Jobeet::Test;
use Jobeet::Models;

my $cache = models('cache');

ok $cache, 'cache model return ok';
isa_ok $cache, 'Cache::FastMmap';

my $test_key = '____test_key____';

ok !$cache->get($test_key), 'cache is not set yet';

$cache->set($test_key => 'Hello');

is $cache->get($test_key), 'Hello', 'cache set ok';

$cache->remove($test_key);

ok !$cache->get($test_key), 'cache remove ok';

done_testing;

