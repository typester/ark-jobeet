? extends 'common/base';

? block stylesheets => sub {
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/main.css') ?>" />
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/jobs.css') ?>" />
? }

? block content => sub {
<div id="jobs">
? for my $category ($c->stash->{categories}->all) {
    <div class="category_<?= lc $category->name ?>">
      <div class="category">
        <div class="feed">
          <a href="">Feed</a>
        </div>
        <h1><?= $category->name ?></h1>
      </div>
 
      <table class="jobs">
? my $i = 0;
? my $max_rows = Jobeet::Models->get('conf')->{max_jobs_on_homepage};
? for my $job ($category->get_active_jobs({ rows => $max_rows })) {
          <tr class="<?= $i++ % 2 ? 'even' : 'odd' ?>">
            <td class="location">
              <?= $job->location ?>
            </td>
            <td class="position">
              <?= $job->position ?>
            </td>
            <td class="company">
              <?= $job->company ?>
            </td>
          </tr>
? } #endfor $job
      </table>
    </div>
? } #endfor $category
</div>
? } #endblcok content

