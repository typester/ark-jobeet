package Jobeet::Schema::ResultBase;
use strict;
use warnings;
use base 'DBIx::Class';

use DateTime;

__PACKAGE__->load_components(qw/InflateColumn::DateTime Core/);

sub insert {
    my $self = shift;

    my $now = DateTime->now;
    $self->created_at( $now ) if $self->can('created_at');
    $self->updated_at( $now ) if $self->can('updated_at');

    $self->next::method(@_);
}

sub update {
    my $self = shift;

    if ($self->can('updated_at')) {
        $self->updated_at( DateTime->now );
    }

    $self->next::method(@_);
}

1;

