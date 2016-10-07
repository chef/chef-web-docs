.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To set up an |apt| package repository for |debian| and |ubuntu| platforms:

#. Enable |apt| to fetch packages over HTTPS:

   .. code-block:: bash

      $ sudo apt-get install apt-transport-https

#. Install the public key for |chef inc|:

   .. code-block:: bash

      $ wget -qO - https://downloads.chef.io/packages-chef-io-public.key | sudo apt-key add -

#. Create the |apt| repository source file:

   .. code-block:: bash

      $ echo "deb https://packages.chef.io/<CHANNEL>-apt <DISTRIBUTION> main" > chef-<CHANNEL>.list

   Replace ``<CHANNEL>`` with the release channel: ``stable`` or ``current``.

   Replace ``<DISTRIBUTION>`` with the appropriate distribution name:

   * For |debian| 7: ``wheezy``
   * For |debian| 8: ``jessie``
   * For |ubuntu| 12.04: ``precise``
   * For |ubuntu| 14.04: ``trusty``
   * For |ubuntu| 16.04: ``xenial``


#. Update the package repository list:

   .. code-block:: bash

      $ sudo mv chef-stable.list /etc/apt/sources.list.d/

#. Update the cache for the package repository:

   .. code-block:: bash

      $ sudo apt-get update
