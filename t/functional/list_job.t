use strict;
use warnings;
use Test::More;

use Jobeet::Test 'Jobeet';
use Jobeet::Models;
use DateTime;

use HTTP::Request::Common;

# create default Jobs
{
    my $job_rs = models('Schema::Job');
    my $cat_rs = models('Schema::Category');
    
    my $cat_programming = $cat_rs->create({ name => 'Programming' });
    
    my $max_jobs_on_homepage = models('conf')->{max_jobs_on_homepage};
    for my $i ( 1 .. ($max_jobs_on_homepage + 1) ) {
        my $job = $job_rs->create({
            category_id  => $cat_programming->id,
            company      => "Company $i",
            position     => 'Web Developer',
            location     => 'Paris, France',
            description  => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
            how_to_apply => "Send your resume to lorem.ipsum [at] company_${i}.sit",
            is_public    => 1,
            is_activated => 1,
            token        => "job_$i",
            email        => 'job@example.com',
        });
    }
}

# test
# 求人が多すぎる場合のみカテゴリはカテゴリページへのリンクを持つ
{
    my $res = request( GET '/job' );

    like $res->content, qr{ class="more_jobs" }xms, 'A category has a link to the category page only if too many jobs';
}

{
    my $res = request( GET '/job/create' );

    my @job_form_names = qw/ category type company url position location description how_to_apply email /;
    
    for my $name (@job_form_names) {
        like $res->content, qr{ name="$name" }xms, sprintf('job form has %s', $name);
    }
}





done_testing;
