.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``backup`` subcommand is used to back up all |chef server| data. This subcommand:

* Requires |rsync| to be installed on the |chef server| prior to running the command
* Requires a ``chef-server-ctl reconfigure`` prior to running the command
* Should not be run in a |chef server| configuration with an external |postgresql| database; `use knife ec backup <https://github.com/chef/knife-ec-backup>`__ instead
* Puts the initial backup in the ``/var/opt/chef-backup`` directory as a |tar gz| file; move this backup to a new location for safe keeping