.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


When using the ``not_if`` and ``only_if`` guards with the **execute** resource, the current working directory property (``cwd``) is **not** inherited from the resource. For example:

.. code-block:: ruby

   execute 'bundle install' do
     cwd '/myapp'
     not_if 'bundle check' # This is not run inside /myapp
   end
