.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

This resource has the following actions:

``:delete``
   Send a ``DELETE`` request.

``:get``
   Default. Send a ``GET`` request.

``:head``
   Send a ``HEAD`` request.

``:nothing``
   .. include:: ../../includes_resources_common/includes_resources_common_actions_nothing.rst

``:options``
   Send an ``OPTIONS`` request.

``:post``
   Send a ``POST`` request.

``:put``
   Send a ``PUT`` request.

.. warning:: The ``:get`` and ``:head`` actions appended a hard-coded query string---``?message=resource_name``---that cannot be overridden. This hard-coded string is deprecated in the chef-client 12.0 release. Cookbooks that rely on this string need to be updated to manually add it to the URL as it is passed to the resource.
