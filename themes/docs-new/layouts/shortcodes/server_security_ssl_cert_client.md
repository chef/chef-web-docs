TLS verification is enabled by default for all requests made to the server, such as those made by knife and Chef Infra Client. Chef Infra Server generates a self-signed certificate during installation, which means the certificate is not signed by a trusted certificate authority (CA). You can replace the self-signed certificat with a certificate signed by a trursted CA. To use the self-signed certificate, you must download it to any computer that will make requests to the Chef Infra Server using `knife` commands or the Chef Infra Client.

Use `knife ssl fetch` to download the self-signed certificate from the Chef Infra Server to the `/.chef/trusted_certs` directory on a workstation.

```
knife ssl fetch
```

For example, without downloading the SSL certificate, the following knife command:

```bash
knife client list
```

responds with an error similar to:

```bash
ERROR: SSL Validation failure connecting to host: chef-server.example.com ...
ERROR: OpenSSL::SSL::SSLError: SSL_connect returned=1 errno=0 state=SSLv3 ...
```

This is by design and will occur until a verifiable certificate is added to the machine from which the request is sent.
