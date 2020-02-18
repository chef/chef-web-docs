---
title: windows_task resource
resource: windows_task
draft: false
aliases:
- /resource_windows_task.html
menu:
  docs:
    title: windows_task
    identifier: chef_infra/cookbook_reference/resources/resource_windows_task.md windows_task
    parent: chef_infra/cookbook_reference/resources
    weight: 1300
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **windows_task** resource to create, delete or run a Windows

    scheduled task.'
- note:
    markdown: 'The `windows_task` resource that was provided as part of the `windows`

      cookbook included the `:change` action, which has been removed from

      `windows_task` in Chef client. The `:create` action can be used instead

      to update an existing task.'
resource_new_in: '13.0'
handler_types: false
syntax_description: "The windows_task resource has the following syntax:\n\n``` ruby\n\
  windows_task 'name' do\n  command                             String\n  cwd    \
  \                             String\n  day                                 String,\
  \ Integer\n  description                         String\n  disallow_start_if_on_batteries\
  \      true, false # default value: false\n  execution_time_limit              \
  \  String, Integer # default value: \"PT72H\"\n  force                         \
  \      true, false # default value: false\n  frequency                         \
  \  Symbol\n  frequency_modifier                  Integer, String # default value:\
  \ 1\n  idle_time                           Integer\n  interactive_enabled      \
  \           true, false # default value: false\n  minutes_duration             \
  \       String, Integer\n  minutes_interval                    String, Integer\n\
  \  months                              String\n  password                      \
  \      String\n  priority                            Integer # default value: 7\n\
  \  random_delay                        String, Integer\n  run_level            \
  \               Symbol # default value: :limited\n  start_day                  \
  \         String\n  start_time                          String\n  start_when_available\
  \                true, false # default value: false\n  stop_if_going_on_batteries\
  \          true, false # default value: false\n  task_name                     \
  \      String # default value: 'name' unless specified\n  user                 \
  \               String # default value: The localized SYSTEM user for the node.\n\
  \  action                              Symbol # defaults to :create if not specified\n\
  end\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_task` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`command`, `cwd`, `day`, `description`, `disallow_start_if_on_batteries`, `execution_time_limit`,
  `force`, `frequency`, `frequency_modifier`, `idle_time`, `interactive_enabled`,
  `minutes_duration`, `minutes_interval`, `months`, `password`, `priority`, `random_delay`,
  `run_level`, `start_day`, `start_time`, `start_when_available`, `stop_if_going_on_batteries`,
  `task_name`, and `user` are the properties available to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Creates a task, or updates an existing task if any property has changed.
  :delete:
    markdown: Deletes a task.
  :disable:
    markdown: Disables a task.
  :enable:
    markdown: Enables a task.
  :end:
    markdown: Ends a task.
  :run:
    markdown: Runs a task.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: command
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The command to be executed by the windows scheduled task.
- property: cwd
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The directory the task will be run from.
- property: day
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: "The day(s) on which the task runs.\n\n-   Use with frequency `:monthly`\
      \ and `:weekly` tasks,\n-   Valid values with frequency `:weekly` are `MON-SUN`\
      \ or `\\*`.\n-   Valid values with frequency `:monthly` are `1-31` or `MON`\
      \ to\n    `SUN` and `LASTDAY`.\n    -   Use `MON-SUN` or `LASTDAY` if you are\
      \ setting\n        `frequency_modifier` as `\"FIRST, SECOND, THIRD etc.\"` else\n\
      \        use `1-31`.\n    -   Multiple days should be comma separated. e.g `\"\
      1, 2, 3\"` or\n        `\"MON, WEN, FRI\"`."
- property: description
  ruby_type: String
  required: false
  default_value: null
  new_in: '14.7'
  description_list:
  - markdown: The task description.
- property: disallow_start_if_on_batteries
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: '14.4'
  description_list:
  - markdown: 'Disallow start of the task if the system is running on battery

      power.'
- property: execution_time_limit
  ruby_type: String, Integer
  required: false
  default_value: '"PT72H"'
  new_in: null
  description_list:
  - markdown: '(72

      hours)


      The maximum time (in seconds) the task will run.'
- property: force
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: When used with create, will update the task.
- property: frequency
  ruby_type: Symbol
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: "-   Frequency with which to run the task.\n-   This is a mandatory\
      \ property in Chef 14.1\n-   Valid values: `:minute`, `:hourly`, `:daily`, `:weekly`,\n\
      \    `:monthly`, `:none`, `:once`, `:on_logon`, `:onstart`,\n    `:on_idle`.\n\
      -   The `:once` value requires the `start_time` property.\n-   The `:none` frequency\
      \ requires Chef 13.6 or later."
- property: frequency_modifier
  ruby_type: Integer, String
  required: false
  default_value: '1'
  new_in: null
  description_list:
  - markdown: "-   For frequency `:minute` valid values are 1 to 1439\n-   For frequency\
      \ `:hourly` valid values are 1 to 23\n-   For frequency `:daily` valid values\
      \ are 1 to 365\n-   For frequency `:weekly` valid values are 1 to 52\n-   \n\
      \n    For frequency `:monthly` valid values are `('FIRST', 'SECOND', 'THIRD',\
      \ 'FOURTH', 'LAST')` OR `1-12`.\n\n    :   -   e.g. If user want to run the\
      \ task on\n            `second week of the month` use `frequency_modifier`\n\
      \            value as `SECOND`. Multiple values for weeks of the\n         \
      \   month should be comma separated e.g.\n            `\"FIRST, THIRD, LAST\"\
      `.\n        -   To run task every (n) months user values '1-12'."
