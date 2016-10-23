.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

In certain situations it may be useful to stop a chef-client run entirely by using an unhandled exception. The ``raise`` and ``fail`` keywords can be used to stop a chef-client run in both the compile and execute phases.

.. note:: Both ``raise`` and ``fail`` behave the same way when triggering unhandled exceptions and may be used interchangeably.

Use these keywords in a recipe---but outside of any resource blocks---to trigger an unhandled exception during the compile phase. For example:

.. code-block:: ruby

   file '/tmp/name_of_file' do
     action :create
   end
   
   raise "message" if node['platform'] == 'windows'
   
   package 'name_of_package' do
     action :install
   end

where ``node['platform'] == 'windows'`` is the condition that will trigger the unhandled exception.

Use these keywords in the **ruby_block** resource to trigger an unhandled exception during the execute phase. For example:

.. code-block:: ruby

   ruby_block "name" do
     block do
       # Ruby code with a condition, e.g. if ::File.exist?(::File.join(path, "/tmp"))
       fail "message"  # e.g. "Ordering issue with file path, expected foo"
     end
   end

Use these keywords in a class. For example:

.. code-block:: ruby

   class CustomError < StandardError; end

and then later on:

.. code-block:: ruby

   def custom_error
     raise CustomError, "error message"
   end

or:

.. code-block:: ruby

   def custom_error
     fail CustomError, "error message"
   end

