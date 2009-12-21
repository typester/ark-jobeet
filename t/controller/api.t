use strict;
use warnings;

use Test::More;
use Jobeet::Test;
use Jobeet::Models;
use JSON;

my $datafile = models('home')->subdir(qw/sql fixtures/)->file('default.pl');
do $datafile or die $!;

{
    my $res = request( GET => '/api/foo/jobs' );
    is $res->code, 404, '404 ok';
}

{
    my $data = models('Schema::Affiliate')->single({});

    my $res = request( GET => '/api/' . $data->token . '/jobs' );
    is $res->code, 200, '200 ok';
    like $res->content_type, qr!application/json!, 'content_type ok';

    my $json = from_json($res->content);
    is $json->[0]{category}, $data->categories->first->name, 'category ok';
}

done_testing;
