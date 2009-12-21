<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <title><? block title => sub { 'Jobeet - Your best job board' } ?></title>
    <link rel="shortcut icon" href="/favicon.ico" />
    <link rel="alternate" type="application/atom+xml" title="Latest Jobs"
          href="<?= $c->uri_for('/job/atom') ?>" />
? block javascripts => sub {
    <script type="text/javascript" src="<?= $c->uri_for('/js/jquery-1.3.2.min.js') ?>"></script>
    <script type="text/javascript" src="<?= $c->uri_for('/js/search.js') ?>"></script>
? } # endblock javascripts
    <? block stylesheets => '' ?>
  </head>
  <body>
    <div id="container">
      <div id="header">
        <div class="content">
          <h1><a href="<?= $c->uri_for('/') ?>">
            <img src="/images/logo.jpg" alt="Jobeet Job Board" />
          </a></h1>
 
          <div id="sub_header">
            <div class="post">
              <h2>Ask for people</h2>
              <div>
                <a href="<?= $c->uri_for('/job/create') ?>">Post a Job</a>
              </div>
            </div>
 
            <div class="search">
              <h2>Ask for a job</h2>
              <form action="<?= $c->uri_for('/search') ?>" method="get">
                <input type="text" name="q"
                  id="search_keywords" />
                <input type="submit" value="search" />
                <img id="loader" src="<?= $c->uri_for('/images/loader.gif') ?>" style="vertical-align: middle; display: none" />
                <div class="help">
                  Enter some keywords (city, country, position, ...)
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>

? my @history = @{ $c->session->get('job_history') || [] };
? if (@history) {
      <div id="job_history">
        Recent viewed jobs:
        <ul>
? my $i = 0;
? for my $job (@history) {
          <li>
            <?= $job->{position} ?> - <?= $job->{company} ?>
          </li>
? last if ++$i == 3;
? } # endfor $job
        </ul>
      </div>
? } # endif @history
 
      <div id="content">
        <div class="content">
? block content => '';
        </div>
      </div>
 
      <div id="footer">
        <div class="content">
          <span class="symfony">
            <img src="/images/jobeet-mini.png" />
            powered by <a href="http://opensource.kayac.com/projects/ark/">Ark</a>
          </span>
          <ul>
            <li><a href="">About Jobeet</a></li>
            <li class="feed">
              <a href="<?= $c->uri_for('/job/atom') ?>">Full feed</a>
            </li>
            <li><a href="">Jobeet API</a></li>
            <li class="last"><a href="">Affiliates</a></li>
          </ul>
        </div>
      </div>
    </div>
  </body>
</html>
