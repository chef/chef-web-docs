.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The ``have_path`` matcher tests if the named path is defined for the site:

.. code-block:: ruby

   it { should have_path('C:\\inetpub\\wwwroot') }
