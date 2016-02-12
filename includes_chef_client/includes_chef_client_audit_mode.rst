.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |chef client| may be run in |chef client_audit|. Use |chef client_audit| to evaluate custom rules---also referred to as audits---that are defined in recipes. |chef client_audit| may be run in the following ways:

* By itself (i.e. a |chef client| run that does not build the resource collection or converge the node)
* As part of the |chef client| run, where |chef client_audit| runs after all resources have been converged on the node

Each audit is authored within a recipe using the ``control_group`` and ``control`` methods that are part of the |dsl recipe|. Recipes that contain audits are added to the run-list, after which they can be processed by the |chef client|. Output will appear in the same location as the regular |chef client| run (as specified by the ``log_location`` setting in the |client rb| file).

Finished audits are reported back to the |chef server|. From there, audits are sent to the |chef analytics| platform for further analysis, such as rules processing and visibility from the actions web user interface.

