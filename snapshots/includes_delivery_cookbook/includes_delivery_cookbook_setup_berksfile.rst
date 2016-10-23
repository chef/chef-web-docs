.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The Berksfile for a ``build-cookbook`` is located at ``.delivery/build-cookbook/Berksfile``. Update it to include:

.. code-block:: ruby

   source "https://supermarket.chef.io"

   metadata

   cookbook 'delivery-truck', github: 'chef-cookbooks/delivery-truck'
   cookbook 'delivery-sugar', github: 'chef-cookbooks/delivery-sugar'

This will ensure that the latest versions of the ``delivery-truck`` and ``delivery-sugar`` cookbooks are pulled into the ``build-cookbook`` every time a change is sent to the Chef Automate project pipeline.
