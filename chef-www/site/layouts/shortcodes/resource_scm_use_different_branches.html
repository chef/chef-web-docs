To use different branches, depending on the environment of the node:

``` ruby
if node.chef_environment == 'QA'
   branch_name = 'staging'
else
   branch_name = 'master'
end

git '/home/user/deployment' do
   repository 'git@github.com:gitsite/deployment.git'
   revision branch_name
   action :sync
   user 'user'
   group 'test'
end
```

where the `branch_name` variable is set to `staging` or `master`,
depending on the environment of the node. Once this is determined, the
`branch_name` variable is used to set the revision for the repository.
If the `git status` command is used after running the example above, it
will return the branch name as `deploy`, as this is the default value.
Run Chef Infra Client in debug mode to verify that the correct branches
are being checked out:

``` bash
$ sudo chef-client -l debug
```