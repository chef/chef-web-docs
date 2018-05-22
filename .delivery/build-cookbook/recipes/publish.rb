include_recipe 'delivery-truck::publish'

execute 'make clean' do
  cwd node['delivery']['workspace']['repo']
end

execute 'make docs' do
  cwd node['delivery']['workspace']['repo']
end

cia_delivery_publish_artifact node['delivery']['change']['project'] do
  build_path 'build'
end
