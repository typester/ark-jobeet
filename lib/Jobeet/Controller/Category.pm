package Jobeet::Controller::Category;
use Ark 'Controller';

use Jobeet::Models;

sub show :Path :Args(1) {
    my ($self, $c, $category_name) = @_;

    my $category = models('Schema::Category')->find({ slug => $category_name })
        or $c->detach('/default');

    $c->stash->{category} = $category;
    $c->stash->{jobs} = $category->get_active_jobs({
        rows => models('conf')->{max_jobs_on_category},
        page => $c->req->param('page') || 1,
    });
}

1;

