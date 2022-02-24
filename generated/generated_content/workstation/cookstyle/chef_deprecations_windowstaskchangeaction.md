+++
title = "WindowsTaskChangeAction"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `WindowsTaskChangeAction`

The full name of the cop is: `Chef/Deprecations/WindowsTaskChangeAction`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | Yes | 13.0+ |

The :change action in the windows_task resource was removed when windows_task was added to Chef Infra Client 13+
The default action of :create should can now be used to create an update tasks.

## Examples


#### incorrect

```ruby
windows_task 'chef ad-join leave start time' do
  task_name 'chef ad-join leave'
  start_day '06/09/2016'
  start_time '01:00'
  action [:change, :create]
end
```

#### correct

```ruby
windows_task 'chef ad-join leave start time' do
  task_name 'chef ad-join leave'
  start_day '06/09/2016'
  start_time '01:00'
  action :create
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
<td style="text-align:center">5.6.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
