.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A custom resource is created by the ``action`` block of a custom provider. When the resource collection is compiled, a custom resource is inserted into the top-level resource collection after the point at which the custom provider is associated. For example, if a resource collection looks like::

   top_level_resource_one
     lwrp_resource
   top_level_resource_two

then when ``lwrp_resource`` is executed, the resource collection will be modified as follows::

   top_level_resource_one           # already processed
     lwrp_resource                  # already processed
       embedded_resource_one        # created by the custom provider
       embedded_resource_two        # created by the custom provider
   top_level_resource_two

In this situation, embedded custom resources cannot notify the top-level resource because the top-level resource has finished processing. This has the same effect as if the top-level resource collection were invisible to the embedded custom resources.
