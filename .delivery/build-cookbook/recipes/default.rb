include_recipe 'delivery-truck::default'
include_recipe 'cia_infra::aws_prereq'
include_recipe 'python::default'

execute 'pip install -r requirements.txt' do
  cwd node['delivery']['workspace']['repo']
end
