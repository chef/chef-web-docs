.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


A |policyfile rb| is a |ruby| file, in which a run-list and cookbook locations are specified. The syntax is as follows:

.. code-block:: ruby

   name "name"
   run_list "ITEM", "ITEM", ...
   default_source :SOURCE_TYPE, *args
   cookbook "NAME" [, "VERSION_CONSTRAINT"] [, SOURCE_OPTIONS]
