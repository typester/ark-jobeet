? extends 'common/jobs_base';

? block content => sub {
<div id="jobs">
? for my $category ($c->stash->{categories}->all) {
    <div class="category_<?= lc $category->name ?>">
      <div class="category">
        <div class="feed">
          <a href="">Feed</a>
        </div>
        <h1>
          <a href="<?= $c->uri_for('/category', $category->slug) ?>">
            <?= $category->name ?>
          </a>
        </h1>
      </div>

? my $max_rows = Jobeet::Models->get('conf')->{max_jobs_on_homepage};
?= include('job/partial_jobs', $category->get_active_jobs({ rows => $max_rows }));

? my $count = $category->get_active_jobs->count;
? if ( (my $rest = $count - $max_rows) > 0 ) {
      <div class="more_jobs">
        and <a href="<?= $c->uri_for('/category', $category->slug) ?>"><?= $rest ?></a>
        more...
      </div>
? } # endif

    </div>
? } #endfor $category
</div>
? } #endblcok content

