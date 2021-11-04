```ruby
service 'apache' do
  action [ :enable, :start ]
  retries 3
  retry_delay 5
end
```
