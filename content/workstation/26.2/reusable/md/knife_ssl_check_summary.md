Use the `knife ssl check` subcommand to verify the SSL configuration for
Chef Infra Server or a location specified by a URL or URI. Invalid
certificates won't be used by OpenSSL.

When this command is run, the certificate files (`*.crt` and/or `*.pem`)
that are located in the `/.chef/trusted_certs` directory are checked to
see if they have valid X.509 certificate properties. A warning is
returned when certificates don't have valid X.509 certificate
properties or if the `/.chef/trusted_certs` directory doesn't contain
any certificates.

{{< warning >}}

When verification of a remote server's SSL certificate is disabled, Chef
Infra Client will issue a warning similar to "SSL validation of HTTPS
requests is disabled. HTTPS connections are still encrypted, but Chef
Infra Client isn't able to detect forged replies or man-in-the-middle
attacks." To configure SSL for Chef Infra Client, set `ssl_verify_mode`
to `:verify_peer` (recommended) **or** `verify_api_cert` to `true` in
the `client.rb` file.

{{< /warning >}}
