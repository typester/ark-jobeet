? my @jobs = $c->stash->{jobs}->all;

? if (@jobs) {
?= include('job/partial_jobs', @jobs );
? } else {
No results.
? }

