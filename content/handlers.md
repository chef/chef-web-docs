+++
title = "About Handlers"
draft = false

gh_repo = "chef-web-docs"

aliases = ["/handlers.html"]

[menu]
  [menu.infra]
    title = "Handlers"
    identifier = "chef_infra/features/handlers.md Handlers"
    parent = "chef_infra/features"
    weight = 40
+++

{{% handler %}}

{{% handler_types %}}

## Exception/Report Handlers

{{% handler_type_exception_report %}}

### Run from Recipes

{{% handler_type_exception_report_run_from_recipe %}}

### Run from client.rb

A simple exception or report handler may be installed and configured at
run-time. This requires editing of a node's client.rb file to add the
appropriate setting and information about that handler to the client.rb
or solo.rb files. Depending on the handler type, one (or more) of the
following settings must be added:

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Setting</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>exception_handlers</code></td>
<td>A list of exception handlers that are available to Chef Infra Client during a Chef Infra Client run.</td>
</tr>
<tr>
<td><code>report_handlers</code></td>
<td>A list of report handlers that are available to Chef Infra Client during a Chef Infra Client run.</td>
</tr>
</tbody>
</table>

When this approach is used, the client.rb file must also tell Chef Infra
Client how to install and run the handler. There is no default install
location for handlers. The simplest way to distribute and install them
is via RubyGems, though other methods such as GitHub or HTTP will also
work. Once the handler is installed on the system, enable it in the
client.rb file by requiring it. After the handler is installed, it may
require additional configuration. This will vary from handler to
handler. If a handler is a very simple handler, it may only require the
creation of a new instance. For example, if a handler named
`MyOrg::EmailMe` is hardcoded for all of the values required to send
email, a new instance is required. And then the custom handler must be
associated with each of the handler types for which it will run.

For example:

```ruby
require '/var/chef/handlers/email_me'         # the installation path

email_handler = MyOrg::EmailMe.new            # a simple handler

start_handlers << email_handler               # run at the start of the run
report_handlers << email_handler              # run at the end of a successful run
exception_handlers << email_handler           # run at the end of a failed run
```

## Start Handlers

{{% handler_type_start %}}

### Run from Recipes

{{% handler_type_start_run_from_recipe %}}

### Run from client.rb

A start handler can be configured in the client.rb file by adding the
following setting:

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Setting</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>start_handlers</code></td>
<td>A list of start handlers that are available to Chef Infra Client at the start of a Chef Infra Client run.</td>
</tr>
</tbody>
</table>

For example, the Reporting start handler adds the following code to the
top of the client.rb file:

```ruby
begin
  require 'chef_reporting'
  start_handlers << Chef::Reporting::StartHandler.new()
rescue LoadError
  Chef::Log.warn 'Failed to load #{lib}. This should be resolved after a chef run.'
end
```

This ensures that when a Chef Infra Client run begins the
`chef_reporting` event handler is enabled. The `chef_reporting` event
handler is part of a gem named `chef-reporting`. The **chef_gem**
resource is used to install this gem:

```ruby
chef_gem 'chef-reporting' do
  action :install
end
```

## Event Handlers

{{% dsl_handler_summary %}}

### on Method

{{% dsl_handler_method_on %}}

### Event Types

{{% dsl_handler_event_types %}}

### Examples

The following examples show ways to use the Handler DSL.

#### Send Email

{{% dsl_handler_slide_send_email %}}

**Define How Email is Sent**

{{< readFile_shortcode file="dsl_handler_slide_send_email_library.md" >}}

**Add the Handler**

{{% dsl_handler_slide_send_email_handler %}}

**Test the Handler**

{{% dsl_handler_slide_send_email_test %}}

#### etcd Locks

{{% dsl_handler_example_etcd_lock %}}

#### HipChat Notifications

{{% dsl_handler_example_hipchat %}}

## Handlers and Cookbooks

The following cookbooks can be used to load handlers during a Chef Infra
Client run.

### chef_handler

Exception and report handlers can be distributed using the
**chef_handler** resource. This resource is included with Chef 14 and above.
It can be used to enable custom handlers from within recipes and to
include product-specific handlers from cookbooks.

More information on the **chef_handler** resource can be accessed in the
resource documentation [here](resources/chef_handler.md).

### Chef Infra Client

Start handlers can be distributed using the **chef-client** cookbook,
which will install the handler on the target node during the initial
configuration of the node. This ensures that the start handler is always
present on the node so that it is available to Chef Infra Client at the
start of every run.

## Custom Handlers

