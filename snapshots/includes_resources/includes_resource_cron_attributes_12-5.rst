.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``command``
   **Ruby Type:** String

   The command to be run, or the path to a file that contains the command to be run.

   Some examples:

   .. code-block:: none

      command if [ -x /usr/share/mdadm/checkarray ] && [ $(date +\%d) -le 7 ];
      then /usr/share/mdadm/checkarray --cron --all --idle --quiet; fi

   and:

   .. code-block:: ruby

      command %w{
        cd /srv/opscode-community-site/current &&
        env RUBYLIB="/srv/opscode-community-site/current/lib"
        RAILS_ASSET_ID=`git rev-parse HEAD` RAILS_ENV="#{rails_env}"
        bundle exec rake cookbooks_report
      }.join(' ')

   and:

   .. code-block:: ruby

      command "/srv/app/scripts/daily_report"
   
``day``
   **Ruby Type:** String

   The day of month at which the cron entry should run (1 - 31). Default value: ``*``.
   
``environment``
   **Ruby Type:** Hash

   A Hash of environment variables in the form of ``({"ENV_VARIABLE" => "VALUE"})``. (These variables must exist for a command to be run successfully.)
   
``home``
   **Ruby Type:** String

   Set the ``HOME`` environment variable.
   
``hour``
   **Ruby Type:** String

   The hour at which the cron entry is to run (0 - 23). Default value: ``*``.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   Continue running a recipe if a resource fails for any reason. Default value: ``false``.
   
``mailto``
   **Ruby Type:** String

   Set the ``MAILTO`` environment variable.
   
``minute``
   **Ruby Type:** String

   The minute at which the cron entry should run (0 - 59). Default value: ``*``.
   
``month``
   **Ruby Type:** String

   The month in the year on which a cron entry is to run (1 - 12). Default value: ``*``.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_notifies_syntax.rst
   
``path``
   **Ruby Type:** String

   Set the ``PATH`` environment variable.
   
``provider``
   **Ruby Type:** Chef Class

   Optional. Explicitly specifies a provider.
   
``retries``
   **Ruby Type:** Integer

   The number of times to catch exceptions and retry the resource. Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   The retry delay (in seconds). Default value: ``2``.
   
``shell``
   **Ruby Type:** String

   Set the ``SHELL`` environment variable.
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_timers_12-5.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notification_subscribes_syntax.rst
   
``time``
   **Ruby Type:** Symbol

   A time interval. Possible values: ``:annually``, ``:daily``, ``:hourly``, ``:midnight``, ``:monthly``, ``:reboot``, ``:weekly``, or ``:yearly``.
   
``user``
   **Ruby Type:** String

   This attribute is not applicable on the AIX platform. The name of the user that runs the command. If the ``user`` property is changed, the original ``user`` for the crontab program continues to run until that crontab program is deleted. Default value: ``root``.
   
``weekday``
   **Ruby Type:** String

   The day of the week on which this entry is to run (0 - 6), where Sunday = 0. Default value: ``*``.
