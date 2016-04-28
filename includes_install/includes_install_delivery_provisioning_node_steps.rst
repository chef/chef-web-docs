.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


On the provisioning node:

#. Install a development environment:

   For |debian|-based (apt):

   .. code-block:: bash

      $ sudo apt-get install build-essential

   For |redhat enterprise linux|-based (yum):

   .. code-block:: bash

      $ sudo yum groupinstall "Development Tools"

   For |mac os x|:

   .. code-block:: bash

      $ sudo xcode-select --install

#. Install |git| and configure your |github| username and email, for help see: `Installing Git <http://git-scm.com/book/en/v2/Getting-Started-Installing-Git>`_ and `First-Time Git Setup <https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup>`_.
#. Install the `Chef Development Kit <https://downloads.chef.io/chef-dk/>`_. Be sure to set the system |ruby|; for details, see `Add Ruby to $PATH <https://docs.chef.io/install_dk.html#add-ruby-to-path>`_.

#. Transfer your |delivery| license key to ``~/delivery.license``.
#. Clone the |git| repo for the |delivery| cluster:

   .. code-block:: bash

      $ git clone https://github.com/opscode-cookbooks/delivery-cluster.git ~/delivery-cluster
