.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Using the |resource dsc_resource| has the following requirements:

* |windows management_framework| 5.0 February Preview (or higher), which includes |windows powershell| 5.0.10018.0 (or higher).
* The ``RefreshMode`` configuration setting in the Local Configuration Manager must be set to ``Disabled``.

  **NOTE:** Starting with the |chef client| 12.6 release, this requirement applies only for versions of |windows powershell| earlier than 5.0.10586.0. The latest version of |windows management_framework| 5 has relaxed the limitation that prevented the |chef client| from running in non-disabled refresh mode.

* The |resource dsc_script| resource  may not be used in the same run-list with the |resource dsc_resource|. This is because the |resource dsc_script| resource requires that ``RefreshMode`` in the Local Configuration Manager be set to ``Push``, whereas the |resource dsc_resource| resource requires it to be set to ``Disabled``.

  **NOTE:** Starting with the |chef client| 12.6 release, this requirement applies only for versions of |windows powershell| earlier than 5.0.10586.0. The latest version of |windows management_framework| 5 has relaxed the limitation that prevented the |chef client| from running in non-disabled refresh mode, which allows the Local Configuration Manager to be set to ``Push``.

* The |resource dsc_resource| resource can only use binary- or script-based resources. Composite |windows powershell_dsc_short| resources may not be used.

  This is because composite resources aren't "real" resources from the perspective of the the |windows powershell_lcm|. Composite resources are used by the "configuration" keyword from the ``PSDesiredStateConfiguration`` module, and then evaluated in that context. When using |windows powershell_dsc_short| to create the configuration document (the |windows powershell_mof| file) from the configuration command, the composite resource is evaluated. Any individual resources from that composite resource are written into the |windows powershell_mof| document. As far as the |windows powershell_lcm| is concerned, there is no such thing as a composite resource. Unless that changes, the |resource dsc_resource| resource and/or ``Invoke-DscResource`` command cannot directly use them.
