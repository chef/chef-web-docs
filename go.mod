module github.com/chef/chef-web-docs

go 1.14

require (
	github.com/chef/automate/components/docs-chef-io v0.0.0-20210110033947-ab4d1693b20a // indirect
	github.com/chef/chef-server/docs-chef-io v0.0.0-20210111145116-cec7cf7e63da // indirect
	github.com/chef/chef-workstation v0.0.0-20201117215019-2a59d0a67f2d // indirect
	github.com/chef/chef-workstation/docs-chef-io v0.0.0-20210105232445-904f6f0643c7 // indirect
	github.com/chef/desktop-config/docs-chef-io v0.0.0-20200929171526-d4cef8a736df // indirect
	github.com/chef/effortless/docs-chef-io v0.0.0-20200930175149-51c187882fba // indirect
	github.com/habitat-sh/habitat/components/docs-chef-io v0.0.0-20210105205530-3dff2d6af000 // indirect
	github.com/inspec/inspec v4.23.15+incompatible // indirect
	github.com/inspec/inspec/docs-chef-io v0.0.0-20210112210439-89289eed83d1 // indirect
)

//replace github.com/chef/effortless/docs-chef-io => ../effortless/docs-chef-io
//replace github.com/chef/chef-workstation/docs-chef-io => ../chef-workstation/docs-chef-io
//replace github.com/chef/desktop-config/docs-chef-io => ../desktop-config/docs-chef-io
//replace github.com/inspec/inspec/docs-chef-io => ../inspec/docs-chef-io
//replace github.com/chef/automate/components/docs-chef-io => ../automate/components/docs-chef-io
//replace github.com/chef/chef-server/docs-chef-io => ../chef-server/docs-chef-io
