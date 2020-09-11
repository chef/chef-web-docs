---
resource_reference: true
properties_shortcode:
resources_common_guards: true
resources_common_notification: true
resources_common_properties: true
title: osx_profile resource
resource: osx_profile
aliases:
- "/resource_osx_profile.html"
menu:
  infra:
    title: osx_profile
    identifier: chef_infra/cookbook_reference/resources/osx_profile osx_profile
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: 'Use the **osx_profile** resource to manage configuration profiles

    (`.mobileconfig` files) on the macOS platform. The **osx_profile**

    resource installs profiles by using the `uuidgen` library to generate a

    unique `ProfileUUID`, and then using the `profiles` command to install

    the profile on the system.'
resource_new_in: '12.7'
syntax_full_code_block: |-
  osx_profile 'name' do
    identifier        String
    profile           String, Hash
    profile_name      String # default value: 'name' unless specified
    action            Symbol # defaults to :install if not specified
  end
syntax_properties_list:
syntax_full_properties_list:
- "`osx_profile` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`identifier`, `profile`, and `profile_name` are the properties available to this
  resource."
actions_list:
  :install:
    markdown: Default. Install the specified configuration profile.
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :remove:
    markdown: Remove the specified configuration profile.
properties_list:
- property: identifier
  ruby_type: String
  required: false
  description_list:
  - markdown: 'Use to specify the identifier for the profile, such as

      `com.company.screensaver`.'
- property: path
  ruby_type: String
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: The path to write the profile to disk before loading it.
- property: profile
  ruby_type: String, Hash
  required: false
  description_list:
  - markdown: 'Use to specify a profile. This may be the name of a profile

      contained in a cookbook or a Hash that contains the contents of the

      profile.'
- property: profile_name
  ruby_type: String
  required: false
  default_value: The resource block's name
  description_list:
  - markdown: Use to specify the name of the profile, if different from the name of
      the resource block.
examples: "
  One liner to install profile from cookbook file\n\n  The `profiles`\
  \ command will be used to install the specified\n  configuration profile.\n\n  ```\
  \ ruby\n  osx_profile 'com.company.screensaver.mobileconfig'\n  ```\n\n  Install\
  \ profile from cookbook file\n\n  The `profiles` command will be used to install\
  \ the specified\n  configuration profile. It can be in sub-directory within a cookbook.\n\
  \n  ``` ruby\n  osx_profile 'Install screensaver profile' do\n    profile 'screensaver/com.company.screensaver.mobileconfig'\n\
  \  end\n  ```\n\n  Install profile from a hash\n\n  The `profiles` command will\
  \ be used to install the configuration\n  profile, which is provided as a hash.\n\
  \n  ``` ruby\n  profile_hash = {\n    'PayloadIdentifier' => 'com.company.screensaver',\n\
  \    'PayloadRemovalDisallowed' => false,\n    'PayloadScope' => 'System',\n   \
  \ 'PayloadType' => 'Configuration',\n    'PayloadUUID' => '1781fbec-3325-565f-9022-8aa28135c3cc',\n\
  \    'PayloadOrganization' => 'Chef',\n    'PayloadVersion' => 1,\n    'PayloadDisplayName'\
  \ => 'Screensaver Settings',\n    'PayloadContent'=> [\n      {\n        'PayloadType'\
  \ => 'com.apple.ManagedClient.preferences',\n        'PayloadVersion' => 1,\n  \
  \      'PayloadIdentifier' => 'com.company.screensaver',\n        'PayloadUUID'\
  \ => '73fc30e0-1e57-0131-c32d-000c2944c108',\n        'PayloadEnabled' => true,\n\
  \        'PayloadDisplayName' => 'com.apple.screensaver',\n        'PayloadContent'\
  \ => {\n          'com.apple.screensaver' => {\n            'Forced' => [\n    \
  \          {\n                'mcx_preference_settings' => {\n                 \
  \ 'idleTime' => 0,\n                }\n              }\n            ]\n        \
  \  }\n        }\n      }\n    ]\n  }\n\n  osx_profile 'Install screensaver profile'\
  \ do\n    profile profile_hash\n  end\n  ```\n\n  Remove profile using identifier\
  \ in resource name\n\n  The `profiles` command will be used to remove the configuration\
  \ profile\n  specified by the provided `identifier` property.\n\n  ``` ruby\n  osx_profile\
  \ 'com.company.screensaver' do\n    action :remove\n  end\n  ```\n\n  Remove profile\
  \ by identifier and user friendly resource name\n\n  The `profiles` command will\
  \ be used to remove the configuration profile\n  specified by the provided `identifier`\
  \ property.\n\n  ``` ruby\n  osx_profile 'Remove screensaver profile' do\n    identifier\
  \ 'com.company.screensaver'\n    action :remove\n  end\n  ```\n"

---
