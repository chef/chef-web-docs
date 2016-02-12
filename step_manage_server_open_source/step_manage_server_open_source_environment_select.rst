.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

On the header of the **Management Console**, there is an **Environment** drop down box where you can select either "none" or a specific environment.

If "none" is selected, the **Management Console** shows everything when you view nodes and cookbooks; if a specific environment is selected, the **Management Console** only shows the available objects in that environment for nodes and cookbooks. For cookbooks, if you do not define any restriction in the environment, the **Management Console** shows all cookbooks.

When viewing a specific role, the per environment run list for the selected environment shows up; if **none** or **_default** is selected in the **Environment** drop down box, or there is no environment specific run list for the selected environment, the role page shows the **_default** run list.

Objects other than nodes, cookbooks, and roles are not affected by the environment selection.
