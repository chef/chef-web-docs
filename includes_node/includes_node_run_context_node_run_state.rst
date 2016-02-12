.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


Use ``node.run_state`` to stash transient data during a |chef client| run. This data may be passed between resources, and then evaluated during the execution phase. ``run_state`` is an empty |ruby hash| that is always discarded at the end of the |chef client| run.

For example, the following recipe will install the |apache| web server, randomly choose |php| or |perl| as the scripting language, and then install that scripting language:

.. code-block:: ruby

   package 'httpd' do
     action :install
   end
   
   ruby_block 'randomly_choose_language' do
     block do
       if Random.rand > 0.5
         node.run_state['scripting_language'] = 'php'
       else
         node.run_state['scripting_language'] = 'perl'
       end
     end
   end
   
   package 'scripting_language' do
     package_name lazy { node.run_state['scripting_language'] }
     action :install
   end

where:

* The |resource ruby_block| resource declares a ``block`` of |ruby| code that is run during the execution phase of the |chef client| run
* The ``if`` statement randomly chooses |php| or |perl|, saving the choice to ``node.run_state['scripting_language']``
* When the |resource package| resource has to install the package for the scripting language, it looks up the scripting language and uses the one defined in ``node.run_state['scripting_language']``
* ``lazy {}`` ensures that the |resource package| resource evaluates this during the execution phase of the |chef client| run (as opposed to during the compile phase)

When this recipe runs, the |chef client| will print something like the following:

.. code-block:: bash

   * ruby_block[randomly_choose_language] action run
    - execute the ruby block randomly_choose_language
   
   * package[scripting_language] action install
    - install version 5.3.3-27.el6_5 of package php