- property: idle_time
  ruby_type: Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'For `:on_idle` frequency, the time (in minutes) without user

      activity that must pass to trigger the task, from `1` - `999`.'
- property: interactive_enabled
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Allow task to run interactively or non-interactively. Requires user

      and password to also be set.'
- property: minutes_duration
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
  description_list: []
- property: minutes_interval
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
  description_list: []
- property: months
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'The Months of the year on which the task runs, such as: `"JAN, FEB"`

      or `"\*"`. Multiple months should be comma delimited. e.g.

      `"Jan, Feb, Mar, Dec"`'
- property: password
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: "The user\u2019s password. The user property must be set if using this\n\
      property."
- property: priority
  ruby_type: Integer
  required: false
  default_value: '7'
  new_in: null
  description_list:
  - markdown: Use to set Priority Levels range from 0 to 10.
- property: random_delay
  ruby_type: String, Integer
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Delays the task up to a given time (in seconds).
- property: run_level
  ruby_type: Symbol
  required: false
  default_value: :limited
  new_in: null
  description_list:
  - markdown: Run with `:limited` or `:highest` privileges.
- property: start_day
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Specifies the first date on which the task runs in **MM/DD/YYYY**

      format.'
- property: start_time
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: Specifies the start time to run the task, in **HH:mm** format.
- property: start_when_available
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: '15.0'
  description_list:
  - markdown: To start the task at any time after its scheduled time has passed.
- property: stop_if_going_on_batteries
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: '14.4'
  description_list:
  - markdown: Scheduled task option when system is switching on battery.
- property: task_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  new_in: null
  description_list:
  - markdown: 'An optional property to set the task name if it differs from the

      resource block''s name. Example: ''Task Name'' or ''/Task Name'''
- property: user
  ruby_type: String
  required: false
  default_value: '"The localized SYSTEM user for the node."'
  new_in: null
  description_list:
  - markdown: The user to run the task as.
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
- example_heading: 'Create a scheduled task to run every 15 minutes as the Administrator

    user'
  text_blocks:
  - code_block: "windows_task 'chef-client' do\n  user 'Administrator'\n  password\
      \ 'password'\n  command 'chef-client'\n  run_level :highest\n  frequency :minute\n\
      \  frequency_modifier 15\nend"
- example_heading: Create a scheduled task to run every 2 days
  text_blocks:
  - code_block: "windows_task 'chef-client' do\n  command 'chef-client'\n  run_level\
      \ :highest\n  frequency :daily\n  frequency_modifier 2\nend"
- example_heading: Create a scheduled task to run on specific days of the week
  text_blocks:
  - code_block: "windows_task 'chef-client' do\n  command 'chef-client'\n  run_level\
      \ :highest\n  frequency :weekly\n  day 'Mon, Thu'\nend"
- example_heading: Create a scheduled task to run only once
  text_blocks:
  - code_block: "windows_task 'chef-client' do\n  command 'chef-client'\n  run_level\
      \ :highest\n  frequency :once\n  start_time \"16:10\"\nend"
- example_heading: 'Create a scheduled task to run on current day every 3 weeks and
    delay

    upto 1 min'
  text_blocks:
  - code_block: "windows_task 'chef-client' do\n  command 'chef-client'\n  run_level\
      \ :highest\n  frequency :weekly\n  frequency_modifier 3\n  random_delay '60'\n\
      end"
- example_heading: Create a scheduled task to run weekly starting on Dec 28th 2018
  text_blocks:
  - code_block: "windows_task 'chef-client 8' do\n  command 'chef-client'\n  run_level\
      \ :highest\n  frequency :weekly\n  start_day '12/28/2018'\nend"
- example_heading: Create a scheduled task to run every Monday, Friday every 2 weeks
  text_blocks:
  - code_block: "windows_task 'chef-client' do\n  command 'chef-client'\n  run_level\
      \ :highest\n  frequency :weekly\n  frequency_modifier 2\n  day 'Mon, Fri'\n\
      end"
- example_heading: 'Create a scheduled task to run when computer is idle with idle

    duration 20 min'
  text_blocks:
  - code_block: "windows_task 'chef-client' do\n  command 'chef-client'\n  run_level\
      \ :highest\n  frequency :on_idle\n  idle_time 20\nend"
  - markdown: '**Delete a task named "old task"**'
  - code_block: "windows_task 'old task' do\n  action :delete\nend"
  - markdown: '**Enable a task named "chef-client"**'
  - code_block: "windows_task 'chef-client' do\n  action :enable\nend"
  - markdown: '**Disable a task named "ProgramDataUpdater" with TaskPath

      "\\Microsoft\\Windows\\Application Experience\\ProgramDataUpdater"**'
  - code_block: "windows_task '\\Microsoft\\Windows\\Application Experience\\ProgramDataUpdater'\
      \ do\n  action :disable\nend"

---
