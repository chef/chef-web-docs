.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A template helper module can be defined in a library. This is useful when extensions need to be reused across recipes or to make it easier to manage code that would otherwise be defined inline on a per-recipe basis.

.. code-block:: ruby

   template '/path/to/template.erb' do
     helpers(MyHelperModule)
   end
