.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following examples show how to remove a specific, named attribute precedence level.

**Delete a default value when only default values exist**

Given the following code structure under ``'foo'``:

.. code-block:: ruby

   node.default['foo'] = {
     'bar' => {
       'baz' => 52,
       'thing' => 'stuff',
     },
     'bat' => {
       'things' => [5, 6],
     },
   }

And some role attributes:

.. code-block:: ruby

   # Please don't ever do this in real code :)
   node.role_default['foo']['bar']['thing'] = 'otherstuff'

And a force attribute:

.. code-block:: ruby

   node.force_default['foo']['bar']['thing'] = 'allthestuff'

When the default attribute precedence ``node['foo']['bar']`` is removed:

.. code-block:: ruby

   node.rm_default('foo', 'bar') #=> {'baz' => 52, 'thing' => 'allthestuff'}

What is left under ``'foo'`` is only ``'bat'``:

.. code-block:: ruby

   node.attributes.combined_default['foo'] #=> {'bat' => { 'things' => [5,6] } }


**Delete default without touching higher precedence attributes**

Given the following code structure:

.. code-block:: ruby

   node.default['foo'] = {
     'bar' => {
       'baz' => 52,
       'thing' => 'stuff',
     },
     'bat' => {
       'things' => [5, 6],
     },
   }

And some role attributes:

.. code-block:: ruby

   # Please don't ever do this in real code :)
   node.role_default['foo']['bar']['thing'] = 'otherstuff'

And a force attribute:

.. code-block:: ruby

   node.force_default['foo']['bar']['thing'] = 'allthestuff'

And also some override attributes:

.. code-block:: ruby

   node.override['foo']['bar']['baz'] = 99

Same delete as before:

.. code-block:: ruby

   node.rm_default('foo', 'bar') #=> { 'baz' => 52, 'thing' => 'allthestuff' }

The other attribute precedence levels are unaffected:

.. code-block:: ruby

   node.attributes.combined_override['foo'] #=> { 'bar' => {'baz' => 99} }
   node['foo'] #=> { 'bar' => {'baz' => 99}, 'bat' => { 'things' => [5,6] }


**Delete override without touching lower precedence attributes**

Given the following code structure, which has an override attribute:

.. code-block:: ruby

   node.override['foo'] = {
     'bar' => {
       'baz' => 52,
       'thing' => 'stuff',
     },
     'bat' => {
       'things' => [5, 6],
     },
   }

with a single default value:

.. code-block:: ruby

   node.default['foo']['bar']['baz'] = 11

and a force at each attribute precedence:

.. code-block:: ruby

   node.force_default['foo']['bar']['baz'] = 55
   node.force_override['foo']['bar']['baz'] = 99

Delete the override:

.. code-block:: ruby

   node.rm_override('foo', 'bar') #=> { 'baz' => 99, 'thing' => 'stuff' }

The other attribute precedence levels are unaffected:

.. code-block:: ruby

   node.attributes.combined_default['foo'] #=> { 'bar' => {'baz' => 55} }


**Non-existent key deletes return nil**

.. code-block:: ruby

   node.rm_default("no", "such", "thing") #=> nil
