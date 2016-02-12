.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``be_executable`` matcher tests if the file exists as an executable:

.. code-block:: ruby

   it { should be_executable }

The ``be_executable`` matcher may also test if the file is executable by a specific owner, group, or user. For example, a group:

.. code-block:: ruby

   it { should be_executable.by('group') }

an owner:

.. code-block:: ruby

   it { should be_executable.by('owner') }

a user:

.. code-block:: ruby

   it { should be_executable.by_user('user') }
