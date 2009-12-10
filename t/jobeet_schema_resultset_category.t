use strict;
use warnings;
use Test::More tests => 3;

use Jobeet::Test;
use Jobeet::Models;
use DateTime;

{
    ## create test data
    my $programming_category =
        models('Schema::Category')->create({ name => 'Programming' });
        
    my $programming_job = $programming_category->add_to_jobs({
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
    
    ## do test
    {
        isa_ok models('Schema::Category')->get_with_jobs, 'Jobeet::Schema::ResultSet::Category', 'get_with_jobs: returning "Jobeet::Schema::ResultSet::Category" object';
    }
    
    {
        my $first_job = models('Schema::Category')->get_with_jobs->first;
        
        is $first_job->id, $programming_job->id, 'get_with_jobs: got $programming_job';
    }
    
    {
        my $yesterday = DateTime->now->subtract( days => 1 );

        # Now, $programming_job expires
        $programming_job->update({ expires_at => $yesterday });

        is models('Schema::Category')->get_with_jobs->count, 0, 'get_with_jobs: expired job is not appeared';
    }
}

done_testing;
