macOS 10.8 (and higher) calculates the password shadow hash using
SALTED-SHA512-PBKDF2. The length of the shadow hash value is 128 bytes,
the salt value is 32 bytes, and an integer specifies the number of
iterations. The following code will calculate password shadow hashes for
macOS 10.8 (and higher):

``` ruby
password = 'my_awesome_password'
salt = OpenSSL::Random.random_bytes(32)
iterations = 25000 # Any value above 20k should be fine.

shadow_hash = OpenSSL::PKCS5::pbkdf2_hmac(
  password,
  salt,
  iterations,
  128,
  OpenSSL::Digest::SHA512.new
).unpack('H*').first
salt_value = salt.unpack('H*').first
```

Use the calculated password shadow hash with the **user** resource:

``` ruby
user 'my_awesome_user' do
  password 'cbd1a....fc843'  # Length: 256
  salt 'bd1a....fc83'        # Length: 64
  iterations 25000
end
```