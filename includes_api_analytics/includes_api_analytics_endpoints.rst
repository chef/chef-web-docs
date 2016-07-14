.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Each organization-specific authentication request must include ``/organizations/NAME`` as part of the name for the endpoint. For example, the full endpoint for editing a rule:

.. code-block:: html

   PUT /organizations/NAME/rules/ID

where ``NAME`` is the name of the organization and ``ID`` is the identifier for the rule to be edited.