When a **cookbook_file** resource and a **package** resource are both
called from within the same recipe, use the `flush_cache` attribute to
dump the in-memory Yum cache, and then use the repository immediately to
ensure that the correct package is installed:

``` ruby
cookbook_file '/etc/yum.repos.d/custom.repo' do
  source 'custom'
  mode '0755'
end

package 'only-in-custom-repo' do
  action :install
  flush_cache [ :before ]
end
```