.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Child processes inherit a copy of their parent's environment. In |bash| (and other shells) the environment is accessible via shell variables. Shell variables can be added to the environment that is inherited by children processes using the export keyword.

Consider the following example:

.. code-block:: bash

   % WOO="woo" #Set a shell variable
   % echo $WOO
   woo
   % bash #Start a new process, a child of our first shell
   % echo $WOO # Shell variable is empty because we didn't export it
   
   % exit # Return to original shell
   exit
   % export WOO # Export variable 
   % bash
   % echo $WOO #Shell variable now available in children.
   woo
   % exit

As mentioned, the child process gets a copy of its parent's environment. This means that any changes made to that environment do not affect the parent process. For example:

.. code-block:: bash

   % WOO="woo" #Set a shell variable
   % echo $WOO
   woo
   % bash #Start a new process, a child of our first shell
   % export WOO="hello" # Change and export the shell variable
   % exit # Return to original shell
   exit
   % echo $WOO #The parent's value remains unchanged.
   woo
   % exit

The principles mentioned above (a child process receives a copy of its parent's environment and cannot affect their parent's environment) apply in |ruby| just as they do in |bash|.

In |ruby|, the current environment can be altered via the ``ENV`` variable. Any changes made to the environment will also be available to child process started by the |chef client|. For example, consider the following recipe:

.. code-block:: ruby

   ENV['FOO'] = 'bar'
   bash 'env_test0' do
     code <<-EOF
     echo $FOO
   EOF
   end

When run, the |resource script_bash| resource will correctly ``echo 'bar'`` to its standard output.

However, just as in |bash|, changes made in child processes have no affect on the parent, and thus no affect on subsequent child processes:

.. code-block:: ruby

   bash 'env_test1' do
     code <<-EOF
     export BAZ='bar'
   EOF
   end
   
   bash 'env_test2' do
     code <<-EOF
     echo $BAZ
   EOF
   end

When run, the second |resource script_bash| resource will not cause anything to be echoed to standard out as ``BAZ`` is not part of its environment.
