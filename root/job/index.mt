? extends 'common/base';

? block stylesheets => sub {
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/main.css') ?>" />
<link rel="stylesheet" type="text/css" href="<?= $c->uri_for('/css/jobs.css') ?>" />
? }

? block content => sub {
<div id="jobs">
  <table class="jobs">
? my $i = 0;
? for my $job ($c->stash->{jobs}->all) {
? $i++;
      <tr class="<?= $i % 2 == 0 ? 'even' : 'odd' ?>">
        <td class="location"><?= $job->location ?></td>
        <td class="position">
          <a href="<?= $c->uri_for('/job', $job->id) ?>">
            <?= $job->position ?>
          </a>
        </td>
        <td class="company"><?= $job->company ?></td>
      </tr>
? } # endfor
</table>
</div>
? } # endblock content

