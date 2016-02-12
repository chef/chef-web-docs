.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following open source handlers are available from the |chef| community:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Handler
     - Description
   * - `Airbrake <https://github.com/morgoth/airbrake_handler>`_
     - A handler that sends exceptions (only) to |airbrake|, an application that collects data and aggregates it for review.
   * - `Asynchronous Resources <https://github.com/rottenbytes/chef/tree/master/async_handler>`_
     - A handler that asynchronously pushes exception and report handler data to a |stomp| queue, from which data can be processed into data storage.
   * - `Campfire <https://github.com/ampledata/chef-handler-campfire>`_
     - A handler that collects exception and report handler data and reports it to |campfire|, a web-based group chat tool.
   * - `Cloudkick <https://github.com/ampledata/chef-handler-campfire>`_
     - A handler that collects exception and report handler data and sends it to |cloudkick|, a set of cloud server monitoring and management tools.
   * - `Datadog <https://github.com/DataDog/chef-handler-datadog>`_
     - A handler that collects |chef client| stats and sends them into a |datadog| newsfeed.
   * - `Flowdock <https://github.com/mmarschall/chef-handler-flowdock>`_
     - A handler that collects exception and report handler data and sends it to users via the |flowdock| API..
   * - `Graphite <https://github.com/imeyer/chef-handler-graphite/wiki>`_
     - A handler that collects exception and report handler data and reports it to |graphite|, a graphic rendering application.
   * - `Graylog2 GELF <https://github.com/jellybob/chef-gelf/>`_
     - A handler that provides exception and report handler status (including changes) to a |graylog| server, so that the data can be viewed using |graylog gelf|.
   * - `Growl <http://rubygems.org/gems/chef-handler-growl>`_
     - A handler that collects exception and report handler data and then sends it as a |growl| notification.
   * - `HipChat <https://github.com/mojotech/hipchat/blob/master/lib/hipchat/chef.rb>`_
     - A handler that collects exception handler data and sends it to |hipchat|, a hosted private chat service for companies and teams.
   * - `IRC Snitch <https://rubygems.org/gems/chef-irc-snitch>`_
     - A handler that notifies administrators (via |irc|) when a |chef client| run fails.
   * - `Journald <https://github.com/marktheunissen/chef-handler-journald>`_
     - A handler that logs an entry to the |systemd| journal with the |chef client| run status, exception details, configurable priority, and custom details.
   * - `Simple Email <https://rubygems.org/gems/chef-handler-mail>`_
     - A handler that collects exception and report handler data and then uses |pony| to send email reports that are based on |erubis| templates.
   * - `SNS <http://onddo.github.io/chef-handler-sns/>`_
     - A handler that notifies exception and report handler data and sends it to a |sns| topic.
   * - `Slack <https://github.com/rackspace-cookbooks/chef-slack_handler>`_
     - A handler to send |chef client| run notifications to a |slack| channel.
   * - `Splunk Storm <http://ampledata.org/splunk_storm_chef_handler.html>`_
     - A handler that supports exceptions and reports for |splunk storm|.
   * - `Syslog <https://github.com/jblaine/syslog_handler>`_
     - A handler that logs basic essential information, such as about the success or failure of a |chef client| run.
   * - `Updated Resources <https://rubygems.org/gems/chef-handler-updated-resources>`_
     - A handler that provides a simple way to display resources that were updated during a |chef client| run.
   * - `ZooKeeper <http://onddo.github.io/chef-handler-zookeeper/>`_
     - A Chef report handler to send Chef run notifications to |zookeeper|.
