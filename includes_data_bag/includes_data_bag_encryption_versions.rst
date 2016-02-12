.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The manner by which a data bag item is encrypted depends on the version of the |chef client|. See the following:

.. image:: ../../images/essentials_data_bags_versions.png

where R is read, W is write, and D is disable. (Disabling support for older encryption version formats will be in the next version and, if desired, will require a configuration change.)

For version 0 (default, through |chef client| version 10.18):

* An encrypted data bag item is written using |yaml| as the serialization format
* |base64| encoding is used to preserve special characters in encrypted contents
* Data is encrypted using |aes 256 cbc| (as defined by the |open ssl| package in the |ruby standard library|)
* The |chef client| uses `shared secret encryption <https://en.wikipedia.org/wiki/Symmetric-key_algorithm>`_; an encrypted file can only be decrypted by a node or a user with the same shared secret
* A recipe can load encrypted data as long as the shared secret is present in a file on the node or is accessible from a URI path
* Only the values of a data bag item are decrypted; keys are still searchable. The values associated with the ``id`` key of a data bag item are not encrypted (because they are needed when tracking the data bag item)

For version 1 (default, starting with |chef client| version 11.0):

* An encrypted data bag item is written using |json| as the serialization format
* |base64| encoding is used to preserve special characters in encrypted contents
* Data is encrypted using |aes 256 cbc| (as defined by the |open ssl| package in the |ruby standard library|)
* A data bag item is encrypted using a random initialization vector each time a value is encrypted, which helps protect against some forms of cryptanalysis
* The |chef client| uses `shared secret encryption <https://en.wikipedia.org/wiki/Symmetric-key_algorithm>`_; an encrypted file can only be decrypted by a node or a user with the same shared secret
* A recipe can load encrypted data as long as the shared secret is present in a file on the node or is accessible from a URI path
* Only the values of a data bag item are decrypted; keys are still searchable. The values associated with the ``id`` key of a data bag item are not encrypted (because they are needed by the |chef client| when tracking the data bag item)

For version 2 (available, starting with |chef client| version 11.6):

* Same as version 1
* Can disable version 0 and version 1 data bag item encryption formats
* Adds |encrypt_then_mac| protection

