For example:

```ruby
name 'jenkins-master'
run_list 'java', 'jenkins::master', 'recipe[policyfile_demo]'
default_source :supermarket, 'https://mysupermarket.example'
cookbook 'policyfile_demo', path: 'cookbooks/policyfile_demo'
cookbook 'jenkins', '~> 8.2'
cookbook 'mysql', github: 'sous-chefs/mysql', branch: 'master'
```
