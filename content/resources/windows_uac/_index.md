---
title: windows_uac resource
resource: windows_uac
draft: false
aliases:
- /resource_windows_uac.html
menu:
  docs:
    title: windows_uac
    identifier: chef_infra/cookbook_reference/resources/windows_uac windows_uac
    parent: chef_infra/cookbook_reference/resources
    weight: 1440
resource_reference: true
robots: null
resource_description_list:
- markdown: 'The **windows_uac** resource configures UAC on Windows hosts by setting registry keys at ''HKEY_LOCAL_MACHINESOFTWAREMicrosoftWindowsCurrentVersionPoliciesSystem'''
resource_new_in: '15.0'
handler_types: false
syntax_description: "The windows_uac resource has the following syntax:\n\n``` ruby\n\
  windows_uac 'name' do\n  consent_behavior_admins       Symbol # default value: :prompt_for_consent_non_windows_binaries\n\
  \  consent_behavior_users        Symbol # default value: :prompt_for_creds\n  detect_installers\
  \             true, false\n  enable_uac                    true, false # default\
  \ value: true\n  prompt_on_secure_desktop      true, false # default value: true\n\
  \  require_signed_binaries       true, false # default value: false\n  action  \
  \                      Symbol # defaults to :configure if not specified\nend\n```"
syntax_code_block: null
syntax_properties_list:
- '`windows_uac` is the resource.'
- '`name` is the name given to the resource block.'
- '`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state.'
- '`consent_behavior_admins`, `consent_behavior_users`, `detect_installers`, `enable_uac`,
  `prompt_on_secure_desktop`, and `require_signed_binaries` are the properties available
  to this resource.'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: false
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :configure:
    markdown: Configures UAC by setting registry keys at HKEY_LOCAL_MACHINESOFTWAREMicrosoftWindowsCurrentVersionPoliciesSystem.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: consent_behavior_admins
  ruby_type: Symbol
  required: false
  default_value: :prompt_for_consent_non_windows_binaries
  new_in: null
  description_list:
  - markdown: 'Behavior of the elevation prompt for administrators in Admin

      Approval Mode. Sets

      HKEY_LOCAL_MACHINESOFTWAREMicrosoftWindowsCurrentVersionPoliciesSystemEnableLUAConsentPromptBehaviorAdmin.'
- property: consent_behavior_users
  ruby_type: Symbol
  required: false
  default_value: :prompt_for_creds
  new_in: null
  allowed_values: :auto_deny, :secure_prompt_for_creds, :prompt_for_creds
  description_list:
  - markdown: 'Behavior of the elevation prompt for standard users. Sets HKEY_LOCAL_MACHINESOFTWAREMicrosoftWindowsCurrentVersionPoliciesSystemEnableLUAConsentPromptBehaviorUser.'
- property: detect_installers
  ruby_type: true, false
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'Detect application installations and prompt for elevation. Sets

      HKEY_LOCAL_MACHINESOFTWAREMicrosoftWindowsCurrentVersionPoliciesSystemEnableLUAEnableInstallerDetection.'
- property: enable_uac
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: 'Enable or disable UAC Admin Approval Mode. If this is changed a

      system restart is required. Sets

      HKEY_LOCAL_MACHINESOFTWAREMicrosoftWindowsCurrentVersionPoliciesSystemEnableLUA.'
- property: prompt_on_secure_desktop
  ruby_type: true, false
  required: false
  default_value: 'true'
  new_in: null
  description_list:
  - markdown: 'Switch to the secure desktop when prompting for elevation. Sets

      HKEY_LOCAL_MACHINESOFTWAREMicrosoftWindowsCurrentVersionPoliciesSystemEnableLUAPromptOnSecureDesktop.'
- property: require_signed_binaries
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'Only elevate executables that are signed and validated. Sets

      HKEY_LOCAL_MACHINESOFTWAREMicrosoftWindowsCurrentVersionPoliciesSystemEnableLUAValidateAdminCodeSignatures.'
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
- example_heading: Disable UAC prompts for the admin
  text_blocks:
  - code_block: "windows_uac 'Disable UAC prompts for the admin' do\n  enable_uac\
      \ true\n  prompt_on_secure_desktop false\n  consent_behavior_admins :no_prompt\n\
      end"
- example_heading: Disable UAC entirely
  text_blocks:
  - code_block: "windows_uac 'Disable UAC entirely' do\n  enable_uac false\nend"

---
