use strict;
use warnings;
use Test::More tests => 4;

use Jobeet::Test;
use Jobeet::Models;

{
    my $new_category = models('Schema::Category')->create({ name => 'Programming' });
    my $new_job = $new_category->add_to_jobs({
        type         => 'full-time',
        company      => 'Sensio Labs',
        logo         => 'sensio-labs.gif',
        url          => 'http://www.sensiolabs.com/',
        position     => 'Web Developer',
        location     => 'Paris, France',
        description  => q[You've already developed websites with symfony and you want to work with Open-Source technologies. You have a minimum of 3 years experience in web development with PHP or Java and you wish to participate to development of Web 2.0 sites using the best frameworks available.],
        how_to_apply => 'Send your resume to fabien.potencier [at] sensio.com',
        is_public    => 1,
        is_activated => 1,
        token        => 'job_sensio_labs',
        email        => 'job@example.com',
    });

    isa_ok $new_job, 'Jobeet::Schema::Result::Job';

    isa_ok $new_job->created_at, 'DateTime';
    
    isa_ok $new_job->updated_at, 'DateTime';

    isa_ok $new_job->expires_at, 'DateTime';
}


done_testing;
