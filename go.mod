module github.com/chef/chef-web-docs

go 1.14

require (
	github.com/chef/automate/components/docs-chef-io v0.0.0-20210401043551-d93b155468dc // indirect
	github.com/chef/chef-server/docs-chef-io v0.0.0-20210401053805-e7b624fe2d62 // indirect
	github.com/chef/chef-workstation v0.0.0-20210402170514-9f2986eed92c // indirect
	github.com/chef/chef-workstation/docs-chef-io v0.0.0-20210402170514-9f2986eed92c // indirect
	github.com/chef/cookstyle v7.10.0+incompatible // indirect
	github.com/chef/cookstyle/docs-chef-io v0.0.0-20210324200148-f941dae22320 // indirect
	github.com/chef/desktop-config/docs-chef-io v0.0.0-20210219180412-c50c4ad0869d // indirect
	github.com/chef/effortless/docs-chef-io v0.0.0-20210219143200-1ad88850fae5 // indirect
	github.com/habitat-sh/habitat/components/docs-chef-io v0.0.0-20210331170710-dc7620852bed // indirect
	github.com/inspec/inspec v4.29.3+incompatible // indirect
	github.com/inspec/inspec/docs-chef-io v0.0.0-20210325192442-86128f555736 // indirect
)

//replace github.com/chef/effortless/docs-chef-io => ../effortless/docs-chef-io
//replace github.com/chef/chef-workstation/docs-chef-io => ../chef-workstation/docs-chef-io
//replace github.com/chef/desktop-config/docs-chef-io => ../desktop-config/docs-chef-io
//replace github.com/inspec/inspec/docs-chef-io => ../inspec/docs-chef-io
//replace github.com/chef/automate/components/docs-chef-io => ../automate/components/docs-chef-io
//replace github.com/chef/chef-server/docs-chef-io => ../chef-server/docs-chef-io
