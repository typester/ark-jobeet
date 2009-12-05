package Jobeet::Controller::Job;
use Ark 'Controller';

use Jobeet::Models;

sub index :Path {
    my ($self, $c) = @_;

    $c->stash->{jobs} = models('Schema::Job');
}

1;

