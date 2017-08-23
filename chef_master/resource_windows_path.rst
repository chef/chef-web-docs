==========================================
windows_task
==========================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/resource_windows_path.rst>`__

Use the **windows_path** resource to manage the path environment variable on Microsoft Windows.

*New in Chef Client 13.4

Syntax
==========================================
A **windows_path** resource manages the path environment variable on Microsoft Windows.

.. code-block:: ruby

   windows_path 'name' do
     path                   String
     action                 Symbol
   end

where

* ``windows_path`` is the resource
* ``'name'`` is the name of the resource block
* ``path`` is the path to be added/removed from the *path* environment variable.

Actions
=====================================================
This resource has the following actions:

``:add``
   Add an item to the system path

``:remove``
   Remove an item from the system path

Properties
=====================================================
This resource has the following properties:

``path``
   **Ruby Type:** String
   Name attribute. The name of the value to add to the system path

Examples
=====================================================

.. tag windows_path_examples

**Add Sysinternals to the system path**

.. code-block:: ruby

   windows_path 'C:\Sysinternals' do
     action :add
   end

**Remove 7-Zip from the system path**

.. code-block:: ruby

   windows_path 'C:\7-Zip' do
     action :remove
   end

.. end_tag
