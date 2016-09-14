.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. Removed from 12.x chef-client docs.

Attribute accessor methods are automatically created and the method invocation can be used interchangeably with the keys. For example:

.. code-block:: ruby

   default.apache.dir          = '/etc/apache2'
   default.apache.listen_ports = [ '80','443' ]

This is a matter of style and preference for how attributes are reloaded from recipes, and may be seen when retrieving the value of an attribute.
