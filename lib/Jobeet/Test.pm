package Jobeet::Test;
use Ark 'Test';

use File::Temp qw/tempdir/;
use Jobeet::Models;

sub import {
    my ($class, $app, %options) = @_;
    $app ||= 'Jobeet';

    {
        my $dir = tempdir( CLEANUP => 1 );

        models('conf')->{database} = [
            "dbi:SQLite:$dir/jobeet-test-database.db", undef, undef,
            { unicode => 1, ignore_version => 1 },
        ];
        models('Schema')->deploy;
    }

    @_ = ($class, $app, %options);
    goto $class->can('SUPER::import');
}



1;
