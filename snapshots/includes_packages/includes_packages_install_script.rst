.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


The Omnitruck install script does the following:

* Detects the platform, version, and architecture of the machine on which the installer is to be executed
* Fetches the appropriate package, for the requested product and version
* Validates the package content by comparing SHA-256 checksums
* Installs the package
