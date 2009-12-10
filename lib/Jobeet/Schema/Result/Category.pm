package Jobeet::Schema::Result::Category;
use strict;
use warnings;
use base 'Jobeet::Schema::ResultBase';

use String::CamelCase qw(decamelize);

__PACKAGE__->table('jobeet_category');

__PACKAGE__->add_columns(
    id => {
        data_type         => 'INTEGER',
        is_nullable       => 0,
        is_auto_increment => 1,
        extra => {
            unsigned => 1,
        },
    },
    name => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
    },
    slug => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(['name']);
__PACKAGE__->add_unique_constraint(['slug']);

__PACKAGE__->has_many( jobs => 'Jobeet::Schema::Result::Job', 'category_id' );

__PACKAGE__->has_many(
    category_affiliate => 'Jobeet::Schema::Result::CategoryAffiliate', 'category_id');

__PACKAGE__->many_to_many( affiliates => category_affiliate => 'affiliate' );

sub get_active_jobs {
    my $self = shift;
    my $attr = shift || {};

    $self->jobs(
        { expires_at => { '>=', DateTime->now } },
        {   order_by => { -desc => 'created_at' },
            defined $attr->{rows} ? (rows => $attr->{rows}) : (),
            defined $attr->{page} ? (page => $attr->{page}) : (),
        }
    );
}

sub insert {
    my $self = shift;

    $self->slug( decamelize $self->name );

    $self->next::method(@_);
}

sub update {
    my $self = shift;

    if ($self->is_column_changed('name')) {
        $self->slug( decamelize $self->name );
    }

    $self->next::method(@_);
}

1;

