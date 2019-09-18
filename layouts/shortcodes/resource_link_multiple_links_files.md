The following example creates symbolic links from two files in the
`/vol/webserver/cert/` directory to files located in the
`/etc/ssl/certs/` directory:

``` ruby
link '/vol/webserver/cert/server.crt' do
  to '/etc/ssl/certs/ssl-cert-name.pem'
end

link '/vol/webserver/cert/server.key' do
  to '/etc/ssl/certs/ssl-cert-name.key'
end
```