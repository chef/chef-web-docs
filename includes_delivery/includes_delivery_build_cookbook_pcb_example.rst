.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This example shows how to create a new cookbook (in the example, "maelstrom"), and make an initial commit using the ``pcb`` cookbook.

.. code-block:: bash

   chef generate cookbook maelstrom
   cd maelstrom
   git add .
   git commit -m 'A swirling vortex of rain'
   delivery setup --ent ENTERPRISE --org ORGNAME --server delivery.example.com --user USERNAME --for master
   echo '.delivery/cli.toml' >> .gitignore
   delivery token
   delivery init

If the project is a cookbook like our example, this will generate the ``.delivery/build-cookbook`` as specified as a wrapper for ``delivery-truck``. If the project is something else, such as a |java| or |ruby on rails| application, the ``.delivery/build-cookbook`` will be an empty skeleton. Either way, it can then be modified as required to run the project through the various phases of |chef delivery|.
