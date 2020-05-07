---
resource_reference: true
properties_shortcode:
resources_common_guards: true
resources_common_notification: true
resources_common_properties: true
title: windows_user_privilege resource
resource: windows_user_privilege
aliases:
- "/resource_windows_user_privilege.html"
menu:
  infra:
    title: windows_user_privilege
    identifier: chef_infra/cookbook_reference/resources/windows_user_privilege windows_user_privilege
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: "The windows_user_privilege resource allows to add and set principal (User/Group)
    to the specified privilege. \n Ref: https://docs.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/user-rights-assignment"
resource_new_in: '16.0'
syntax_full_code_block: |-
  windows_user_privilege 'name' do
    principal      String # default value: 'name' unless specified
    privilege      Array, String
    users          Array
    action         Symbol # defaults to :add if not specified
  end
syntax_properties_list:
syntax_full_properties_list:
- "`windows_user_privilege` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`principal`, `privilege`, and `users` are the properties available to this resource."
actions_list:
  :add:
    markdown: Add a user privilege
  :nothing:
    shortcode: resources_common_actions_nothing.md
  :remove:
    markdown: Remove a user privilege
  :set:
    markdown: This will remove any user not listed in the `users` field and only allow what is listed what was provided to remain.
properties_list:
- property: principal
  ruby_type: String
  required: false
  default_value: The resource block's name
  description_list:
  - markdown: An optional property to add the user to the given privilege. Use only
      with add and remove action.
- property: privilege
  ruby_type: Array, String
  required: true
  description_list:
  - markdown: Privilege to set for users.
- property: users
  ruby_type: Array
  required: false
  description_list:
  - markdown: An optional property to set the privilege for given users. Use only
      with set action.
examples: |
  **Enforce only Builtin Administrators Group and Authenticated Users allowed for the SeNetworkLogonRight Privilege**:

  ```ruby
  windows_user_privilege 'Netowrk Logon Rights' do
    privilege      'SeNetworkLogonRight'
    users          ['BUILTIN\Administrators', 'NT AUTHORITY\Authenticated Users']
    action         :set
  end
  ```

  **Add Builtin Guests and Local Accounts to the SeDenyRemoteInteractiveLogonRight Privilege**:

  ```ruby
  windows_user_privilege 'Remote interactive logon' do
    privilege      'SeDenyRemoteInteractiveLogonRight'
    users          ['Builtin\Guests', 'NT AUTHORITY\Local Account']
    action         :add
  end
  ```

  **Enforce only Builtin Guests amd Adminiistrator Gruops allowed for SeCreatePageFile Privilege**:

  ```ruby
  windows_user_privilege 'Create Pagefile' do
    privilege      'SeCreatePagefilePrivilege'
    users          ['BUILTIN\Guests', 'BUILTIN\Administrators']
    action         :set
  end
  ```
---
