The following example shows a series of fatal `Chef::Log` entries:

```ruby
unless node['splunk']['upgrade_enabled']
  Chef::Log.fatal('The chef-splunk::upgrade recipe was added to the node,')
  Chef::Log.fatal('but the attribute `node["splunk"]["upgrade_enabled"]` wasn\'t set.')
  Chef::Log.fatal('I am bailing here so this node doesn\'t upgrade.')
  raise
end

service 'splunk_stop' do
  service_name 'splunk'
  supports status: true
  action :stop
end

if node['splunk']['is_server']
  splunk_package = 'splunk'
  url_type = 'server'
else
  splunk_package = 'splunkforwarder'
  url_type = 'forwarder'
end

splunk_installer splunk_package do
  url node['splunk']['upgrade']["#{url_type}_url"]
end

if node['splunk']['accept_license']
  execute 'splunk-unattended-upgrade' do
    command "#{splunk_cmd} start --accept-license --answer-yes"
  end
else
  Chef::Log.fatal('You didn\'t accept the license (set node["splunk"]["accept_license"] to true)')
  Chef::Log.fatal('Splunk is stopped and can\'t be restarted until the license is accepted!')
  raise
end
```
