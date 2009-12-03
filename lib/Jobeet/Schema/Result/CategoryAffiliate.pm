package Jobeet::Schema::Result::CategoryAffiliate;
use strict;
use warnings;
use base 'Jobeet::Schema::ResultBase';

__PACKAGE__->table('jobeet_category_affiliate');

__PACKAGE__->add_columns(
    category_id => {
        data_type   => 'INTEGER',
        is_nullable => 0,
        extra => {
            unsigned => 1,
        },
    },
    affiliate_id => {
        data_type   => 'INTEGER',
        is_nullable => 0,
        extra => {
            unsigned => 1,
        },
    },
);

__PACKAGE__->set_primary_key(qw/category_id affiliate_id/);

__PACKAGE__->belongs_to(
    category => 'Jobeet::Schema::Result::Category', 'category_id' );
__PACKAGE__->belongs_to(
    affiliate => 'Jobeet::Schema::Result::Affiliate', 'affiliate_id' );

1;

