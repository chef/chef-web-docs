cia_infra_static_site node['delivery']['change']['project'] do
  action :deploy
  quiet true
  redirect_file File.join(node['delivery']['workspace']['repo'], 'config', 'redirects.json')
end

cia_infra_cdn node['delivery']['change']['project'] do
  action [:deploy, :purge_all]
  host_name 'docs'
end
