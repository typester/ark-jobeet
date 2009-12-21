my $home = Jobeet::Models->get('home');

return {
    active_days => 30,
    max_jobs_on_homepage => 10,
    max_jobs_on_category => 20,

    database => [
        'dbi:SQLite:' . $home->file('database.db'), '', '',
         {
#             unicode        => 1,
             sqlite_unicode => 1,
         },
    ],

    cache => {
        share_file     => $home->file('tmp', 'cache')->stringify,
        unlink_on_exit => 0,
    },
};
