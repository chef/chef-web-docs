The private key doesn't yet exist the first time that Chef Infra Client runs from a new node.

During the first Chef Infra Client run:

1. Chef Infra Client uses the chef-validator private key, located in `/etc/chef/validation.pem` to register with Chef Infra Server
2. Chef Infra Server assigns Chef Infra Client a private key for all future authentication requests to the Chef Infra Server
3. Chef Infra Client saves the private key on the node as `/etc/chef/client.pem`

If the request to communicate with Chef Infra Server with the chef-validator key fails, then the entire first Chef Infra Client run fails.

After the first completed Chef Infra Client run, delete the chef-validator private key at `/etc/chef/validation.pem`
