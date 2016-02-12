.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|serverspec| is a framework that tests cookbooks and recipes as part of an actual |chef client| run that takes place on a virtual machine. |serverspec| tests take as long to execute as the actual |chef client| run. When used as part of the cookbook authoring workflow, |serverspec| tests are often the best indicator of problems that would exist within a cookbook if it were to run in a production environment.
