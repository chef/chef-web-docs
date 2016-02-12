.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``where`` matcher allows the test to be focused to one (or more) specific items:

.. code-block:: ruby

   etc_group.where(item: 'value', item: 'value')

where ``item`` may be one (or more) of:

* ``name: 'name'``
* ``group_name: 'group_name'``
* ``password: 'password'``
* ``gid: 'gid'``
* ``group_id: 'gid'``
* ``users: 'user_name'``
* ``members: 'member_name'``
