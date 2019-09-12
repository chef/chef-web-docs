``` ruby
dsc_resource 'demogroupadd' do
  resource :group
  property :groupname, 'demo1'
  property :ensure, 'present'
end

dsc_resource 'useradd' do
  resource :user
  property :username, 'Foobar1'
  property :fullname, 'Foobar1'
  property :password, ps_credential('P@assword!')
  property :ensure, 'present'
end

dsc_resource 'AddFoobar1ToUsers' do
  resource :Group
  property :GroupName, 'demo1'
  property :MembersToInclude, ['Foobar1']
end
```