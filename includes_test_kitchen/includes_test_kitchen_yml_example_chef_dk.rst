.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows the provisioner settings needed to install the |chef dk|, and then use the version of |chef| that is embedded in the |chef dk| to converge the node.

To install the latest version of the |chef dk|:

.. code-block:: yaml
   
   provisioner:
     ...
     chef_omnibus_install_options: -P chefdk
     chef_omnibus_root: /opt/chefdk

and to install a specific version of the |chef dk|:

.. code-block:: yaml

   provisioner:
     ...
     chef_omnibus_install_options: -P chefdk
     chef_omnibus_root: /opt/chefdk
     require_chef_omnibus: 0.5.0
