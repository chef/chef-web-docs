.. THIS PAGE IS IDENTICAL TO docs.chef.io/search_query_chef_automate.html BY DESIGN
.. THIS PAGE IS LOCATED AT THE /release/automate/ PATH.

=====================================================
Node Search Query Reference
=====================================================

.. include:: ../../includes_chef_automate/includes_chef_automate_mark.rst 

The visibility dashboard in **Nodes** exposes a search bar that allows you to search for nodes based off a 
defined query language. This language will allow you to search on the following terms:

  * attribute
  * cookbook
  * recipe
  * resource_name
  * tag
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

**Tag**

   All nodes with the 'web' tag: ``tag: web``

**Node Name**

   The node named 'node1.chef.io': ``node_name: node1.chef.io``
