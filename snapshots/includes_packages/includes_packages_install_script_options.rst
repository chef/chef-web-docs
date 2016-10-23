.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


In addition to the default install behavior, the Omnitruck install script supports the following options:

``-c`` (``-channel`` on Microsoft Windows)
   The release channel from which a package is pulled. Possible values: ``current`` or ``stable``. Default value: ``stable``.

``-d`` (``-download_directory`` on Microsoft Windows)
   The directory into which a package is downloaded. When a package already exists in this directory and the checksum matches, the package is not re-downloaded. When ``-d`` and ``-f`` are not specified, a package is downloaded to a temporary directory.

``-f`` (``-filename`` on Microsoft Windows)
   The name of the file and the path at which that file is located. When a filename already exists at this path and the checksum matches, the package is not re-downloaded. When ``-d`` and ``-f`` are not specified, a package is downloaded to a temporary directory.

``-P`` (``-project`` on Microsoft Windows)
   The product name to install. A list of valid product names can be found at https://omnitruck.chef.io/products. Default value: ``chef``.

``-v`` (``-version`` on Microsoft Windows)
   The version of the package to be installed. A version always takes the form x.y.z, where x, y, and z are decimal numbers that are used to represent major (x), minor (y), and patch (z) versions. A two-part version (x.y) is also allowed. For more information about application versioning, see http://semver.org/.
