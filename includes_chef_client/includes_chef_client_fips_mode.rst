.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|fips_long| is a United States government computer security standard that specifies security requirements for cryptography. The current version of the standard is |fips_current|. The |chef client| can be configured to allow |open ssl| to enforce |fips|-validated security during a |chef client| run. This will disable cryptography that is explicitly disallowed in |fips|-validated software, including certain ciphers and hashing algorithms. Any attempt to use any disallowed cryptography will cause the |chef client| to throw an exception during a |chef client| run.

.. note:: |chef| uses |md5| hashes to uniquely identify files that are stored on the |chef server|. |md5| is used only to generate a unique hash identifier and is not used for any cryptographic purpose.

Notes about |fips|:

* May be enabled for nodes running on |windows| and |enterprise_linux| platforms
* Should should only be enabled for environments that require |fips_current| compliance
* May not be enabled for any version of the |chef client| earlier than 12.8
