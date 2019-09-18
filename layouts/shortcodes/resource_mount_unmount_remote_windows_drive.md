``` ruby
mount 'T:' do
  action :umount
  device '\\\\hostname.example.com\\D$'
end
```