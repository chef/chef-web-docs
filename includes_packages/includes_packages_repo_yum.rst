.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To set up a |yum| package repository for |enterprise_linux| platforms:

#. Install the public key for |chef inc|:

   .. code-block:: bash

      $ sudo rpm --import https://packages.chef.io/chef.asc

#. Create the |yum| repository source file:

   .. code-block:: bash

      $ cat >chef-<CHANNEL>.repo <<EOL
          [chef-<CHANNEL>]
          name=chef-<CHANNEL>
          baseurl=https://packages.chef.io/<CHANNEL>-yum/el/<VERSION>/\$basearch/
          gpgcheck=1
          enabled=1
        EOL

   Replace ``<CHANNEL>`` with the release channel: ``stable`` or ``current``.

   Replace ``<VERSION>`` with your |enterprise_linux| version; the allowable versions are ``5``, ``6``, or ``7``.

#. Update the package repository list:

   .. code-block:: bash

      $ sudo mv chef-stable.repo /etc/yum.repos.d/
