.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A start handler can be configured in the client.rb file by adding the following setting:

.. list-table::
   :widths: 200 300
   :header-rows: 1

   * - Setting
     - Description
   * - ``start_handlers``
     - A list of start handlers that are available to the chef-client at the start of a chef-client run.

For example, the Reporting start handler adds the following code to the top of the client.rb file:

.. code-block:: ruby

   begin
     require 'chef_reporting'
     start_handlers << Chef::Reporting::StartHandler.new()
   rescue LoadError
     Chef::Log.warn 'Failed to load #{lib}. This should be resolved after a chef run.'
   end

This ensures that when the chef-client run begins the ``chef_reporting`` event handler is enabled. The ``chef_reporting`` event handler is part of a gem named ``chef-reporting``. The **chef_gem** resource is used to install this gem:

.. code-block:: ruby

   chef_gem 'chef-reporting' do
     action :install
   end
