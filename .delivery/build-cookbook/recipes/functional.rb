include_recipe 'chef-sugar::default'

load_delivery_chef_config

site_name = 'docs'
domain_name = 'chef.io'

if node['delivery']['change']['stage'] == 'delivered'
  bucket_name = node['delivery']['change']['project'].gsub(/_/, '-')
  fqdn = "#{site_name}.#{domain_name}"
else
  bucket_name = "#{node['delivery']['change']['project'].gsub(/_/, '-')}-#{node['delivery']['change']['stage']}"
  fqdn = "#{site_name}-#{node['delivery']['change']['stage']}.#{domain_name}"
end

# disabling as per cwebber because it is causing more harm than good
# execute 'run linkchecker' do
#   command "linkchecker -t 6 --recursion-level 3 --no-warnings --ignore-url 'package.url' --ignore-url 'glyphicons' https://#{fqdn}/"
#   cwd node['delivery_builder']['repo']
#   user node['delivery_builder']['build_user']
# end
