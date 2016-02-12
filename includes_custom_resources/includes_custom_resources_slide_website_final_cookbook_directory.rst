.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file is hooked into a slide deck


When finished adding the templates and building the custom resource, the cookbook directory structure should look like this:

.. code-block:: text

   /website
     metadata.rb
     /recipes
       default.rb
     README.md
     /resources
       httpd.rb
     /templates
       /default
         httpd.conf.erb
         httpd.service.erb
