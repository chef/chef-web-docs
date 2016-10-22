.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A block is arbitrary Ruby defined within the resource block by using the ``verify`` property. When a block is ``true``, the chef-client will continue to update the file as appropriate.

For example, this should return ``true``:

.. code-block:: ruby

   template '/tmp/baz' do
     verify { 1 == 1 }
   end

This should return ``true``:

.. code-block:: ruby

   template '/etc/nginx.conf' do
     verify 'nginx -t -c %{path}'
   end

.. warning:: For releases of the chef-client prior to 12.5 (chef-client 12.4 and earlier) the correct syntax is:

   .. code-block:: ruby

      template '/etc/nginx.conf' do
        verify 'nginx -t -c %{file}'
      end

   See GitHub issues https://github.com/chef/chef/issues/3232 and https://github.com/chef/chef/pull/3693 for more information about these differences.

This should return ``true``:

.. code-block:: ruby

   template '/tmp/bar' do
     verify { 1 == 1}
   end

And this should return ``true``:

.. code-block:: ruby

   template '/tmp/foo' do
     verify do |path|
       true
     end
   end

Whereas, this should return ``false``:

.. code-block:: ruby

   template '/tmp/turtle' do
     verify '/usr/bin/false'
   end

If a string or a block return ``false``, the chef-client run will stop and an error is returned.
