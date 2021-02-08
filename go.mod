module github.com/chef/chef-web-docs

go 1.14

require (
	github.com/chef/automate/components/docs-chef-io v0.0.0-20210125154254-76612f53b101 // indirect
	github.com/chef/chef-server/docs-chef-io v0.0.0-20210111145116-cec7cf7e63da // indirect
	github.com/chef/chef-workstation v0.0.0-20210205212452-45369fb3bd79 // indirect
	github.com/chef/chef-workstation/docs-chef-io v0.0.0-20210205212452-45369fb3bd79 // indirect
	github.com/chef/desktop-config/docs-chef-io v0.0.0-20210112020121-58047a6a6d6f // indirect
	github.com/chef/effortless/docs-chef-io v0.0.0-20210203145823-a52b3ca52990 // indirect
	github.com/habitat-sh/habitat/components/docs-chef-io v0.0.0-20210105205530-3dff2d6af000 // indirect
	github.com/inspec/inspec v4.26.4+incompatible // indirect
	github.com/inspec/inspec/docs-chef-io v0.0.0-20210127162405-a70f336800ac // indirect
)

//replace github.com/chef/effortless/docs-chef-io => ../effortless/docs-chef-io
//replace github.com/chef/chef-workstation/docs-chef-io => ../chef-workstation/docs-chef-io
//replace github.com/chef/desktop-config/docs-chef-io => ../desktop-config/docs-chef-io
//replace github.com/inspec/inspec/docs-chef-io => ../inspec/docs-chef-io
//replace github.com/chef/automate/components/docs-chef-io => ../automate/components/docs-chef-io
//replace github.com/chef/chef-server/docs-chef-io => ../chef-server/docs-chef-io