A custom handler can be created to support any situation. The easiest
way to build a custom handler:

1. Download the **chef_handler** cookbook
2. Create a custom handler
3. Write a recipe using the **chef_handler** resource
4. Add that recipe to a node's run-list, often as the first recipe in
   that run-list

### Syntax

The syntax for a handler can vary, depending on what the the situations
the handler is being asked to track, the type of handler being used, and
so on. All custom exception and report handlers are defined using Ruby
and must be a subclass of the `Chef::Handler` class.

```ruby
require 'chef/log'

module ModuleName
  class HandlerName < Chef::Handler
    def report
      # Ruby code goes here
    end
  end
end
```

where:

- `require` ensures that the logging functionality of Chef Infra
  Client is available to the handler
- `ModuleName` is the name of the module as it exists within the
  `Chef` library
- `HandlerName` is the name of the handler as it is used in a recipe
- `report` is an interface that is used to define the custom handler

For example, the following shows a custom handler that sends an email
that contains the exception data when a Chef Infra Client run fails:

```ruby
require 'net/smtp'

module OrgName
  class SendEmail < Chef::Handler
    def report
      if run_status.failed?
        message = "From: sender_name <sender@example.com>\n"
        message << "To: recipient_address <recipient@example.com>\n"
        message << "Subject: chef-client Run Failed\n"
        message << "Date: #{Time.now.rfc2822}\n\n"
        message << "Chef run failed on #{node.name}\n"
        message << "#{run_status.formatted_exception}\n"
        message << Array(backtrace).join('\n')
        Net::SMTP.start('your.smtp.server', 25) do |smtp|
          smtp.send_message message, 'sender@example', 'recipient@example'
        end
      end
    end
  end
end
```

and then is used in a recipe like:

```ruby
send_email 'blah' do
  # recipe code
end
```

### report Interface

The `report` interface is used to define how a handler will behave and
is a required part of any custom handler. The syntax for the `report`
interface is as follows:

```ruby
def report
  # Ruby code
end
```

The Ruby code used to define a custom handler will vary significantly
from handler to handler. Chef Infra Client includes two default
handlers: `error_report` and `json_file`. Their use of the `report`
interface is shown below.

