package Jobeet::Controller::API;
use Ark 'Controller';

use Jobeet::Models;

sub token :Chained('/') :PathPart('api') :CaptureArgs(1) {
    my ($self, $c, $token) = @_;

    $c->detach('/default') unless length $token == 40;

    my $affiliate = models('Schema::Affiliate')->single({ token => $token })
        or $c->detach('/default');

    $c->stash->{affiliate} = $affiliate;
}

sub jobs :Chained('token') :Args(0) {
    my ($self, $c) = @_;

    my $json = [];
    my $affiliate = $c->stash->{affiliate};
    my $max_rows  = models('conf')->{max_jobs_on_homepage};

    for my $category ($affiliate->categories) {
        for my $job ($category->get_active_jobs({ rows => $max_rows })->all) {
            push @$json, {
                category     => $category->name,
                type         => $job->type,
                company      => $job->company,
                url          => $job->url,
                position     => $job->position,
                location     => $job->location,
                description  => $job->description,
                how_to_apply => $job->how_to_apply,
                expires_at   => $job->expires_at->epoch,
            };
        }
    }

    $c->stash->{json} = $json;
}

sub end :Private {
    my ($self, $c) = @_;

    if ($c->stash->{json}) {
        $c->forward( $c->view('JSON') );
    }
    else {
        $c->forward('/end');
    }
}

1;

