.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows how to use ``not_if`` to guard against running the ``apt-get-update`` command when a file already exists that is the same as the updated file:

.. code-block:: ruby

   execute "apt-get-update" do
     command "apt-get update"
     ignore_failure true
     not_if do ::File.exists?('/var/lib/apt/periodic/update-success-stamp') end
   end

