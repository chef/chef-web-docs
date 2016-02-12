.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

When using the ``bootstrap::server`` recipe, this is actually a randomly generated password, and set in ``/etc/chef/server.rb`` through the template, with the setting ``web_ui_admin_default_password``. This can be set to a different value by setting ``webui_admin_password`` in the ``chef.json``.
