? my @jobs = @_;
<table class="jobs">
? my $i = 0;
? for my $job (@jobs) {
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
