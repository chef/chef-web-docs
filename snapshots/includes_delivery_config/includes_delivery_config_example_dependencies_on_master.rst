.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows a run-time dependency against the master branch of a project named ``BackendAPI``:

.. code-block:: javascript

   {
     "version": "2",
     "build_cookbook": {
       "name": "build-cookbook",
       "path": ".delivery/build-cookbook"
     },
     "skip_phases": [],
     "dependencies": ["BackendAPI"]
   }

