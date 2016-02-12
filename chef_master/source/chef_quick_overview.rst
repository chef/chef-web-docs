=====================================================
A Quick Overview of |chef|
=====================================================

Welcome to |chef|!

.. include:: ../../includes_chef/includes_chef.rst

|chef| Components
=====================================================
The following diagram shows the relationships between the various elements of a very simple organization, including the hosted |chef server oec| server, a workstations, the |chef repo|, and some simple nodes that exist either in |virtualbox| or |amazon aws|.

.. image:: ../../images/overview_chef_quick.png

The following sections discuss these elements in a bit more detail.

Nodes
=====================================================
.. include:: ../../includes_node/includes_node.rst

Workstations
=====================================================
.. include:: ../../includes_workstation/includes_workstation.rst

Knife
-----------------------------------------------------
.. include:: ../../includes_knife/includes_knife.rst

Repository
-----------------------------------------------------
.. include:: ../../includes_chef_repo/includes_chef_repo.rst

|git| is the most commonly-used location to store a |chef repo| that is used with a hosted |chef server oec| account, but |git| is not required.

.. include:: ../../includes_chef_repo/includes_chef_repo_structure.rst

The Hosted |chef server_title|
=====================================================
.. include:: ../../includes_chef_server/includes_chef_server.rst

.. include:: ../../includes_chef/includes_chef_hosted.rst

Cookbooks
-----------------------------------------------------
.. include:: ../../includes_cookbooks/includes_cookbooks.rst

The |chef client| uses |ruby| as its reference language for creating cookbooks and defining recipes, with an extended DSL for specific resources. The |chef client| provides a reasonable set of resources, enough to support many of the most common infrastructure automation scenarios; however, this DSL can also be extended when additional resources and capabilities are required.

Conclusion
=====================================================
.. include:: ../../includes_chef/includes_chef_about.rst
