package Jobeet::Controller::Job;
use Ark 'Controller';

use Jobeet::Models;

sub index :Path {
    my ($self, $c) = @_;

    $c->stash->{jobs} = models('Schema::Job');
}

sub show :Path :Args(1) {
    my ($self, $c, $job_id) = @_;
}

sub create :Local {
    my ($self, $c) = @_;
}

sub job :Chained('/') :PathPart :CaptureArgs(1) {
    my ($self, $c, $job_id) = @_;
    $c->stash->{job_id} = $job_id;
}

sub edit :Chained('job') :PathPart {
    my ($self, $c) = @_;
}

# /job/{job_id}/delete （削除）
sub delete :Chained('job') :PathPart {
    my ($self, $c) = @_;
}

1;


