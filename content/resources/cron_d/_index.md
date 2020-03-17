---
title: cron_d resource
resource: cron_d
draft: false
aliases:
- /resource_cron_d.html
menu:
  infra:
    title: cron_d
    identifier: chef_infra/cookbook_reference/resources/cron_d cron_d
    parent: chef_infra/cookbook_reference/resources
    weight: 390
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **cron_d** resource to manage cron job files in the /etc/cron.d

    directory.'
- warning:
    markdown: 'Chef Infra Client also ships with the **cron** resource for managing
      the

      monolithic `/etc/crontab` file on platforms that lack cron.d support.

      See the [cron resource](/resources/cron/) for information on using

      that resource.'
resource_new_in: '14.4'
handler_types: false
syntax_description: "A **cron_d** resource block manages cron.d files. For example,\
  \ to get a\nweekly cookbook report from the Chef Supermarket:\n\n``` ruby\ncron_d\
  \ 'cookbooks_report' do\n  action :create\n  minute '0'\n  hour '0'\n  weekday '1'\n\
  \  user 'getchef'\n  mailto 'sysadmin@example.com'\n  home '/srv/supermarket/shared/system'\n\
  \  command %W{\n    cd /srv/supermarket/current &&\n    env RUBYLIB=\"/srv/supermarket/current/lib\"\
  \n    RAILS_ASSET_ID=`git rev-parse HEAD` RAILS_ENV=\"#{rails_env}\"\n    bundle\
  \ exec rake cookbooks_report\n  }.join(' ')\nend\n```"
syntax_code_block: null
syntax_properties_list: null
syntax_full_code_block: "cron_d 'name' do\n  command               String\n  comment\
  \               String\n  cookbook              String\n  cron_name            \
  \ String # default value: 'name' unless specified\n  day                   Integer,\
  \ String # default value: \"*\"\n  environment           Hash\n  home          \
  \        String\n  hour                  Integer, String # default value: \"*\"\n\
  \  mailto                String\n  minute                Integer, String # default\
  \ value: \"*\"\n  mode                  String, Integer # default value: \"0600\"\
  \n  month                 Integer, String # default value: \"*\"\n  path       \
  \           String\n  predefined_value      String\n  random_delay          Integer\n\
  \  shell                 String\n  time_out              Hash\n  user          \
  \        String # default value: \"root\"\n  weekday               Integer, String\
  \ # default value: \"*\"\n  action                Symbol # defaults to :create if\
  \ not specified\nend"
syntax_full_properties_list:
- '`cron_d` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`command`, `comment`, `cookbook`, `cron_name`, `day`, `environment`, `home`, `hour`,
  `mailto`, `minute`, `mode`, `month`, `path`, `predefined_value`, `random_delay`,
  `shell`, `time_out`, `user`, and `weekday` are the properties available to this
  resource.'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Default. Add a cron definition file to /etc/cron.d.
  :delete:
    markdown: Remove a cron definition file from /etc/cron.d if it exists.
  :create_if_missing:
    markdown: Add a cron definition file to /etc/cron.d, but do not update an existing
      file.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: command
  ruby_type: String
  required: true
  default_value: null
  new_in: null
  description_list:
  - markdown: "The command to be run, or the path to a file that contains the\ncommand\
      \ to be run.\n\nSome examples:\n\n``` none\ncommand if [ -x /usr/share/mdadm/checkarray\
      \ ] && [ $(date +\\%d) -le 7 ];\nthen /usr/share/mdadm/checkarray --cron --all\
      \ --idle --quiet; fi\n```\n\nand:\n\n``` ruby\ncommand %w{\n  cd /srv/opscode-community-site/current\
      \ &&\n  env RUBYLIB=\"/srv/opscode-community-site/current/lib\"\n  RAILS_ASSET_ID=`git\
      \ rev-parse HEAD` RAILS_ENV=\"#{rails_env}\"\n  bundle exec rake cookbooks_report\n\
      }.join(' ')\n```\n\nand:\n\n``` ruby\ncommand \"/srv/app/scripts/daily_report\"\
      \n```"
- property: comment
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: A comment to place in the cron.d file.
- property: cookbook
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list: []
- property: cron_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the cron name if it differs from the

      resource block''s name.'
- property: day
  ruby_type: Integer, String
  required: false
  default_value: '"*"'
  new_in: null
  description_list:
  - markdown: The day of month at which the cron entry should run (`1 - 31`).
- property: environment
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A Hash containing additional arbitrary environment variables under

      which the cron job will be run in the form of

      `({''ENV_VARIABLE'' => ''VALUE''})`. (These variables must exist for a

      command to be run successfully.)'
