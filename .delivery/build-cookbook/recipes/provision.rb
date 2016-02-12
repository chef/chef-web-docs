include_recipe 'build-cookbook::_handler'
include_recipe 'chef-sugar::default'
include_recipe 'delivery-truck::provision'

Chef_Delivery::ClientHelper.enter_client_mode_as_delivery

aws_creds = encrypted_data_bag_item_for_environment('cia-creds','chef-secure')
fastly_creds = encrypted_data_bag_item_for_environment('cia-creds','fastly')

site_name = 'docs'
domain_name = 'chef.io'

ENV['AWS_CONFIG_FILE'] = File.join(node['delivery']['workspace']['root'], 'aws_config')

require 'chef/provisioning/aws_driver'
with_driver 'aws'

if node['delivery']['change']['stage'] == 'delivered'
  bucket_name = node['delivery']['change']['project'].gsub(/_/, '-')
  fqdn = "#{site_name}.#{domain_name}"
else
  bucket_name = "#{node['delivery']['change']['project'].gsub(/_/, '-')}-#{node['delivery']['change']['stage']}"
  fqdn = "#{site_name}-#{node['delivery']['change']['stage']}.#{domain_name}"
end

aws_s3_bucket bucket_name do
  enable_website_hosting true
  website_options :index_document => {
    :suffix => "index.html"
  },
  :error_document => {
    :key => "page_not_found.html"
  }
end

### Fastly Setup
fastly_service = fastly_service fqdn do
  api_key fastly_creds['api_key']
  sensitive true
end

fastly_domain fqdn do
  api_key fastly_creds['api_key']
  service fastly_service.name
  sensitive true
  notifies :activate_latest, "fastly_service[#{fqdn}]", :delayed
end

fastly_backend bucket_name do
  api_key fastly_creds['api_key']
  service fastly_service.name
  address "#{bucket_name}.s3-website-us-east-1.amazonaws.com"
  port 80
  sensitive true
  notifies :activate_latest, "fastly_service[#{fqdn}]", :delayed
end

fastly_request_setting 'force_ssl' do
  api_key fastly_creds['api_key']
  service fastly_service.name
  force_ssl true
  default_host "#{bucket_name}.s3-website-us-east-1.amazonaws.com"
  sensitive true
  notifies :activate_latest, "fastly_service[#{fqdn}]", :delayed
end

fastly_gzip 'standard_gzip' do
  api_key fastly_creds['api_key']
  service fastly_service.name
  extensions 'css js html eot ico otf ttf json'
  sensitive true
  content_types [
    'text/html',
    'application/x-javascript',
    'text/css',
    'application/javascript',
    'text/javascript',
    'application/json',
    'application/vnd.ms-fontobject',
    'application/x-font-opentype',
    'application/x-font-truetype',
    'application/x-font-ttf',
    'application/xml',
    'font/eot',
    'font/opentype',
    'font/otf',
    'image/svg+xml',
    'image/vnd.microsoft.icon',
    'text/plain',
    'text/xml'
  ].join(" ")
  notifies :activate_latest, "fastly_service[#{fqdn}]", :delayed
end

fastly_s3_logging 's3_logging' do
  api_key fastly_creds['api_key']
  service fastly_service.name
  gzip_level 9
  access_key fastly_creds['logging']['s3']['access_key']
  secret_key fastly_creds['logging']['s3']['secret_key']
  bucket_name fastly_creds['logging']['s3']['bucket_name']
  path "/#{fqdn}"
  sensitive true
  notifies :activate_latest, "fastly_service[#{fqdn}]", :delayed
end

embargo = fastly_condition 'embargo' do
  api_key fastly_creds['api_key']
  service fastly_service.name
  type 'request'
  statement 'geoip.country_code == "CU" || geoip.country_code == "SD" || geoip.country_code == "SY" || geoip.country_code == "KP" || geoip.country_code == "IR"'
  sensitive true
  notifies :activate_latest, "fastly_service[#{fqdn}]", :delayed
end

fastly_response 'embargo' do
  api_key fastly_creds['api_key']
  service fastly_service.name
  request_condition embargo.name
  status 404
  sensitive true
  notifies :activate_latest, "fastly_service[#{fqdn}]", :delayed
end

fastly_header 'Strict-Transport-Security' do
  api_key fastly_creds['api_key']
  service fastly_service.name
  type 'response'
  dst 'http.Strict-Transport-Security'
  src '"max-age= 7776000; includeSubDomains"'
  sensitive true
  notifies :activate_latest, "fastly_service[#{fqdn}]", :delayed
end

fastly_header 'X-Frame-Options' do
  api_key fastly_creds['api_key']
  service fastly_service.name
  type 'response'
  dst 'http.X-Frame-Options'
  src '"SAMEORIGIN"'
  sensitive true
  notifies :activate_latest, "fastly_service[#{fqdn}]", :delayed
end

# Handle latest rev redirects
rewrites = JSON.parse(File.read(File.join(node['delivery']['workspace']['repo'], 'config', 'latest_product_mapping.json')))

rewrites.each_key do |rewrite|

  request_cond = fastly_condition "#{rewrite}_request" do
    api_key fastly_creds['api_key']
    service fastly_service.name
    type 'request'
    statement "req.url ~ \"^/#{rewrite}/\""
    sensitive true
    notifies :activate_latest, "fastly_service[#{fqdn}]", :delayed
  end

  response_cond = fastly_condition "#{rewrite}_response" do
    api_key fastly_creds['api_key']
    service fastly_service.name
    type 'response'
    statement "req.url ~ \"^/#{rewrite}/\" && resp.status == 302"
    sensitive true
    notifies :activate_latest, "fastly_service[#{fqdn}]", :delayed
  end

  fastly_response "#{rewrite}_302" do
    api_key fastly_creds['api_key']
    service fastly_service.name
    request_condition request_cond.name
    status 302
    sensitive true
    notifies :activate_latest, "fastly_service[#{fqdn}]", :delayed
  end

  fastly_header rewrite do
    api_key fastly_creds['api_key']
    service fastly_service.name
    type 'response'
    response_condition response_cond.name
    header_action 'set'
    dst 'http.location'
    src "\"https://#{fqdn}\" regsub(req.url,\"^/#{rewrite}/(.*)\", \"#{rewrites[rewrite]}/\\1\")"
  end

end

route53_record fqdn do
  name "#{fqdn}."
  value 'g.global-ssl.fastly.net'
  aws_access_key_id aws_creds['access_key_id']
  aws_secret_access_key aws_creds['secret_access_key']
  type 'CNAME'
  zone_id aws_creds['route53'][domain_name]
  sensitive true
end

Chef_Delivery::ClientHelper.leave_client_mode_as_delivery
