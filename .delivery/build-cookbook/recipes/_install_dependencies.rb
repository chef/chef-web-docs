#
#
#

execute 'nokogiri config' do
  command "bundle config build.nokogiri --use-system-libraries"
  cwd node['delivery_builder']['repo']
  environment({
    "PATH" => '/opt/chefdk/embedded/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games'
  })
  user node['delivery_builder']['build_user']
end

execute 'install deps' do
  command "bundle install --deployment"
  cwd node['delivery_builder']['repo']
  environment({
    "PATH" => '/opt/chefdk/embedded/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games',
    "LDFLAGS" => '-L/opt/chefdk/embedded/lib -lxml2 -L/opt/chefdk/embedded/lib -lz -L/opt/chefdk/embedded/lib -liconv -lm -ldl',
    "CFLAGS" => '-I/opt/chefdk/embedded/include/libxml2 -I/opt/chefdk/embedded/include'
  })
  user node['delivery_builder']['build_user']
end
