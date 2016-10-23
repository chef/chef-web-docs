.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.
.. This file is hooked into a slide deck


The custom resource name is inferred from the name of the cookbook (``website``), the name of the recipe (``httpd``), and is separated by an underscore(``_``): ``website_httpd``.

.. code-block:: ruby

   website_httpd 'httpd_site' do
     port 81
     action :create
   end

which does the following:

* Installs Apache httpd
* Assigns an instance name of ``httpd_site`` that uses port 81
* Configures httpd and systemd from a template
* Creates the virtual host for the website
* Starts the website using systemd
