The following example shows how to install a lightweight JavaScript
framework into Vagrant:

``` ruby
execute "install q and zombiejs" do
  cwd "/home/vagrant"
  user "vagrant"
  environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
  command "npm install -g q zombie should mocha coffee-script"
  action :run
end
```