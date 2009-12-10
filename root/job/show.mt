? my $job  = $c->stash->{job};

? extends 'common/base';

? block stylesheets => sub {
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/main.css') ?>" />
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/job.css') ?>" />
? }

? block content => sub {

<div id="job_actions">
  <h3>Admin</h3>
  <ul>
? if (!$job->is_activated) {
      <li><a href="<?= $c->uri_for('/job', $job->token, 'edit') ?>">Edit</a></li>
      <li><a href="<?= $c->uri_for('/job', $job->token, 'publish') ?>">Publish</a></li>
? }
    <li><a href="<?= $c->uri_for('/job', $job->token, 'delete') ?>" onclick="return confirm('Are you sure?')">Delete</a></li>

? if ($job->is_activated) {
    <li<?= $job->expires_soon ? ' class="expires_soon"' : '' ?>>
? if ($job->is_expired) {
          Expired
? } else {
          Expires in <strong><?= $job->days_before_expired ?></strong> days
? }

? if ($job->expires_soon) {
         - <a href="">Extend</a> for another <?= Jobeet::Models->get('conf')->{active_days} ?> days
? }
      </li>
? } else {
      <li>
        [Bookmark this <a href="<?= $c->req->uri ?>">URL</a> to manage this job in the future.]
      </li>
? }
  </ul>
</div>

<div id="job">
  <h1><?= $job->company ?></h1>
  <h2><?= $job->location ?></h2>
  <h3>
    <?= $job->category->name ?>    <small> - <?= $job->type ?></small>
  </h3>

  <div class="description">
    <?= $job->description ?>
  </div>

  <h4>How to apply?</h4>

  <p class="how_to_apply"><?= $job->how_to_apply ?></p>

  <div class="meta">
    <small>posted on <?= $job->created_at->ymd ?></small>
  </div>
</div>

? } # endblock content

