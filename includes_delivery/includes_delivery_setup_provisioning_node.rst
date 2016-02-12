.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|chef delivery| uses |chef provisioning| to create, upgrade, and manage the cluster. A dedicated provisioning node ensures a central place from which the |chef delivery| cluster is managed, including managing those allowed to control it. Use your existing means to provision a dedicated provisioning node with a supported platform. This machine does not need to be powerful because it runs only provisioning code. Within |amazon aws|, |company_name| generally uses a t2.micro instance, which is a single CPU 2.5GHz, 1 GB of memory, and 8 GB of disk space.

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
#. Install knife push:

   .. code-block:: bash
      
      $ chef gem install knife-push

#. Transfer your |chef delivery| license key to ``~/delivery.license``.
#. Clone the |git| repo for the |chef delivery| cluster:

   .. code-block:: bash
      
      $ git clone https://github.com/opscode-cookbooks/delivery-cluster.git ~/delivery-cluster
