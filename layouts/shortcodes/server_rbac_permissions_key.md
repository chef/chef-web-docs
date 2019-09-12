Keys should have `DELETE`, `GRANT`, `READ` and `UPDATE` permissions.

Use the following code to set the correct permissions:

``` ruby
#!/usr/bin/env ruby
require 'chef/knife'

#previously knife.rb
Chef::Config.from_file(File.join(Chef::Knife.chef_config_dir, 'knife.rb'))

rest = Chef::ServerAPI.new(Chef::Config[:chef_server_url])

Chef::Node.list.each do |node|
  %w{read update delete grant}.each do |perm|
    ace = rest.get("nodes/#{node[0]}/_acl")[perm]
    ace['actors'] << node[0] unless ace['actors'].include?(node[0])
    rest.put("nodes/#{node[0]}/_acl/#{perm}", perm => ace)
    puts "Client \"#{node[0]}\" granted \"#{perm}\" access on node \"#{node[0]}\""
  end
end
```

Save it as a Ruby script---`chef_server_permissions.rb`, for
example---in the `.chef/scripts` directory located in the chef-repo, and
then run a knife command similar to:

``` bash
$ knife exec chef_server_permissions.rb
```