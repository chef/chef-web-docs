module github.com/chef/chef-web-docs

go 1.14

require (
	github.com/chef/automate/components/docs-chef-io v0.0.0-20210324170457-bfd674d7841b // indirect
	github.com/chef/chef-server/docs-chef-io v0.0.0-20210316181455-086b59abe39e // indirect
	github.com/chef/chef-workstation v0.0.0-20210224180306-c98d1ffba769 // indirect
	github.com/chef/chef-workstation/docs-chef-io v0.0.0-20210224180306-c98d1ffba769 // indirect
	github.com/chef/cookstyle v7.10.0+incompatible // indirect
	github.com/chef/cookstyle/docs-chef-io v0.0.0-20210324200148-f941dae22320 // indirect
	github.com/chef/desktop-config/docs-chef-io v0.0.0-20210219180412-c50c4ad0869d // indirect
	github.com/chef/effortless/docs-chef-io v0.0.0-20210212122821-321ee6f6699a // indirect
	github.com/habitat-sh/habitat/components/docs-chef-io v0.0.0-20210402191111-4b56ffe5d933 // indirect
	github.com/inspec/inspec v4.29.3+incompatible // indirect
	github.com/inspec/inspec/docs-chef-io v0.0.0-20210407130212-e8e5d8eb6f9b // indirect
)

//replace github.com/chef/effortless/docs-chef-io => ../effortless/docs-chef-io
//replace github.com/chef/chef-workstation/docs-chef-io => ../chef-workstation/docs-chef-io
//replace github.com/chef/desktop-config/docs-chef-io => ../desktop-config/docs-chef-io
//replace github.com/inspec/inspec/docs-chef-io => ../inspec/docs-chef-io
//replace github.com/chef/automate/components/docs-chef-io => ../automate/components/docs-chef-io
//replace github.com/chef/chef-server/docs-chef-io => ../chef-server/docs-chef-io
