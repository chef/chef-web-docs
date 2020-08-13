module github.com/chef/chef-web-docs

go 1.14

require (
	github.com/chef/chef-workstation/www v0.0.0-20200805001253-17ffc16b0146 // indirect
	github.com/chef/desktop-config/docs v0.0.0-20200812014916-cac26cf98c63 // indirect
	github.com/chef/effortless/effortless-chef-io v0.0.0-20200605204203-daaeab90dcdd // indirect
	github.com/inspec/inspec/www v0.0.0-20200805143255-679ddd1ee893 // indirect
)

//replace github.com/chef/effortless/effortless-chef-io => ../effortless
//replace github.com/chef/chef-workstation/www => ../chef-workstation/www
//replace github.com/chef/desktop-config/docs => ../desktop-config/docs
//replace github.com/inspec/inspec/www => ../inspec/www
