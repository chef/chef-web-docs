By default, notifications are `:delayed`, that's they're queued up as
they're triggered, and then executed at the end of a Chef Infra
Client run. To run an action immediately, use `:immediately`:

```ruby
template '/etc/nagios3/configures-nagios.conf' do
  # other parameters
  notifies :run, 'execute[test-nagios-config]', :immediately
end
```

and then Chef Infra Client would immediately run the following:

```ruby
execute 'test-nagios-config' do
  command 'nagios3 --verify-config'
  action :nothing
end
```
