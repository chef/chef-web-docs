.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This topic is hooked in globally to install topics for Chef server applications.


As a root user, install the |chef server| package on the server, using the name of the package provided by |company_name|. For |redhat| and |centos| 6:

.. code-block:: bash

   $ rpm -Uvh /tmp/chef-server-core-<version>.rpm

For |ubuntu|:

.. code-block:: bash

   $ dpkg -i /tmp/chef-server-core-<version>.deb

After a few minutes, the |chef server| will be installed.
