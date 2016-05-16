.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


.. To bump version metadata automatically:

.. code-block:: bash

   $ delivery review --auto-bump

will return something similar to:

.. code-block:: bash

   Chef Delivery
   Loading configuration from /Users/salimafiune/delivery/organizations/sandbox/coffee
   Project coffee is a cookbook
   Validating version in metadata
   The version hasn't been updated (0.1.0)
   Bumping version to: 0.1.1
   Review for change black targeted for pipeline master
   Created new patchset
   https://delivery.chef.co/e/URL_FOR_CHANGE
