include_recipe 'delivery-truck::provision'

static_site = cia_infra_static_site node['delivery']['change']['project']

cia_infra_cdn node['delivery']['change']['project'] do
  host_name 'docs'
  endpoint static_site.fqdn
end
