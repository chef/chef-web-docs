include_recipe 'chef-sugar::default'

Chef_Delivery::ClientHelper.enter_client_mode_as_delivery

slack_creds = encrypted_data_bag_item_for_environment('cia-creds','slack')

if ['union', 'rehearsal', 'delivered'].include?(node['delivery']['change']['stage'])
  slack_channels = slack_creds['channels'].push('#operations').push('#chef-docs-bot')
else
  slack_channels = slack_creds['channels'].push('#chef-docs-bot')
end

chef_handler "BuildCookbook::SlackHandler" do
  source File.join(node["chef_handler"]["handler_path"], 'slack.rb')
  arguments [
    :webhook_url => slack_creds['webhook_url'],
    :channels  => slack_channels,
    :username => slack_creds['username']
  ]
  supports :exception => true
  sensitive true
  action :enable
end

Chef_Delivery::ClientHelper.leave_client_mode_as_delivery
