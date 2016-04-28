.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. note:: If you reuse the provisioning node in the previous section of this installation guide as a workstation for using |delivery|, you can skip steps 1 through 4 below.

Setting up a workstation requires the following:

#. Install a development environment:

   * Debian based (apt): ``apt-get install build-essential``
   * RHEL based (yum): ``yum groupinstall "Development Tools"``
   * OS X: ``xcode-select --install``

#. Install |git|: http://git-scm.com/book/en/v2/Getting-Started-Installing-Git. Also, make sure that your SSH public key is added to your user profile in |delivery|.
#. Install the |chef dk|: https://downloads.chef.io/chef-dk/. Be sure to follow all instructions; for example, to run delivery commands you must set the following:

   ``echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile``

#. Install and configure the |delivery_cli|, described in |delivery| installation.
