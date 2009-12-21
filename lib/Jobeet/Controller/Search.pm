package Jobeet::Controller::Search;
use Ark 'Controller';

use Jobeet::Models;

sub index :Path {
    my ($self, $c) = @_;

    my $query = $c->req->param('q')
        or $c->detach('/default');

    $c->stash->{jobs} = models('Schema::Job')->search_fulltext($query);

    if ($c->req->header('X-Requested-With') =~ /XMLHttpRequest/i) {
        $c->view('MT')->template('search/ajax');
    }
}

1;

