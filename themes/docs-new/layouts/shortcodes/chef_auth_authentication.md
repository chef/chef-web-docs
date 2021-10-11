
The authentication process ensures the Chef Infra Server responds only
to requests made by trusted users or clients. Public key encryption is used 
by the Chef Infra Server. When configuring Chef Infra Client or Chef Workstation,
both public and private keys are created. The public key is stored on the 
Chef Infra Server, while the private key is returned to the user for safe 
keeping. (The private key is a .pem file located in the `~/.chef` directory
for Chef Workstation or in `/etc/chef` for Chef Infra Client.)

Both Chef Infra Client and Chef Workstation use the Chef Infra Server API when
communicating with the Chef Infra Server. Each request to the Chef Infra 
Server from those executables sign a special group of HTTP headers with 
the private key. The Chef Infra Server then uses the public key to verify 
the headers and verify the contents.