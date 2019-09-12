The following example shows how to use variables within a Ruby block to
set environment variables using rbenv.

``` ruby
node.override[:rbenv][:root] = rbenv_root
node.override[:ruby_build][:bin_path] = rbenv_binary_path

ruby_block 'initialize' do
  block do
    ENV['RBENV_ROOT'] = node[:rbenv][:root]
    ENV['PATH'] = "#{node[:rbenv][:root]}/bin:#{node[:ruby_build][:bin_path]}:#{ENV['PATH']}"
  end
end
```