module github.com/chef/chef-web-docs

go 1.14

require (
	github.com/chef/chef-workstation/www v0.0.0-20200602170139-70714e50d9bb // indirect
	github.com/chef/desktop-config/docs v0.0.0-20200602174303-7096345a1055 // indirect
)

//replace github.com/chef/chef-workstation/www => ../chef-workstation/www
//replace github.com/chef/desktop-config/docs => ../desktop-config/docs