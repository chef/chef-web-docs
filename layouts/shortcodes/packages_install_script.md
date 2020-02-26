The Chef install script does the following:

-   Detects the platform, version, and architecture of the machine on
    which the installer is to be executed
-   Fetches the appropriate package, for the requested product and
    version
-   Validates the package content by comparing SHA-256 checksums
-   Installs the package