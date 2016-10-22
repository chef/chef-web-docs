.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Attributes are typically defined in cookbooks, recipes, roles, and environments. These attributes are rolled-up to the node level during a chef-client run. A recipe can store attribute values using a multi-level Hash or array.

For example, a group of attributes for web servers might be:

.. code-block:: ruby

   override_attributes(
     :apache => {
       :listen_ports => [ 80 ],
       :prefork => {
         :startservers => 20,
         :minspareservers => 20,
         :maxspareservers => 40
       }
     }
   )

But what if all of the web servers are not the same? What if some of the web servers required a single attribute to have a different value? You could store these settings in two locations, once just like the preceding example and once just like the following:

.. code-block:: ruby

   override_attributes(
     :apache => {
       :listen_ports => [ 80 ],
       :prefork => {
         :startservers => 30,
         :minspareservers => 20,
         :maxspareservers => 40
       }
     }
   )

But that is not very efficient, especially because most of them are identical. The deep merge capabilities of the chef-client allows attributes to be layered across cookbooks, recipes, roles, and environments. This allows an attribute to be reused across nodes, making use of default attributes set at the cookbook level, but also providing a way for certain attributes (with a higher attribute precedence) to be applied only when they are supposed to be. 

For example, a role named ``baseline.rb``:

.. code-block:: ruby

   name "baseline"
   description "The most basic role for all configurations"
   run_list "recipe[baseline]"
 
   override_attributes(
     :apache => {
       :listen_ports => [ 80 ],
       :prefork => {
         :startservers => 20,
         :minspareservers => 20,
         :maxspareservers => 40
       }
     }
   )

and then a role named ``web.rb``:

.. code-block:: ruby

   name 'web'
   description 'Web server config'
   run_list 'role[baseline]'
 
   override_attributes(
     :apache => {
       :prefork => {
         :startservers => 30
       }
     }
   )

Both of these files are similar. They share the same structure. When an attribute is of the same type of data, such as a hash or an array, that data is merged when the attribute precedence levels are the same and is replaced when the attribute precedence levels are different.

For example, the ``web.rb`` references the ``baseline.rb`` role. The ``web.rb`` file only provides a value for one attribute: ``:startservers``. When the chef-client compares these attributes, the deep merge feature will ensure that ``:startservers`` (and its value of ``30``) will be applied to any node for which the ``web.rb`` attribute structure should be applied.

This approach will allow a recipe like this:

.. code-block:: ruby

   include_recipe 'apache2'
   Chef::Log.info(node['apache']['prefork'].to_hash)

and a ``run_list`` like this:

.. code-block:: ruby

   run_list/web.json
   {
     "run_list": [ "role[web]" ]
   }

to produce results like this:

.. code-block:: ruby

   [Tue, 16 Aug 2011 14:44:26 -0700] INFO: 
            {
              "startservers"=>30, 
              "minspareservers"=>20, 
              "maxspareservers"=>40, 
              "serverlimit"=>400,
              "maxclients"=>400, 
              "maxrequestsperchild"=>10000
            }

Even though the ``web.rb`` file does not contain attributes and values for ``minspareservers``, ``maxspareservers``, ``serverlimit``, ``maxclients``, and ``maxrequestsperchild``, the deep merge capabilities pulled them in.
