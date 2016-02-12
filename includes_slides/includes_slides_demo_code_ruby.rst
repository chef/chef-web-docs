.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

|ruby| code:

.. code-block:: ruby

   some 'ruby' do
     stuff
   end

For example, a |windows powershell_dsc| script:

.. code-block:: ruby
       
   dsc_script 'emacs' do
     code <<-EOH
       Environment 'texteditor'
         {
           Name = 'EDITOR'
           Value = 'c:\\emacs\\bin\\emacs.exe'
         }
     EOH
   end
