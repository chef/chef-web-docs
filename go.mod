module github.com/chef/chef-web-docs

go 1.14

require (
	github.com/chef/automate/components/docs-chef-io v0.0.0-20210129161106-3b5a3ab507b3 // indirect
	github.com/chef/chef-server/docs-chef-io v0.0.0-20210111145116-cec7cf7e63da // indirect
	github.com/chef/chef-workstation v0.0.0-20210208215854-5868ce1261a9 // indirect
	github.com/chef/chef-workstation/docs-chef-io v0.0.0-20210208215854-5868ce1261a9 // indirect
	github.com/chef/desktop-config/docs-chef-io v0.0.0-20210112020121-58047a6a6d6f // indirect
	github.com/chef/effortless/docs-chef-io v0.0.0-20210212122821-321ee6f6699a // indirect
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
