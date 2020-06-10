module github.com/chef/chef-web-docs

go 1.14

require (
	github.com/chef/chef-workstation/www v0.0.0-20200602170139-70714e50d9bb // indirect
	github.com/chef/desktop-config/docs v0.0.0-20200610165450-c19114b2ac44 // indirect
	github.com/chef/effortless/effortless-chef-io v0.0.0-20200602005543-9e19b94020fd // indirect
)

//replace github.com/chef/effortless/effortless-chef-io => ../effortless
//replace github.com/chef/chef-workstation/www => ../chef-workstation/www
//replace github.com/chef/desktop-config/docs => ../desktop-config/docs
