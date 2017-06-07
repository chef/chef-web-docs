=====================================================
Node Search Query Reference
=====================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/search_query_chef_automate.rst>`__

.. tag chef_automate_mark

.. image:: ../../images/chef_automate_full.png
   :width: 40px
   :height: 17px

.. end_tag

The visibility dashboard in **Nodes** exposes a search bar that allows you to search for nodes based off a
defined query language. This language will allow you to search on the following terms:

  * attribute
  * cookbook
  * recipe
  * resource_name
  * node_name

The key for each of these terms is the name of the item you are searching
for. Nesting should be denoted by dot(.)s.

Multiple queries can be entered into the search bar to further focus search
results.

Examples
================================

**Attribute**

   All aws nodes with a public ip: ``attribute: ec2.public_ipv4``

**Cookbook**

   All nodes running the 'postgres' cookbook: ``cookbook: postgresql``

**Recipe**

   All nodes running a 'server' recipe: ``recipe: server``

**Resource Name**

   All nodes that manage a resource named '/tmp': ``resource_name: /tmp``

**Node Name**

   The node named 'node1.chef.io': ``node_name: node1.chef.io``
