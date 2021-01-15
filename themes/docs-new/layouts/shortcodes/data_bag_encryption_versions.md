The manner by which a data bag item is encrypted depends on the Chef
Infra Client version used. See the following:

|Infra Client version|Encryption v0|Encryption v1|Encryption v2|Encryption v3|
|:--|:---:|:---:|:---:|:---:|
|10.x|`R` `W`||||
|11.0+|`R`|`R` `W`|||
|11.6+|`R` `D`|`R` `D`|`R` `W`||
|13.0.113+|`R` `D`|`R` `D`|`R` `D`|`R` `W`|

`R` = read
`W` = write
`D` = disable

#### Version 0

Chef Infra Client 10.0+

- Uses YAML serialization format to encrypt data bag items
- Uses Base64 encoding to preserve special characters
- Uses AES-256-CBC encryption, as defined by the OpenSSL package in the Ruby Standard Library
- [Shared secret encryption](https://en.wikipedia.org/wiki/Symmetric-key_algorithm); an encrypted file can only be decrypted by a node or a user with the same shared secret
- Recipes load encrypted data with access to the shared secret in a file on the node or from a URI path
- Decrypts only data bag item values. Keys are encrypted but searchable
- Data bag `id` value is unencrypted for tracking data bag items

#### Version 1

Chef Infra Client 11.0+
- Version 0
- Uses JSON serialization format _instead of_ YAML to encrypt data bag items
- Adds random initialization vector encryption for each value to protect against cryptanalysis

#### Version 2

Chef Infra Client 11.6+

- Version 1
- Option to disable versions 0 and 1
- Adds Encrypt-then-MAC(EtM) protection

#### Version 3

Chef Infra Client 13.0.113+
- Option to  disable version 0, 1, and 2
