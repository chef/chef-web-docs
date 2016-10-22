.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


When a cookbook is uploaded, only files that are new or updated will be included. This approach minimizes the amount of storage and time that is required during the modify-upload-test cycle. To keep track of which files have already been uploaded, the chef-client uses a checksum and assigns a checksum to each file. These checksums are used in the cookbook version manifest, alongside the same records that store the file description (name, specificity, and so on), as well as the checksum and the URL from which the file's contents can be retrieved. 

The ``/cookbooks`` endpoint has the following methods: ``GET``.
