.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The **execute** resource cannot be used to source a file (e.g. ``command 'source filename'``). The following example will fail because ``source`` is not an executable:

.. code-block:: ruby

   execute 'foo' do
     command 'source /tmp/foo.sh'
   end

Instead, use the **script** resource or one of the **script**-based resources (**bash**, **csh**, **perl**, **python**, or **ruby**). For example:

.. code-block:: ruby

   bash 'foo' do
     code 'source /tmp/foo.sh'
   end
