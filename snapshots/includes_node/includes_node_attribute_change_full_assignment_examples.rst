.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following examples show how to remove all attribute precedence levels.

**Just one component**

Given the following code structure:

.. code-block:: ruby

   node.default['foo']['bar'] = {'a' => 'b'}
   node.default!['foo']['bar'] = {'c' => 'd'}

The ``'!'`` caused the entire 'bar' key to be overwritten:
.. code-block:: ruby

   node['foo'] #=> {'bar' => {'c' => 'd'}


**Multiple components; one "after"**

Given the following code structure:

.. code-block:: ruby

   node.default['foo']['bar'] = {'a' => 'b'}
   # Please don't ever do this in real code :)
   node.role_default['foo']['bar'] = {'c' => 'd'}
   node.default!['foo']['bar'] = {'d' => 'e'}

The ``'!'`` write overwrote the "cookbook-default" value of ``'bar'``, but since role data is later in the resolution list, it was unaffected:

.. code-block:: ruby

   node['foo'] #=> {'bar' => {'c' => 'd', 'd' => 'e'}


**Multiple components; all "before"**

Given the following code structure:

.. code-block:: ruby

   node.default['foo']['bar'] = {'a' => 'b'}
   # Please don't ever do this in real code :)
   node.role_default['foo']['bar'] = {'c' => 'd'}
   node.force_default!['foo']['bar'] = {'d' => 'e'}

With ``force_default!`` there is no other data under ``'bar'``:

.. code-block:: ruby

   node['foo'] #=> {'bar' => {'d' => 'e'}


**Multiple precedence levels**

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

And some attributes:

.. code-block:: ruby

   # Please don't ever do this in real code :)
   node.role_default['foo']['bar']['baz'] = 55
   node.force_default['foo']['bar']['baz'] = 66

And other precedence levels:

.. code-block:: ruby

   node.normal['foo']['bar']['baz'] = 88
   node.override['foo']['bar']['baz'] = 99

With a full assignment:

.. code-block:: ruby

   node.default!['foo']['bar'] = {}

Role default and force default are left in default, plus other precedence levels:

.. code-block:: ruby

   node.attributes.combined_default['foo'] #=> {'bar' => {'baz' => 66}, 'bat'=>{'things'=>[5, 6]}}
   node.attributes.normal['foo'] #=> {'bar' => {'baz' => 88}}
   node.attributes.combined_override['foo'] #=> {'bar' => {'baz' => 99}}
   node['foo']['bar'] #=> {'baz' => 99}

If ``force_default!`` is written:

.. code-block:: ruby

   node.force_default!['foo']['bar'] = {}

the difference is:

.. code-block:: ruby

   node.attributes.combined_default['foo'] #=> {'bat'=>{'things'=>[5, 6]}, 'bar' => {}}
   node.attributes.normal['foo'] #=> {'bar' => {'baz' => 88}}
   node.attributes.combined_override['foo'] #=> {'bar' => {'baz' => 99}}
   node['foo']['bar'] #=> {'baz' => 99}


