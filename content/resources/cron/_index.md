---
title: cron resource
resource: cron
draft: false
aliases:
- /resource_cron.html
menu:
  docs:
    title: cron
    identifier: chef_infra/cookbook_reference/resources/cron cron
    parent: chef_infra/cookbook_reference/resources
    weight: 380
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **cron** resource to manage cron entries for time-based job

    scheduling.'
- warning:
    markdown: 'The **cron** resource should only be used to modify an entry in a

      crontab file. The `cron_d` resource directly manages cron.d files. This

      resource ships in Chef 14.4 or later and can also be found in the

      [cron](https://github.com/chef-cookbooks/cron) cookbook) for previous

      chef-client releases.'
resource_new_in: null
handler_types: false
syntax_description: "A **cron** resource block manages cron entries. For example,\
  \ to get a\nweekly cookbook report from the Chef Supermarket:\n\n``` ruby\ncron\
  \ 'cookbooks_report' do\n  action :create\n  minute '0'\n  hour '0'\n  weekday '1'\n\
  \  user 'getchef'\n  mailto 'sysadmin@example.com'\n  home '/srv/supermarket/shared/system'\n\
  \  command %W{\n    cd /srv/supermarket/current &&\n    env RUBYLIB=\"/srv/supermarket/current/lib\"\
  \n    RAILS_ASSET_ID=`git rev-parse HEAD` RAILS_ENV=\"#{rails_env}\"\n    bundle\
  \ exec rake cookbooks_report\n  }.join(' ')\nend\n```"
syntax_code_block: null
syntax_properties_list: null
syntax_full_code_block: "cron 'name' do\n  command          String\n  day\n  environment\
  \      Hash\n  home             String\n  hour\n  mailto           String\n  minute\n\
  \  month\n  path             String\n  shell            String\n  time         \
  \    Symbol\n  time_out         Hash\n  user             String # default value:\
  \ \"root\"\n  weekday          \n  action           Symbol # defaults to :create\
  \ if not specified\nend"
syntax_full_properties_list:
- '`cron` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`command`, `day`, `environment`, `home`, `hour`, `mailto`, `minute`, `month`, `path`,
  `shell`, `time`, `time_out`, `user`, and `weekday` are the properties available
  to this resource.'
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Default. Create an entry in a cron table file (crontab). If an entry
      already exists (but does not match), update that entry to match.
  :delete:
    markdown: Delete an entry from a cron table file (crontab).
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: command
  ruby_type: String
  required: false
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
- property: day
  ruby_type: String
  required: false
  default_value: '*'
  new_in: null
  description_list:
  - markdown: The day of month at which the cron entry should run (1 - 31).
- property: environment
  ruby_type: Hash
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A Hash of environment variables in the form of

      `({''ENV_VARIABLE'' => ''VALUE''})`. (These variables must exist for a

      command to be run successfully.)'
- property: home
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Set the `HOME` environment variable.
- property: hour
  ruby_type: String
  required: false
  default_value: '*'
  new_in: null
  description_list:
  - markdown: The hour at which the cron entry is to run (0 - 23).
- property: mailto
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Set the `MAILTO` environment variable.
- property: minute
  ruby_type: String
  required: false
  default_value: '*'
  new_in: null
  description_list:
  - markdown: The minute at which the cron entry should run (0 - 59).
- property: month
  ruby_type: String
  required: false
  default_value: '*'
  new_in: null
  description_list:
  - markdown: The month in the year on which a cron entry is to run (1 - 12).
- property: path
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Set the `PATH` environment variable.
- property: shell
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Set the `SHELL` environment variable.
- property: time
  ruby_type: Symbol
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'A time interval. Possible values: `:annually`, `:daily`, `:hourly`,

      `:midnight`, `:monthly`, `:reboot`, `:weekly`, or `:yearly`.'
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
  - markdown: 'The name of the user that runs the command. If the user property is

      changed, the original user for the crontab program continues to run

      until that crontab program is deleted. This property is not

      applicable on the AIX platform.'
- property: weekday
  ruby_type: String
  required: false
  default_value: '*'
  new_in: null
  description_list:
  - markdown: 'The day of the week on which this entry is to run (0 - 6), where

      Sunday = 0.'
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
  - code_block: "cron 'noop' do\n  hour '5'\n  minute '0'\n  command '/bin/true'\n\
      end"
- example_heading: Run an entry if a folder exists
  text_blocks:
  - code_block: "cron 'ganglia_tomcat_thread_max' do\n  command \"/usr/bin/gmetric\n\
      \    -n 'tomcat threads max'\n    -t uint32\n    -v '/usr/local/bin/tomcat-stat\n\
      \    --thread-max'\"\n  only_if do File.exist?('/home/jboss') end\nend"
- example_heading: Run every Saturday, 8:00 AM
  text_blocks:
  - markdown: 'The following example shows a schedule that will run every hour at
      8:00

      each Saturday morning, and will then send an email to

      "<admin@example.com>" after each run.'
  - code_block: "cron 'name_of_cron_entry' do\n  minute '0'\n  hour '8'\n  weekday\
      \ '6'\n  mailto 'admin@example.com'\n  action :create\nend"
- example_heading: Run only in November
  text_blocks:
  - markdown: 'The following example shows a schedule that will run at 8:00 PM, every

      weekday (Monday through Friday), but only in November:'
  - code_block: "cron 'name_of_cron_entry' do\n  minute '0'\n  hour '20'\n  day '*'\n\
      \  month '11'\n  weekday '1-5'\n  action :create\nend"

---
