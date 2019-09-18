``` ruby
machine_image 'web_image' do
  recipe 'apache2'
end

machine 'web_machine' do
 from_image 'web_image'
end
```