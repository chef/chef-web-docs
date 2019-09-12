The following example shows how to run `bundle install` from a Chef
Infra Client run as a specific user. This will put the gem into the path
of the user (`vagrant`) instead of the root user (under which the Chef
Infra Client runs):

``` ruby
execute '/opt/chefdk/embedded/bin/bundle install' do
  cwd node['chef_workstation']['bundler_path']
  user node['chef_workstation']['user']
  environment ({
    'HOME' => "/home/#{node['chef_workstation']['user']}",
    'USER' => node['chef_workstation']['user']
  })
  not_if 'bundle check'
end
```