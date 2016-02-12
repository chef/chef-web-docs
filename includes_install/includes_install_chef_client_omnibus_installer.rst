.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

The |omnibus installer| is used to install the |chef client| on a server, a workstation, and a node. 

To install the |chef client| using the |omnibus installer|:

#. Run the command that appears (for |unix| and |linux| environments) or download the |omnibus installer| (for |windows| environments). For example, for the |mac os x|:

   .. code-block:: bash

      curl -L https://www.chef.io/chef/install.sh | sudo bash

   and then enter the local password.
#. As the |chef client| is being installed, the command window will show something like the following:

   .. code-block:: bash

      Downloading Chef for mac_os_x...
        % Total    % Received  % Xferd   Average  Speed    Time     Time      Time   Current
                                         Dload   Upload    Total    Spent     Left   Speed
      100 23.9M  100 23.9M     0     0    944k       0   0:00:26  0:00:26  --:--:--   838k
      Installing Chef

In addition to the default install behavior, the |omnibus installer| has the following options:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Option
     - Description
   * - ``-d``
     - Use to specify the directory into which a package is downloaded. When a package already exists in this directory and the checksum matches, the package is not re-downloaded. When ``-d`` and ``-f`` are not specified, a package is downloaded to a temporary directory.
   * - ``-f``
     - Use to specify the name of the file and the path at which that file is located. When a filename already exists at this path and the checksum matches, the package is not re-downloaded. When ``-d`` and ``-f`` are not specified, a package is downloaded to a temporary directory.
   * - ``-p``
     - Install a pre-release version. Requires that ``-s`` be passed as part of the command.
   * - ``-v``
     - The version of the |chef client| to be installed. A version always takes the form x.y.z, where x, y, and z are decimal numbers that are used to represent major (x), minor (y), and patch (z) versions. A two-part version (x.y) is also allowed. For more information about application versioning, see http://semver.org/.

For example:

.. code-block:: bash

   $ curl -LO https://www.chef.io/chef/install.sh && sudo bash ./install.sh -v 12.0.2 && rm install.sh

and

.. code-block:: bash

   $ curl -L https://www.chef.io/chef/install.sh | sudo bash -s -- -v 12.0.2

will both install the |chef client|, version 12.0.2.
