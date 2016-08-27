.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``have_binding`` matcher tests if the specified binding exists for the site:

.. code-block:: ruby

   it { should have_binding('http :80:*') }

or:

.. code-block:: ruby

   it { should have_binding('net.pipe *') }

A site may have multiple bindings; use a ``have_binding`` matcher for each unique site binding to be tested.
