.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


To ensure that an embedded custom resource can notify the top-level resource add ``use_inline_resources`` to the top of the file that defines the custom provider that is associated with that custom resource. When ``use_inline_resources`` is added to the file, the code in the custom provider's ``action`` block will execute as part of a self-contained chef-client run. If any embedded custom resources are updated, the top-level custom resource is marked as updated and notifications set for the top-level resource will be triggered normally. This ensures that notifications work properly across the resource collection.

For example:

.. code-block:: ruby

   use_inline_resources

   action :run do
     # Ruby code that implements the provider
   end

.. warning:: The ``use_inline_resources`` method was added to the chef-client starting in version 11.0 to address the behavior described below. The ``use_inline_resources`` method should be considered a requirement for any custom resource authored against the 11.0+ versions of the chef-client. This behavior will become the default behavior in an upcoming version of the chef-client.
