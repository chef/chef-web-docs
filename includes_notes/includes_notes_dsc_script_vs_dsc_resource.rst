.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |resource dsc_script| resource  may not be used in the same run-list with the |resource dsc_resource|. This is because the |resource dsc_script| resource requires that ``RefreshMode`` in the Local Configuration Manager be set to ``Push``, whereas the |resource dsc_resource| resource requires it to be set to ``Disabled``.  
