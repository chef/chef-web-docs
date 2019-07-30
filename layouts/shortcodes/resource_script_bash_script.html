``` ruby
script 'install_something' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOH
  wget http://www.example.com/tarball.tar.gz
  tar -zxf tarball.tar.gz
  cd tarball
  ./configure
  make
  make install
  EOH
end
```

or something like:

``` ruby
bash 'openvpn-server-key' do
  environment('KEY_CN' => 'server')
  code <<-EOF
    openssl req -batch -days #{node['openvpn']['key']['expire']} \
      -nodes -new -newkey rsa:#{key_size} -keyout #{key_dir}/server.key \
      -out #{key_dir}/server.csr -extensions server \
      -config #{key_dir}/openssl.cnf
  EOF
  not_if { File.exist?('#{key_dir}/server.crt') }
end
```

where `code` contains the OpenSSL command to be run. The `not_if`
property tells Chef Infra Client not to run the command if the file
already exists.