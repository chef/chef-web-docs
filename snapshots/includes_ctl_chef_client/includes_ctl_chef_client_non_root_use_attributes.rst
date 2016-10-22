.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Another example of running the chef-client as a non-root user involves using resources to pass sudo commands as as an attribute on the resource. For example, the **service** resource uses a series of ``_command`` attributes (like ``start_command``, ``stop_command``, and so on), the **package**-based resources use the ``options`` attribute, and the **script**-based resources use the ``code`` attribute.

A command can be elevated similar to the following:

.. code-block:: ruby

   service 'apache2' do
     start_command 'sudo /etc/init.d/apache2 start'
     action :start
   end

This approach can work very well on a case-by-case basis. The challenge with this approach is often around managing the size of the ``/etc/sudoers`` file.
