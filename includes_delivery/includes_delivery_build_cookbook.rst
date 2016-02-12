.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|chef delivery| uses the |chef client| to run recipes for each phase in a build pipeline. The phases are grouped into different stages. 

The following illustration shows the phases of each pipeline stage.

.. image:: ../../images/delivery_build_cookbook.svg
   :width: 600px
   :align: center

The recipes for these phases are run from the build cookbook. Build cookbooks vary by project type, because projects may use different tools for running unit tests, syntax checks, or lint analysis.
