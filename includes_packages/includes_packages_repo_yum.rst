.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 

To set up a |yum| package repository for |enterprise_linux| platforms:

#. Install the public key for |chef inc|:

   .. code-block:: bash

      $ sudo rpm --import https://downloads.chef.io/packages-chef-io-public.key

#. Create the |yum| repository source file:

   .. code-block:: bash

      $ cat >chef-<CHANNEL>.repo <<EOL
          [chef-<CHANNEL>]
          name=chef-<CHANNEL>
          baseurl=https://packages.chef.io/<CHANNEL>-yum/el/\$releasever/\$basearch/
          gpgcheck=1
          enabled=1
        EOL

   Replace ``<CHANNEL>`` with the release channel: ``source`` or ``current``.

#. Update the package repository list:

   .. code-block:: bash

      $ sudo mv chef-stable.repo /etc/yum.repos.d/
