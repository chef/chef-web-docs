Authentication to the Chef Infra Server occurs when a specific set of
HTTP headers are signed using a private key that is associated with the
machine from which the request is made. The request is authorized if the
Chef Infra Server can verify the signature using the public key. Only
authorized actions are allowed.

<div class="alert-info">

Most authentication requests made to the Chef Infra Server are
abstracted from the user. Such as when using knife or the Chef Infra
Server user interface. In some cases, such as when using the
`knife exec` subcommand, the authentication requests need to be made
more explicitly, but still in a way that does not require authentication
headers. In a few cases, such as when using arbitrary Ruby code or cURL,
it may be necessary to include the full authentication header as part of
the request to the Chef Infra Server.

</div>