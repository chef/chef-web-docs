.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file is hooked into a slide deck


The ``httpd.conf.erb`` template has two variables:

* ``<%= @instance_name %>``
* ``<%= @port %>``

They are:

* Declared as properties of the custom resource
* Defined as variables in a **template** resource block within the custom resource
* Tunable from a recipe when using ``port`` and ``instance_name`` as properties in that recipe
* ``instance_name`` defaults to the ``'name'`` of the custom resource if not specified as a property
