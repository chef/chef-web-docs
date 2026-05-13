For example:

```ruby
name 'jenkins-master'
run_list 'java', 'jenkins::master', 'recipe[policyfile_demo]'
default_source :supermarket, 'https://mysupermarket.example'
cookbook 'policyfile_demo', path: 'cookbooks/policyfile_demo'
cookbook 'jenkins', '~> 8.2'
cookbook 'mysql', github: 'sous-chefs/mysql', branch: 'master'
default['stage']['mysql']['install_s3'] = 'https://s3-eu-west-1.amazonaws.com/example/stage/file.rpm'
default['prod']['mysql']['install_s3'] = 'https://s3-eu-west-1.amazonaws.com/example/prod/file.rpm'
```
