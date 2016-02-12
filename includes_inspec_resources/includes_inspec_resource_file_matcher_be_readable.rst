.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``be_readable`` matcher tests if the file is readable:

.. code-block:: ruby

   it { should be_readable }

The ``be_readable`` matcher may also test if the file is readable by a specific owner, group, or user. For example, a group:

.. code-block:: ruby

   it { should be_readable.by('group') }

an owner:

.. code-block:: ruby

   it { should be_readable.by('owner') }

a user:

.. code-block:: ruby

   it { should be_readable.by_user('user') }
