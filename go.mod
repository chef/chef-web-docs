module github.com/chef/chef-web-docs

go 1.14

require (
	github.com/chef/automate/components/docs-chef-io v0.0.0-20210219170136-8011a2360813 // indirect
	github.com/chef/chef-server/docs-chef-io v0.0.0-20210226191330-bbb0da2972a4 // indirect
	github.com/chef/chef-workstation v0.0.0-20210224180306-c98d1ffba769 // indirect
	github.com/chef/chef-workstation/docs-chef-io v0.0.0-20210224180306-c98d1ffba769 // indirect
	github.com/chef/cookstyle v7.7.5+incompatible // indirect
	github.com/chef/cookstyle/docs-chef-io v0.0.0-20210211034315-bf8938ff6d85 // indirect
	github.com/chef/desktop-config/docs-chef-io v0.0.0-20210219180412-c50c4ad0869d // indirect
	github.com/chef/effortless/docs-chef-io v0.0.0-20210212122821-321ee6f6699a // indirect
	github.com/habitat-sh/habitat/components/docs-chef-io v0.0.0-20210219230551-dce07027b152 // indirect
	github.com/inspec/inspec v4.26.13+incompatible // indirect
	github.com/inspec/inspec/docs-chef-io v0.0.0-20210223170734-c212bb09026a // indirect
)

//replace github.com/chef/effortless/docs-chef-io => ../effortless/docs-chef-io
//replace github.com/chef/chef-workstation/docs-chef-io => ../chef-workstation/docs-chef-io
//replace github.com/chef/desktop-config/docs-chef-io => ../desktop-config/docs-chef-io
//replace github.com/inspec/inspec/docs-chef-io => ../inspec/docs-chef-io
//replace github.com/chef/automate/components/docs-chef-io => ../automate/components/docs-chef-io
//replace github.com/chef/chef-server/docs-chef-io => ../chef-server/docs-chef-io
