``` ruby
service 'apache' do
  supports :restart => true, :reload => true
  action :enable
end
```