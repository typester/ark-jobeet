my $home = Jobeet::Models->get('home');

return {
    database => [
        'dbi:SQLite:' . $home->file('database.db'), '', '',
         {
             unicode        => 1,
             sqlite_unicode => 1,
         },
    ],
};
