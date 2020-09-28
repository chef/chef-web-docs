module github.com/chef/chef-web-docs

go 1.14

require (
	github.com/chef/automate/components/docs-chef-io v0.0.0-20200924213342-faad11791111 // indirect
	github.com/chef/chef-workstation/docs-chef-io v0.0.0-20200915214226-6bffa20406f2 // indirect
	github.com/chef/desktop-config/docs-chef-io v0.0.0-20200918222423-feb5f33b21f8 // indirect
	github.com/chef/effortless/docs-chef-io v0.0.0-20200914100024-66d58284ce17 // indirect
	github.com/inspec/inspec/docs-chef-io v0.0.0-20200925145959-ded881473f2b // indirect
)

//replace github.com/chef/effortless/effortless-chef-io => ../effortless
//replace github.com/chef/chef-workstation/www => ../chef-workstation/www
//replace github.com/chef/desktop-config/docs => ../desktop-config/docs
//replace github.com/inspec/inspec/www => ../inspec/www
//replace github.com/chef/automate/components/docs-chef-io => ../automate/components/docs-chef-io
