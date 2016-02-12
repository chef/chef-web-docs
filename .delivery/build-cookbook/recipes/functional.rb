
include_recipe 'build-cookbook::_handler'
include_recipe 'chef-sugar::default'

Chef_Delivery::ClientHelper.enter_client_mode_as_delivery

slack_creds = encrypted_data_bag_item_for_environment('cia-creds','slack')

if ['union', 'rehearsal', 'delivered'].include?(node['delivery']['change']['stage'])
  slack_channels = slack_creds['channels'].push('#operations').push('#chef-docs-bot')
else
  slack_channels = slack_creds['channels'].push('#chef-docs-bot')
end

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

case node['delivery']['change']['stage']
when 'acceptance'
  chef_slack_notify 'Notify Slack' do
    channels slack_channels
    webhook_url slack_creds['webhook_url']
    username slack_creds['username']
    message "*[#{node['delivery']['change']['project']}] (#{node['delivery']['change']['stage']}:#{node['delivery']['change']['phase']})* <a href=\"https://#{fqdn}\">https://#{fqdn}</a> is now ready for delivery! Please visit <a href=\"#{change_url}\">Deliver it!</a>"
    sensitive true
  end

when 'delivered'
  chef_slack_notify 'Notify Slack' do
    channels slack_channels
    webhook_url slack_creds['webhook_url']
    username slack_creds['username']
    message "*[#{node['delivery']['change']['project']}] (#{node['delivery']['change']['stage']}:#{node['delivery']['change']['phase']})* <a href=\"https://#{fqdn}\">https://#{fqdn}</a> is now Delivered!"
    sensitive true
  end
end
