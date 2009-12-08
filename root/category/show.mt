? my $category = $c->stash->{category};
? my $jobs     = $c->stash->{jobs};
? my $pager    = $jobs->pager;

? extends 'common/jobs_base';

? block title => sub { sprintf 'Jobs in the %s category', $category->name };

? block content => sub { 
<div class="category">
  <div class="feed">
    <a href="">Feed</a>
  </div>
  <h1><?= $category->name ?></h1>
</div>

?= include('job/partial_jobs', $category->get_active_jobs);

? if ($pager->last_page > 1) {
  <div class="pagination">
    <a href="<?= $c->req->uri_with({ page => $pager->first_page }) ?>">
      <img src="/images/first.png" alt="First page" />
    </a>

? if ($pager->previous_page) {
    <a href="<?= $c->req->uri_with({ page => $pager->previous_page }) ?>">
      <img src="/images/previous.png" alt="Previous page" title="Previous page" />
    </a>
? } else {
      <img src="/images/previous.png" alt="Previous page" title="Previous page" />
? }

? for my $p ($pager->pages_in_navigation) { 
?     if ($p == $pager->current_page) {
          <?= $p ?>
?     } else {
          <a href="<?= $c->req->uri_with({ page => $p }) ?>"><?= $p ?></a>
?     }
? }

? if ($pager->next_page) {
    <a href="<?= $c->req->uri_with({ page => $pager->next_page }) ?>">
      <img src="/images/next.png" alt="Next page" title="Next page" />
    </a>
? } else {
      <img src="/images/next.png" alt="Next page" title="Next page" />
? }

    <a href="<?= $c->req->uri_with({ page => $pager->last_page }) ?>">
      <img src="/images/last.png" alt="Last page" title="Last page" />
    </a>
  </div>
? } # endif

<div class="pagination_desc">
  <strong><?= $pager->total_entries ?></strong> jobs in this category

? if ($pager->last_page > 1) {
    - page <strong><?= $pager->current_page ?>/<?= $pager->last_page ?></strong>
? }
</div>

? } # endblock content

