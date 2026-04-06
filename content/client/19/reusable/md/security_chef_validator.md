Every request made by Chef Infra Client to Chef Infra Server must be
an authenticated request using the Chef Infra Server API and a private
key. When Chef Infra Client makes a request to Chef Infra Server,
Chef Infra Client authenticates each request using a private key located
in `/etc/chef/client.pem`.
