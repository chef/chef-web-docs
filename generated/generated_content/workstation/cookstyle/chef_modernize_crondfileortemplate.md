+++
title = "CronDFileOrTemplate"

+++

<!-- This content is automatically generated. See https://github.com/chef/chef-web-docs/blob/main/generated/README.md -->

The department is: `CronDFileOrTemplate`

The full name of the cop is: `Chef/Modernize/CronDFileOrTemplate`

| Enabled by default | Supports autocorrection | Target Chef Version |
| --- | --- | --- |
| Enabled | No | 14.4+ |

Use the cron_d resource that ships with Chef Infra Client 14.4+ instead of manually creating the file with template, file, or cookbook_file resources.

## Examples


#### incorrect

```ruby
template '/etc/cron.d/backup' do
  source 'cron_backup_job.erb'
  owner 'root'
  group 'root'
  mode '644'
end

cookbook_file '/etc/cron.d/backup' do
  owner 'root'
  group 'root'
  mode '644'
end

file '/etc/cron.d/backup' do
  content '*/30 * * * * backup /usr/local/bin/backup_script.sh'
  owner 'root'
  group 'root'
  mode '644'
end

file '/etc/cron.d/blogs' do
  action :delete
end

file "/etc/cron.d/#{job_name}" do
  action :delete
end

file File.join('/etc/cron.d', job) do
  action :delete
end

file 'delete old cron job' do
  path '/etc/cron.d/backup'
  action :delete
end

file 'delete old cron job' do
  path "/etc/cron.d/#{job}"
  action :delete
end

file 'delete old cron job' do
  path ::File.join('/etc/cron.d', job)
  action :delete
end
```

#### correct

```ruby
cron_d 'backup' do
  minute '1'
  hour '1'
  mailto 'sysadmins@example.com'
  command '/usr/local/bin/backup_script.sh'
end

cron_d 'blogs' do
  action :delete
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
<td style="text-align:center">6.13.0</td>
<td style="text-align:center">String</td>
</tr>
<tr><td style="text-align:center">Include</td>
<td style="text-align:center"><ul>
</ul>
</td>
<td style="text-align:center">Array</td>
</tr></tbody></table>
