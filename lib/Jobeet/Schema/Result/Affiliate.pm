package Jobeet::Schema::Result::Affiliate;
use strict;
use warnings;
use base 'Jobeet::Schema::ResultBase';

__PACKAGE__->table('jobeet_affiliate');

__PACKAGE__->add_columns(
    id => {
        data_type         => 'INTEGER',
        is_nullable       => 0,
        is_auto_increment => 1,
        extra => {
            unsigned => 1,
        },
    },
    url => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
    },
    email => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
    },
    token => {
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
    },
    is_active => {
        data_type     => 'TINYINT',
        is_nullable   => 0,
        default_value => 0,
    },
    created_at => {
        data_type   => 'DATETIME',
        is_nullable => 0,
        timezone    => 'Asia/Tokyo',
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint(['email']);

__PACKAGE__->has_many(
    category_affiliate => 'Jobeet::Schema::Result::CategoryAffiliate', 'affiliate_id' );

__PACKAGE__->many_to_many( categories => category_affiliate => 'category' );

1;

