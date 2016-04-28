.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


In |delivery| there are multiple levels of organization: enterprises, organizations, and projects, where enterprise contain one (or more) organizations and organizations contain one (or more) projects. The provisioning step created the initial enterprise you specified in your environment file as the first ``name`` option. Enterprises are designed to provide units of multi-tenancy with separate sets of organizations and users. Next, set up |delivery| by adding users and organizations.

.. note:: |delivery| by default hosts a |git| server that you interact with through the |delivery_cli| commands. Additionally, you can integrate |github enterprise| or GitHub.com.
