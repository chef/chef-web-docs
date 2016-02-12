.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


#. Open ``~/git.rb``.
#. Add:

   .. code-block:: ruby
   
      package 'git' do
        action :install
      end
      
      file '/home/chef/.gitconfig' do
        content '[user]\n  name=John Doe\n  email=jdoe@example\n'
        user 'chef'
        group 'chef'
      end

#. Save the file.
