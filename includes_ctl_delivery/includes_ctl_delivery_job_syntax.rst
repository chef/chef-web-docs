.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This subcommand has the following syntax:

.. code-block:: bash

   $ delivery job STAGE PHASE (options)

where:

* ``STAGE`` is a stage in the |chef delivery| pipeline: Verify, Build, Acceptance, Union, Rehearsal, Delivered
* ``PHASE`` is a phase, which runs recipes, in a |chef delivery| stage
