================================================
Serverspec
================================================

.. revealjs::

 .. revealjs:: Serverspec Training

  .. image:: ../../images/slides_splash_serverspec.png

 .. revealjs:: About Serverspec

  .. tag slides_serverspec

  .. There is no comparision topic in chef-docs from which we can single-source this content, though there should be!

  Use Serverspec to write tests that verify machines:

  * Natively defines many resource types: package, service, user, etc.
  * Works well with Kitchen
  * Is not dependent on Chef

  .. end_tag

 .. revealjs:: Objectives

    * Verify node state
    * Create a Serverspec directory
    * Write a Serverspec test
    * Run a Serverspec test
    * Inspect the test results

 .. revealjs:: Login to Kitchen

  .. tag slides_kitchen_login

  Run:

  .. code-block:: bash

     $ kitchen login

  Returns:

  .. code-block:: none

     kitchen@localhost's password:

  Enter: ``kitchen``.

  .. end_tag

 .. revealjs:: Manually Inspect the Test Node

  Run:

  .. code-block:: bash

     $ curl http://localhost

  Returns:

  .. code-block:: none

     curl: (7) couldn't connect to host

 .. revealjs:: Converge the Node

  .. image:: ../../images/kitchen_diagram_07.png

 .. revealjs:: Verify Node State

  * Problem: Manually verifying the state of a node is tedious and error-prone.
  * Success criteria: The end state of the node is automatically tested.

 .. revealjs:: Exit Kitchen

  .. tag slides_kitchen_exit

  Run:

  .. code-block:: bash

     $ exit

  Returns:

  .. code-block:: none

     logout
     Connection to localhost closed.

  .. end_tag

 .. revealjs:: Move to the Proper Directory

  .. tag slides_cookbook_apache_directory_open

  Run:

  .. code-block:: bash

     $ cd ~/chef-repo/cookbooks/apache

  .. end_tag

 .. revealjs:: Create the Serverspec Test Directory

  Run:

  .. code-block:: bash

     $ mkdir -p test/integration/default/serverspec

  Kitchen will look in the ``test/integration`` directory for test-related files.

 .. revealjs:: Suite Subdirectory

  The next level subdirectory will match the suite name:

  .. code-block:: none

     test/
       └── integration
           └── default
               └── serverspec
                   └── default_spec.rb

  .. code-block:: yaml

     suites:
       - name: default
         run_list:
           - recipe[apache::default]

 .. revealjs:: Busser Subdirectory

  Kitchen utilizes bussers to manage test plugins. We'll be using the ``serverspec`` plugin:

  .. code-block:: none

     test/
       └── integration
           └── default
               └── serverspec
                   └── default_spec.rb

  .. code-block:: yaml

     suites:
       - name: default
         run_list:
           - recipe[apache::default]

 .. revealjs:: Write a Serverspec Test (Part One)

  #. Open ``test/integration/default/serverspec/default_spec.rb``.
  #. Add:

     .. code-block:: ruby

        require 'serverspec'
        set :backend, :exec

        describe 'apache' do

        end

  #. Save the file.

 .. revealjs:: Write the Generic Expectation Form

  .. code-block:: ruby

     describe '<subject>' do
       it '<description>' do
         expect(thing).to eq result
       end
     end

 .. revealjs:: Write a Serverspec Test (Part Two)

  #. Open ``test/integration/default/serverspec/default_spec.rb``.
  #. Add:

     .. code-block:: ruby

        require 'serverspec'
        set :backend, :exec

        describe 'apache' do
          it 'is awesome' do
            expect(true).to eq true
          end
        end

  #. Save the file.

 .. revealjs:: Run the Serverspec Test

  .. tag slides_kitchen_verify_serverspec

  Run:

  .. code-block:: bash

     $ kitchen verify

  Returns:

  .. code-block:: none

     -----> Running serverspec test suite
            /opt/chef/embedded/bin/ruby -I/tmp/busser/suites/serverspec 
           -I/tmp/busser/gems/gems/rspec-support-3.1.2/lib:/tmp/busser/gems/gems/rspec-core-3.1.7/lib    
           /opt/chef/embedded/bin/rspec --pattern /tmp/busser/suites/serverspec/\*\*/\*_spec.rb --color 
           --format documentation --default-path /tmp/busser/suites/serverspec

       apache
         is awesome

       Finished in 0.02823 seconds (files took 0.99875 seconds to load)
       1 example, 0 failures
       Finished verifying <default-centos-64> (0m5.03s).

  .. end_tag

 .. revealjs:: Inspect the Test Results

  We want a custom home page available on the web:

  * Is the package installed?
  * Does the page display?
  * What else?

 .. revealjs:: Verify the Package is Installed

  #. Open ``test/integration/default/serverspec/default_spec.rb``.
  #. Add:

     .. code-block:: ruby

        require 'serverspec'
        set :backend, :exec

        describe 'apache' do
          it 'is awesome' do
            expect(true).to eq true
          end

          it 'is installed' do
            expect(package('httpd')).to be_installed
          end
        end

  #. Save the file.

 .. revealjs:: Verify the Test

  .. tag slides_kitchen_verify_serverspec

  Run:

  .. code-block:: bash

     $ kitchen verify

  Returns:

  .. code-block:: none

     -----> Running serverspec test suite
            /opt/chef/embedded/bin/ruby -I/tmp/busser/suites/serverspec 
           -I/tmp/busser/gems/gems/rspec-support-3.1.2/lib:/tmp/busser/gems/gems/rspec-core-3.1.7/lib    
           /opt/chef/embedded/bin/rspec --pattern /tmp/busser/suites/serverspec/\*\*/\*_spec.rb --color 
           --format documentation --default-path /tmp/busser/suites/serverspec

       apache
         is awesome

       Finished in 0.02823 seconds (files took 0.99875 seconds to load)
       1 example, 0 failures
       Finished verifying <default-centos-64> (0m5.03s).

  .. end_tag

 .. revealjs:: Is the Test Failing? Make it Pass!

  Test-driven development involves:

  * Write a test to verify something is working
  * Watch the test fail
  * Write just enough code to make the test pass
  * Repeat!

 .. revealjs:: Update the Cookbook

  #. Open ``~/chef-reop/cookbooks/apache/recipes/default.rb``.
  #. Add:

     .. code-block:: ruby

        package 'httpd'

  #. Save the file.

 .. revealjs:: Converge the Node (Again)

  Run:

  .. code-block:: bash

     $ kitchen converge

  Returns:

  .. code-block:: none

     -----> Converging <default-centos-64>...
            Preparing files for transfer
            Resolving cookbook dependencies with Berkshelf 3.1.5...
            Removing non-cookbook files before transfer
            Transfering files to <default-centos-64>
            [2014-11-10T09:20:26+00:00] INFO: Starting chef-zero on host localhost
              port 8889 with repository at repository at /tmp/kitchen
              One version per cookbook

            [2014-11-10T09:20:26+00:00] INFO: Forking chef instance to converge...
            Starting Chef Client, version 11.16.4
            [2014-11-10T09:20:27+00:00] INFO: *** Chef 11.16.4 ***
            [2014-11-10T09:20:27+00:00] INFO: Chef-client pid: 571
      ...

 .. revealjs:: Verify the Test (Again)

  Run:

  .. code-block:: bash

     $ kitchen verify

  Returns:

  .. code-block:: none

     apache
       is awesome
       is installed (FAILED - 1)

       Failures:

         1) apache is installed
           Failure/Error: expect(package("httpd")).to be_installed
             expected Package "httpd" to be installed
             /bin/sh -c rpm\ -q\ httpd
             package httpd is not installed

 .. revealjs:: What Else Should Be Tested?

  * Is the service running?
  * Is the port accessible?
  * Is the expected content being served?
  * Make sure everything works from a fresh Kitchen, too!

 .. revealjs:: Extend the Serverspec Test

  #. Open ``test/integration/default/serverspec/default_spec.rb``.
  #. Add:

     .. code-block:: ruby

        describe 'apache' do
          it 'is installed' do
            expect(package 'httpd').to be_installed
          end

          it 'is running' do
            expect(service 'httpd').to be_running
          end

          it 'is listening on port 80' do
            expect(port 80).to be_listening
          end

          it 'displays a custom home page' do
            expect(command('curl localhost').stdout).to match /hello/
          end
        end

  #. Save the file.

 .. revealjs:: Verify the Test (Again)

  Run:

  .. code-block:: bash

     $ kitchen verify

  Returns:

  .. code-block:: none

     apache
              is awesome
              is installed

            Finished in 0.48165 seconds (files took 1.05 seconds to load)
            2 examples, 0 failures
            Finished verifying <default-centos-64> (0m5.64s).
     -----> Kitchen is finished. (0m11.84s)

 .. revealjs:: Recap

    * Verify node state by running Kitchen
    * Create a Serverspec directory
    * Write a Serverspec test
    * Run a Serverspec test
    * Inspect the test results

 .. revealjs:: Questions

  .. tag slides_core_questions

  .. Use this slide every time the slide deck stops for Q/A sessions with attendees.

  .. image:: ../../images/slides_questions.png

  .. end_tag

 .. revealjs:: Time to Hack

  .. tag slides_core_hack

  .. Use this slide every time the slide deck stops for Q/A sessions with attendees.

  .. image:: ../../images/slides_hack.png

  .. end_tag

 .. revealjs:: More Info About Serverspec

    For more information, see:

    * |url slides_docs_chef_io|
    * |url slides_serverspec|