- property: home
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Set the `HOME` environment variable in the cron.d file.
- property: hour
  ruby_type: Integer, String
  required: false
  default_value: '"*"'
  new_in: null
  description_list:
  - markdown: The hour at which the cron entry is to run (`0 - 23`).
- property: mailto
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Set the `MAILTO` environment variable in the cron.d file.
- property: minute
  ruby_type: Integer, String
  required: false
  default_value: '"*"'
  new_in: null
  description_list:
  - markdown: The minute at which the cron entry should run (`0 - 59`).
- property: mode
  ruby_type: String, Integer
  required: false
  default_value: '"0600"'
  new_in: null
  description_list:
  - markdown: The octal mode of the generated crontab file.
- property: month
  ruby_type: Integer, String
  required: false
  default_value: '"*"'
  new_in: null
  description_list:
  - markdown: 'The month in the year on which a cron entry is to run (`1 - 12`,

      `jan-dec`, or `*`).'
- property: path
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Set the `PATH` environment variable in the cron.d file.
- property: predefined_value
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  allowed_values: '@reboot, @yearly, @annually, @monthly, @weekly, @daily, @midnight, @hourly'
  description_list:
  - markdown: 'Schedule your cron job with one of the special predefined value

      instead of \*\* \* pattern. This correspond to "@reboot", "@yearly",

      "@annually", "@monthly", "@weekly", "@daily", "@midnight" or

      "@hourly".'
- property: random_delay
  ruby_type: Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Set the `RANDOM_DELAY` environment variable in the cron.d file.
- property: shell
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Set the `SHELL` environment variable in the cron.d file.
- property: time_out
  ruby_type: Hash
  required: false
  default_value: null
  new_in: '15.7'
  description_list:
  - markdown: "A Hash of timeouts in the form of ({'OPTION' =\\> 'VALUE'}).\n\n: \
      \  Accepted valid options are: preserve-status (BOOL, default:\n    'false'),\
      \ foreground (BOOL, default: 'false'), kill-after (in\n    seconds), signal\
      \ (a name like 'HUP' or a number)"
- property: user
  ruby_type: String
  required: false
  default_value: '"root"'
  new_in: null
  description_list:
  - markdown: The name of the user that runs the command.
- property: weekday
  ruby_type: Integer, String
  required: false
  default_value: '"*"'
  new_in: null
  description_list:
  - markdown: 'The day of the week on which this entry is to run (`0-7`, `mon-sun`,

      or `*`), where Sunday is both 0 and 7.'
properties_shortcode: null
properties_multiple_packages: false
resource_directory_recursive_directories: false
resources_common_atomic_update: false
properties_resources_common_windows_security: false
remote_file_prevent_re_downloads: false
remote_file_unc_path: false
ps_credential_helper: false
ruby_style_basics_chef_log: false
debug_recipes_chef_shell: false
template_requirements: false
resources_common_properties: true
resources_common_notification: true
resources_common_guards: true
common_resource_functionality_multiple_packages: false
resources_common_guard_interpreter: false
remote_directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Run a program at a specified interval
  text_blocks:
  - code_block: "cron_d 'noop' do\n  hour '5'\n  minute '0'\n  command '/bin/true'\n\
      end"
- example_heading: Run an entry if a folder exists
  text_blocks:
  - code_block: "cron_d 'ganglia_tomcat_thread_max' do\n  command \"/usr/bin/gmetric\n\
      \    -n 'tomcat threads max'\n    -t uint32\n    -v '/usr/local/bin/tomcat-stat\n\
      \    --thread-max'\"\n  only_if { ::File.exist?('/home/jboss') }\nend"
- example_heading: Run every Saturday, 8:00 AM
  text_blocks:
  - markdown: 'The following example shows a schedule that will run every hour at
      8:00

      each Saturday morning, and will then send an email to

      "<admin@example.com>" after each run.'
  - code_block: "cron_d 'name_of_cron_entry' do\n  minute '0'\n  hour '8'\n  weekday\
      \ '6'\n  mailto 'admin@example.com'\n  action :create\nend"
- example_heading: Run only in November
  text_blocks:
  - markdown: 'The following example shows a schedule that will run at 8:00 PM, every

      weekday (Monday through Friday), but only in November:'
  - code_block: "cron_d 'name_of_cron_entry' do\n  minute '0'\n  hour '20'\n  day\
      \ '*'\n  month '11'\n  weekday '1-5'\n  action :create\nend"

---
