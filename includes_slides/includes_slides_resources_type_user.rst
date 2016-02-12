.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A user that should be managed:

.. code-block:: ruby
       
   user 'nginx' do
     comment 'Nginx <nginx@example.com>'
     uid '500'
     gid '500'
     supports :manage_home => true
   end
