module github.com/chef/chef-web-docs

go 1.14

require (
	github.com/chef/automate/components/docs-chef-io v0.0.0-20201127101112-09cd0615d05f // indirect
	github.com/chef/chef-workstation v0.0.0-20201117215019-2a59d0a67f2d // indirect
	github.com/chef/chef-workstation/docs-chef-io v0.0.0-20201214222712-7749446a76af // indirect
	github.com/chef/desktop-config/docs-chef-io v0.0.0-20200929171526-d4cef8a736df // indirect
	github.com/chef/effortless/docs-chef-io v0.0.0-20200930175149-51c187882fba // indirect
	github.com/habitat-sh/habitat/components/docs-chef-io v0.0.0-20201105224549-ce890e79d550 // indirect
	github.com/inspec/inspec v4.23.15+incompatible // indirect
	github.com/inspec/inspec/docs-chef-io v0.0.0-20201209191123-eefd96d86745 // indirect
)

//replace github.com/chef/effortless/docs-chef-io => ../effortless/docs-chef-io
//replace github.com/chef/chef-workstation/docs-chef-io => ../chef-workstation/docs-chef-io
//replace github.com/chef/desktop-config/docs-chef-io => ../desktop-config/docs-chef-io
//replace github.com/inspec/inspec/docs-chef-io => ../inspec/docs-chef-io
//replace github.com/chef/automate/components/docs-chef-io => ../automate/components/docs-chef-io
