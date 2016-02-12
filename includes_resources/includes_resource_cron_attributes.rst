.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following properties:
   
``command``
   **Ruby Type:** String

   |command_or_path|

   Some examples:

   .. code-block:: ruby

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

   |day cron| Default value: ``*``.
   
``environment``
   **Ruby Type:** Hash

   |environment variables|
   
``home``
   **Ruby Type:** String

   |environment set_home|
   
``hour``
   **Ruby Type:** String

   |hour cron| Default value: ``*``.
   
``ignore_failure``
   **Ruby Types:** TrueClass, FalseClass

   |ignore_failure| Default value: ``false``.
   
``mailto``
   **Ruby Type:** String

   |environment set_mailto|
   
``minute``
   **Ruby Type:** String

   |minute cron| Default value: ``*``.
   
``month``
   **Ruby Type:** String

   |month cron| Default value: ``*``.
   
``notifies``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |notifies|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_notifies.rst

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_timers.rst
   
``path``
   **Ruby Type:** String

   |environment set_path|
   
``provider``
   **Ruby Type:** Chef Class

   Optional. |provider resource_parameter|
   
``retries``
   **Ruby Type:** Integer

   |retries| Default value: ``0``.
   
``retry_delay``
   **Ruby Type:** Integer

   |retry_delay| Default value: ``2``.
   
``shell``
   **Ruby Type:** String

   |environment set_shell|
   
``subscribes``
   **Ruby Type:** Symbol, 'Chef::Resource[String]'

   |subscribes|

   .. include:: ../../includes_resources_common/includes_resources_common_notifications_syntax_subscribes.rst

   |subscribes timers|
   
``time``
   **Ruby Type:** Symbol

   |time cron|
   
``user``
   **Ruby Type:** String

   This attribute is not applicable on the |ibm aix| platform. |name user cron| Default value: ``root``.
   
``weekday``
   **Ruby Type:** String

   |weekday cron| Default value: ``*``.
