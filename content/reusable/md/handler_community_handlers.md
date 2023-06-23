The following open source handlers are available from the Chef
community:

[Airbrake](https://github.com/timops/ohai-plugins/blob/master/win32_svc.rb)

: A handler that sends exceptions (only) to Airbrake, an application that collects data and aggregates it for review.

[Asynchronous Resources](https://github.com/rottenbytes/chef/tree/master/async_handler)

: A handler that asynchronously pushes exception and report handler data to a STOMP queue, from which data can be processed into data storage.

[Campfire](https://github.com/ampledata/chef-handler-campfire)

: A handler that collects exception and report handler data and reports it to Campfire, a web-based group chat tool.

[Datadog](https://github.com/DataDog/chef-handler-datadog)

: A handler that collects Chef Infra Client stats and sends them into a Datadog newsfeed.

[Flowdock](https://github.com/mmarschall/chef-handler-flowdock)

: A handler that collects exception and report handler data and sends it to users using the Flowdock API.

[Graphite](https://github.com/imeyer/chef-handler-graphite/wiki)

: A handler that collects exception and report handler data and reports it to Graphite, a graphic rendering application.

[Graylog2 GELF](https://github.com/jellybob/chef-gelf/)

: A handler that provides exception and report handler status (including changes) to a Graylog2 server, so that the data can be viewed using Graylog Extended Log Format (GELF).

[Growl](https://rubygems.org/gems/chef-handler-growl)

: A handler that collects exception and report handler data and then sends it as a Growl notification.

[HipChat](https://github.com/mojotech/hipchat/blob/master/lib/hipchat/chef.rb)

: A handler that collects exception handler data and sends it to HipChat, a hosted private chat service for companies and teams.

[IRC Snitch](https://rubygems.org/gems/chef-irc-snitch)

: A handler that notifies administrators (using Internet Relay Chat (IRC)) when a Chef Infra Client run fails.

[Journald](https://github.com/marktheunissen/chef-handler-journald)

: A handler that logs an entry to the systemd journal with the Chef Infra Client run status, exception details, configurable priority, and custom details.

[net/http](https://github.com/b1-systems/chef-handler-httpapi/)

: A handler that reports the status of a Chef run to any API using net/HTTP.

[Simple Email](https://rubygems.org/gems/chef-handler-mail)

: A handler that collects exception and report handler data and then uses pony to send email reports that are based on \`.erb\` (Embedded Ruby ) templates.

[SNS](http://onddo.github.io/chef-handler-sns/)

: A handler that notifies exception and report handler data and sends it to a SNS topic.

[Slack](https://github.com/rackspace-cookbooks/chef-slack_handler)

: A handler to send Chef Infra Client run notifications to a Slack channel.

[Splunk Storm](http://ampledata.org/splunk_storm_chef_handler.html)

: A handler that supports exceptions and reports for Splunk Storm.

[Syslog](https://github.com/jblaine/syslog_handler)

: A handler that logs basic essential information, such as about the success or failure of a Chef Infra Client run.

[Updated Resources](https://rubygems.org/gems/chef-handler-updated-resources)

: A handler that provides a simple way to display resources that were updated during a Chef Infra Client run.

[ZooKeeper](http://onddo.github.io/chef-handler-zookeeper/)

: A Chef report handler to send Chef run notifications to ZooKeeper.
