.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A lightweight resource is created by the ``action`` block of a lightweight provider. When the resource collection is compiled, a lightweight resource is inserted into the top-level resource collection after the point at which the lightweight provider is associated. For example, if a resource collection looks like::

   top_level_resource_one
     lwrp_resource
   top_level_resource_two

then when ``lwrp_resource`` is executed, the resource collection will be modified as follows::

   top_level_resource_one           # already processed
     lwrp_resource                  # already processed
       embedded_resource_one        # created by the lightweight provider
       embedded_resource_two        # created by the lightweight provider
   top_level_resource_two

In this situation, embedded lightweight resources cannot notify the top-level resource because the top-level resource has finished processing. This has the same effect as if the top-level resource collection were invisible to the embedded lightweight resources.
