The following example shows how to use the **remote_directory**
resource and the **chef_handler** resource to reboot a handler named
`WindowsRebootHandler`:

``` ruby
# the following code sample comes from the
# ``reboot_handler`` recipe in the ``windows`` cookbook:
# https://github.com/chef-cookbooks/windows

remote_directory node['chef_handler']['handler_path'] do
  source 'handlers'
  recursive true
  action :create
end

chef_handler 'WindowsRebootHandler' do
  source "#{node['chef_handler']['handler_path']}/windows_reboot_handler.rb"
  arguments node['windows']['allow_pending_reboots']
  supports :report => true, :exception => false
  action :enable
end
```