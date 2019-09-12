``` ruby
mount '/export/www' do
  device 'nas1prod:/export/web_sites'
  fstype 'nfs'
  options 'rw'
end
```