Use the **cron** resource to manage cron entries for time-based job
scheduling.

<div class="alert-warning">

The **cron** resource should only be used to modify an entry in a
crontab file. The `cron_d` resource directly manages cron.d files. This
resource ships in Chef 14.4 or later and can also be found in the
[cron](https://github.com/chef-cookbooks/cron) cookbook) for previous
chef-client releases.

</div>