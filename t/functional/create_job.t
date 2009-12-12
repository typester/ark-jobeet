use strict;
use warnings;
use Test::More;

use Jobeet::Test 'Jobeet';
use Jobeet::Models;
use DateTime;

use HTTP::Request::Common;

models('Schema::Category')->create({ name => 'Programming' });


{
    my @job_form_names = qw/ category type company url position location description how_to_apply email /;
    my $res = request( GET '/job/create' );
    
    like $res->content, qr{ name="$_" }xms, sprintf('job form has %s', $_)
        for @job_form_names;
}


{
    my @choice_fields  = qw/ category type /;
    my @job_form_names = qw/ company url position location description how_to_apply email /;

    my %params =  map { $_ => undef } @job_form_names;
    my $res = request( POST '/job/create', [ %params ] );

    like $res->content, qr{<span class="error">}, 'job form shows error message';
}

{
    my @choice_fields  = qw/ category type /;
    my @job_form_names = qw/ company url position location description how_to_apply email /;

    my %params =  map { $_ => undef } @job_form_names;
    my $res = request( POST '/job/create', [ %params ] );

    like $res->content, qr{<span class="error">}, 'job form shows error message';
}

{
    my $category = models('Schema::Category')->find({ name => 'Programming' });
    my $category_slug = $category->slug;

    my %params = (
        category => $category_slug,
        type         => 'full-time',
        company      => 'Sensio Labs',
        url          => 'http://www.sensiolabs.com/',
        position     => 'Web Developer',
        location     => 'Paris, France',
        description  => q[You've already developed websites with symfony and you want to work with Open-Source technologies. You have a minimum of 3 years experience in web development with PHP or Java and you wish to participate to development of Web 2.0 sites using the best frameworks available.],
        how_to_apply => 'Send your resume to fabien.potencier [at] sensio.com',
        email        => 'job@example.com',
    );

    {
        my $res = request( POST '/job/create', [ %params ] );

        is $res->code, 302, 'job create ok';
    
        my $job_uniq_url = $res->header('location');

        {
            my $res = request( GET $job_uniq_url );
            like $res->content, qr{<div id="job_actions">}, 'show job';
        }
        

        {
            ## appear "Extend" link when job is expires_soon
            my $created_job = models('Schema::Job')->search(
                { category_id => $category->id },
                { rows => 1, page => 1},
            )->first;
            
            # publish job
            {
                {
                    my $res = request( GET sprintf('/job/%s/publish', $created_job->token) );
                    
                    is $res->code, 302;    
                }
                
                $created_job->discard_changes;

                ok $created_job->is_activated, 'job published';

                {
                    my $res = request( GET $job_uniq_url );

                    like $res->content, qr{Expires in .+ days}, 'show days_before_expired after published';
                }
                
            }
            
            # expire soon
            $created_job->update({ expires_at => DateTime->now->add( days => 1 ) });
            
            {
                my $res = request( GET sprintf('/job/%s', $created_job->token) );
                like $res->content, qr{<a href="">Extend</a>}, 'appear "Extend" link when job is expires_soon';
            }
            
        }
    }
}





done_testing;