The
[error_report](https://github.com/chef/chef/blob/master/lib/chef/handler/error_report.rb)
handler:

```ruby
require 'chef/handler'
require 'chef/resource/directory'

class Chef
  class Handler
    class ErrorReport < ::Chef::Handler
      def report
        Chef::FileCache.store('failed-run-data.json', Chef::JSONCompat.to_json_pretty(data), 0640)
        Chef::Log.fatal("Saving node information to #{Chef::FileCache.load('failed-run-data.json', false)}")
      end
    end
  end
end
```

The
[json_file](https://github.com/chef/chef/blob/master/lib/chef/handler/json_file.rb)
handler:

```ruby
require 'chef/handler'
require 'chef/resource/directory'

class Chef
  class Handler
    class JsonFile < ::Chef::Handler
      attr_reader :config
      def initialize(config = {})
        @config = config
        @config[:path] ||= '/var/chef/reports'
        @config
      end

      def report
        if exception
          Chef::Log.error('Creating JSON exception report')
        else
          Chef::Log.info('Creating JSON run report')
        end
        build_report_dir
        savetime = Time.now.strftime('%Y%m%d%H%M%S')
        File.open(File.join(config[:path], 'chef-run-report-#{savetime}.json'), 'w') do |file|
          run_data = data
          run_data[:start_time] = run_data[:start_time].to_s
          run_data[:end_time] = run_data[:end_time].to_s
          file.puts Chef::JSONCompat.to_json_pretty(run_data)
        end
      end

      def build_report_dir
        unless File.exist?(config[:path])
          FileUtils.mkdir_p(config[:path])
          File.chmod(00700, config[:path])
        end
      end
    end
  end
end
```

### Optional Interfaces

The following interfaces may be used in a handler in the same way as the
`report` interface to override the default handler behavior in Chef
Infra Client. That said, the following interfaces are not typically used
in a handler and, for the most part, are completely unnecessary for a
handler to work properly and/or as desired.

#### data

The `data` method is used to return the Hash representation of the
`run_status` object. For example:

```ruby
def data
  @run_status.to_hash
end
```

#### run_report_safely

The `run_report_safely` method is used to run the report handler,
rescuing and logging errors that may arise as the handler runs and
ensuring that all handlers get a chance to run during a Chef Infra
Client run (even if some handlers fail during that run). In general,
this method should never be used as an interface in a custom handler
unless this default behavior simply must be overridden.

```ruby
def run_report_safely(run_status)
  run_report_unsafe(run_status)
rescue Exception => e
  Chef::Log.error('Report handler #{self.class.name} raised #{e.inspect}')
  Array(e.backtrace).each { |line| Chef::Log.error(line) }
ensure
  @run_status = nil
end
```

#### run_report_unsafe

The `run_report_unsafe` method is used to run the report handler without
any error handling. This method should never be used directly in any
handler, except during testing of that handler. For example:

```ruby
def run_report_unsafe(run_status)
  @run_status = run_status
  report
end
```

### run_status Object

The `run_status` object is initialized by Chef Infra Client before the
`report` interface is run for any handler. The `run_status` object keeps
track of the status of a Chef Infra Client run and will contain some (or
all) of the following properties:

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Property</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>all_resources</code></td>
<td>A list of all resources that are included in the <code>resource_collection</code> property for the current Chef Infra Client run.</td>
</tr>
<tr>
<td><code>backtrace</code></td>
<td>A backtrace associated with the uncaught exception data that caused a Chef Infra Client run to fail, if present; <code>nil</code> for a successful Chef Infra Client run.</td>
</tr>
<tr>
<td><code>elapsed_time</code></td>
<td>The amount of time between the start (<code>start_time</code>) and end (<code>end_time</code>) of a Chef Infra Client run.</td>
</tr>
<tr>
<td><code>end_time</code></td>
<td>The time at which a Chef Infra Client run ended.</td>
</tr>
<tr>
<td><code>exception</code></td>
<td>The uncaught exception data which caused a Chef Infra Client run to fail; <code>nil</code> for a successful Chef Infra Client run.</td>
</tr>
<tr>
<td><code>failed?</code></td>
<td>Show that a Chef Infra Client run has failed when uncaught exceptions were raised during a Chef Infra Client run. An exception handler runs when the <code>failed?</code> indicator is <code>true</code>.</td>
</tr>
<tr>
<td><code>node</code></td>
<td>The node on which a Chef Infra Client run occurred.</td>
</tr>
<tr>
<td><code>run_context</code></td>
<td>An instance of the <code>Chef::RunContext</code> object; used by Chef Infra Client to track the context of the run; provides access to the <code>cookbook_collection</code>, <code>resource_collection</code>, and <code>definitions</code> properties.</td>
</tr>
<tr>
<td><code>start_time</code></td>
<td>The time at which a Chef Infra Client run started.</td>
</tr>
<tr>
<td><code>success?</code></td>
<td>Show that a Chef Infra Client run succeeded when uncaught exceptions were not raised during a Chef Infra Client run. A report handler runs when the <code>success?</code> indicator is <code>true</code>.</td>
</tr>
<tr>
<td><code>updated_resources</code></td>
<td>A list of resources that were marked as updated as a result of a Chef Infra Client run.</td>
</tr>
</tbody>
</table>

<div class="admonition-note">
<p class="admonition-note-title">Note</p>
<div class="admonition-note-text">

These properties are not always available. For example, a start handler
runs at the beginning of Chef Infra Client run, which means that
properties like `end_time` and `elapsed_time` are still unknown and will
be unavailable to the `run_status` object.

</div>
</div>

## Examples

The following sections show examples of handlers.

### Cookbook Versions

Community member `juliandunn` created a custom [report handler that logs
all of the cookbooks and cookbook
versions](https://github.com/juliandunn/cookbook_versions_handler) that
were used during a Chef Infra Client run, and then reports after the run
is complete. This handler requires the **chef_handler** resource (which
is available from the **chef_handler** cookbook).

#### cookbook_versions.rb

The following custom handler defines how cookbooks and cookbook versions
that are used during a Chef Infra Client run will be compiled into a
report using the `Chef::Log` class in Chef Infra Client:

```ruby
require 'chef/log'

module Opscode
  class CookbookVersionsHandler < Chef::Handler
    def report
      cookbooks = run_context.cookbook_collection
      Chef::Log.info('Cookbooks and versions run: #{cookbooks.keys.map {|x| cookbooks[x].name.to_s + ' ' + cookbooks[x].version} }')
    end
  end
end
```

#### default.rb

The following recipe is added to the run-list for every node on which a
list of cookbooks and versions will be generated as report output after
every Chef Infra Client run.

```ruby
include_recipe 'chef_handler'

cookbook_file "#{node['chef_handler']['handler_path']}/cookbook_versions.rb" do
  source 'cookbook_versions.rb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

chef_handler 'Opscode::CookbookVersionsHandler' do
  source "#{node['chef_handler']['handler_path']}/cookbook_versions.rb"
  supports :report => true
  action :enable
end
```

This recipe will generate report output similar to the following:

```ruby
[2013-11-26T03:11:06+00:00] INFO: Chef Run complete in 0.300029878 seconds
[2013-11-26T03:11:06+00:00] INFO: Running report handlers
[2013-11-26T03:11:06+00:00] INFO: Cookbooks and versions run: ["chef_handler 1.1.4", "cookbook_versions_handler 1.0.0"]
[2013-11-26T03:11:06+00:00] INFO: Report handlers complete
```

### Reporting

Start handler functionality was added when Chef started building add-ons
for the Chef Infra Server. The Reporting add-on is designed to create
reporting data based on a Chef Infra Client run. And since Reporting
needs to be able to collect data for the entire Chef Infra Client run,
Reporting needs to be enabled before anything else happens at the start
of a Chef Infra Client run.

{{< note >}}

The start handler used by the Reporting add-on for the Chef Infra Server
is always installed using the **chef-client** cookbook.

{{< /note >}}

#### start_handler.rb

The following code shows the start handler used by the Reporting add-in
for the Chef Infra Server:

```ruby
require 'chef/handler'
require 'chef/rest'
require 'chef/version_constraint'

class Chef
  class Reporting
    class StartHandler < ::Chef::Handler
      attr_reader :config

      def initialize(config = {})
        @config = config
      end

      def report
        version_checker = Chef::VersionConstraint.new('< 11.6.0')
        if version_checker.include?(Chef::VERSION)
          Chef::Log.info('Enabling backported resource reporting Handler')
          rest = Chef::REST.new(Chef::Config[:chef_server_url], @run_status.node.name, Chef::Config[:client_key])
          resource_reporter = Chef::Reporting::ResourceReporter.new(rest)
          @run_status.events.register(resource_reporter)

          resource_reporter.run_started(@run_status)
        else
          Chef::Log.debug('Chef Version already has new Resource Reporter - skipping startup of backport version')
        end
      end
    end
  end
end
```

### json_file Handler

The
[json_file](https://github.com/chef/chef/blob/master/lib/chef/handler/json_file.rb)
handler is available from the **chef_handler** cookbook and can be used
with exceptions and reports. It serializes run status data to a JSON
file. This handler may be enabled in one of the following ways.

By adding the following lines of Ruby code to either the client.rb file
or the solo.rb file, depending on how Chef Infra Client is being run:

```ruby
require 'chef/handler/json_file'
report_handlers << Chef::Handler::JsonFile.new(:path => '/var/chef/reports')
exception_handlers << Chef::Handler::JsonFile.new(:path => '/var/chef/reports')
```

By using the **chef_handler** resource in a recipe, similar to the
following:

```ruby
chef_handler 'Chef::Handler::JsonFile' do
  source 'chef/handler/json_file'
  arguments :path => '/var/chef/reports'
  action :enable
end
```

After it has run, the run status data can be loaded and inspected via
Interactive Ruby (IRb):

```ruby
irb(main):002:0> require 'json' => true
irb(main):003:0> require 'chef' => true
irb(main):004:0> r = JSON.parse(IO.read('/var/chef/reports/chef-run-report-20110322060731.json')) => ... output truncated
irb(main):005:0> r.keys => ['end_time', 'node', 'updated_resources', 'exception', 'all_resources', 'success', 'elapsed_time', 'start_time', 'backtrace']
irb(main):006:0> r['elapsed_time'] => 0.00246
```

### error_report Handler

The
[error_report](https://github.com/chef/chef/blob/master/lib/chef/handler/error_report.rb)
handler is built into Chef Infra Client and can be used for both
exceptions and reports. It serializes error report data to a JSON file.
This handler may be enabled in one of the following ways.

By adding the following lines of Ruby code to either the client.rb file
or the solo.rb file, depending on how Chef Infra Client is being run:

```ruby
require 'chef/handler/error_report'
report_handlers << Chef::Handler::ErrorReport.new()
exception_handlers << Chef::Handler::ErrorReport.new()
```

By using the [chef_handler](/resources/chef_handler/) resource in a
recipe, similar to the following:

```ruby
chef_handler 'Chef::Handler::ErrorReport' do
  source 'chef/handler/error_report'
  action :enable
end
```

### Community Handlers

{{% handler_community_handlers %}}
