.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

To use |curl| to return only the SHA for the installer, enter the following:

.. code-block:: bash

   $ curl -s 'https://www.chef.io/chef/metadata-server?p=ubuntu&pv=12.04&m=x86_64' | awk '$1 == "sha256" { print $2 }'

to return something like:

.. code-block:: bash

   $ 29fa28a18d48bcc8d8e888d4c2dd94386abb6b20cfc341fff62664401d76351c
