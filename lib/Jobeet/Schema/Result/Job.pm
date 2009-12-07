package Jobeet::Schema::Result::Job;
use strict;
use warnings;
use base 'Jobeet::Schema::ResultBase';

use DateTime;
use Jobeet::Models;

__PACKAGE__->table('jobeet_job');

__PACKAGE__->add_columns(
    id => {
        data_type         => 'INTEGER',
        is_nullable       => 0,
        is_auto_increment => 1,
        extra => {
            unsigned => 1,
        },
    },
    category_id => {
        data_type   => 'INTEGER',
        is_nullable => 0,
        extra => {
            unsigned => 1,
        },
    },
    type => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 1,
    },
    company => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 1,
    },
    logo => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 1,
    },
    url => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 1,
    },
    position => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
    },
    location => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
    },
    description => {
        data_type   => 'TEXT',
        is_nullable => 0,
    },
    how_to_apply => {
        data_type   => 'TEXT',
        is_nullable => 0,
    },
    token => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
    },
    is_public => {
        data_type     => 'TINYINT',
        is_nullable   => 0,
        default_value => 1,
    },
    is_activated => {
        data_type     => 'TINYINT',
        is_nullable   => 0,
        default_value => 0,
    },
    email => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
    },
    expires_at => {
        data_type   => 'DATETIME',
        is_nullable => 0,
        timezone    => 'Asia/Tokyo',
    },
    created_at => {
        data_type   => 'DATETIME',
        is_nullable => 0,
        timezone    => 'Asia/Tokyo',
    },
    updated_at => {
        data_type   => 'DATETIME',
        is_nullable => 0,
        timezone    => 'Asia/Tokyo',
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(['token']);

__PACKAGE__->belongs_to( category => 'Jobeet::Schema::Result::Category', 'category_id' );

sub insert {
    my $self = shift;

    $self->expires_at( DateTime->now->add( days => models('conf')->{active_days} ) );
    $self->next::method(@_);
}

1;
