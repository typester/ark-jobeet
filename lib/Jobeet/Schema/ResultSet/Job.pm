package Jobeet::Schema::ResultSet::Job;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use Jobeet::Models;

sub create_from_form {
    my ($self, $form) = @_;

    my $txn_guard = $self->result_source->schema->txn_scope_guard;

    my $category_name = delete $form->params->{category};
    my $category = models('Schema::Category')->find({ slug => $category_name })
        or die 'no such category_name: ', $category_name;

    my $job = $self->create({
        category_id => $category->id,
        %{ $form->params },
    });

    $txn_guard->commit;

    $job;
}


1;

