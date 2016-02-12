.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A cookbook template is an |erb| template that is used to dynamically generate static text files. Templates may contain |ruby| expressions and statements, and are a great way to manage configuration files. Use the |resource template| resource to add cookbook templates to recipes; place the corresponding |erb| template file in a cookbook's ``/templates`` directory.
