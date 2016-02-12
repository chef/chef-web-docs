.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Use the |resource cron| resource to manage |cron| entries for time-based job scheduling. Properties for a schedule will default to ``*`` if not provided. The |resource cron| resource requires access to a |crontab| program, typically |cron|.

.. warning:: The |resource cron| resource should only be used to modify an entry in a |crontab| file. Use the |resource cookbook_file| or |resource template| resources to add a |crontab| file to the |crond| directory. The ``cron_d`` lightweight resource (found in the `cron <https://github.com/chef-cookbooks/cron>`__ cookbook) is another option for managing |crontab| files.
