``` ruby
execute 'slapadd' do
  command 'slapadd < /tmp/something.ldif'
  creates '/var/lib/slapd/uid.bdb'
  action :nothing
end

template '/tmp/something.ldif' do
  source 'something.ldif'
  notifies :run, 'execute[slapadd]', :immediately
end
```