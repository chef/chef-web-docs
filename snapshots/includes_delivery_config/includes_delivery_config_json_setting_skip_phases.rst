.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``skip_phases`` setting specifies which phases are skipped by Chef Automate during the execution of a change through the pipeline. If a phase is defined as skipped, this applies to all stages in the pipeline.

Currently, the ``functional.rb``, ``quality.rb``, ``security.rb``, and ``smoke.rb`` recipes are blank by default and should be set to skipped in the ``config.json`` file:

.. code-block:: javascript

   "skip_phases": [
     "functional",
     "quality",
     "security",
     "smoke"
   ]
