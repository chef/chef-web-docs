+++
title = "WindowsRegistryUAC"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `WindowsRegistryUAC`

The full name of the cop is: `Chef/Modernize/WindowsRegistryUAC`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 15.0+ |

Chef Infra Client 15.0 and later includes a windows_uac resource that should be used to set Windows UAC values instead of setting registry keys directly.

## Examples


#### incorrect

```ruby
registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' do
  values [{ name: 'EnableLUA', type: :dword, data: 0 },
          { name: 'PromptOnSecureDesktop', type: :dword, data: 0 },
          { name: 'ConsentPromptBehaviorAdmin', type: :dword, data: 0 },
         ]
  action :create
end
```

#### correct

```ruby
windows_uac 'Set Windows UAC settings' do
  enable_uac false
  prompt_on_secure_desktop true
  consent_behavior_admins :no_prompt
end
```

## Configurable attributes

<table>
<tbody><tr>
<th>Name</th>
<th>Default value</th>
<th>Configurable values</th>
</tr>
<tr>
<td style="text-align:center">Version Added</td>
<td style="text-align:center">5.22.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
