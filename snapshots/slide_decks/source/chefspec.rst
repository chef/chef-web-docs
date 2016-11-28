================================================
ChefSpec
================================================

.. revealjs::

 .. revealjs:: ChefSpec Training

  .. tag slides_core_splash

  .. Use this slide as the very first slide in every slide deck. The title of this slide (as included in the slide map file) is what identifies the training.

  .. image:: ../../images/slides_splash.png

  .. end_tag

 .. revealjs:: About ChefSpec

  .. tag chefspec_1

  Use ChefSpec to simulate the convergence of resources on a node:

  * Runs the chef-client on a local machine
  * Uses chef-zero or chef-solo
  * Is an extension of RSpec, a behavior-driven development (BDD) framework for Ruby
  * Is the fastest way to test resources and recipes

  .. end_tag

 .. revealjs:: Compare ChefSpec and Serverspec

  * What is the primary difference between ChefSpec and Serverspec?
  * Why use ChefSpec if you already have Serverspec tests?
  * Do passing ChefSpec tests ensure your recipe will work?
  * How would you feel about removing some of your Serverspec tests now that you have ChefSpec in place?

 .. revealjs:: Objectives

    * Create a ChefSpec directory
    * Write a ChefSpec test
    * Run a ChefSpec test
    * Inspect the test results

 .. revealjs:: Move to the Proper Directory

  .. tag slides_cookbook_apache_directory_open

  Run:

  .. code-block:: bash

     $ cd ~/chef-repo/cookbooks/apache

  .. end_tag

 .. revealjs:: Create the ChefSpec Test Directory

  Run:

  .. code-block:: bash

     $ mkdir -p spec/unit

 .. revealjs:: Write a ChefSpec Test

  #. Open ``spec/unit/default.rb``.
  #. Add:

     .. code-block:: ruby

        require 'chefspec'

        describe 'apache::default' do
          let(:chef_run) do
            ChefSpec::Runner.new.converge(described_recipe)
          end

          it 'installs apache' do
            expect(chef_run).to install_package('httpd')
          end
        end

  #. Save the file.

 .. revealjs:: Run the ChefSpec Test

  Run:

  .. code-block:: bash

     rspec spec/unit/*.rb

  Returns:

  .. code-block:: none

     .

     Finished in 0.00865 seconds (files took 5.5 seconds to load)
     1 example, 0 failures

 .. revealjs:: Break the Cookbook

  #. Open ``recipes/default.rb``.
  #. Add:

     .. code-block:: ruby

        package 'http'

        service 'httpd' do
          action :start
        end

        template '/var/www/html/index.html' do
          source 'index.html.erb'
        end

  #. Save the file.

 .. revealjs:: Run the ChefSpec Test (Again)

  Run:

  .. code-block:: bash

     $ rspec spec/unit/*.rb

  Returns:

  .. code-block:: none

     Failures:

       1) apache::default installs apache
         Failure/Error: expect(chef_run).to install_package('httpd')
           expected "package[httpd]" with action :install to be in Chef run.
             Other package resources:

             package[http]

           # ./spec/unit/default_spec.rb:9:in 'block in <top (required)>'

         Finished in 0.00847 seconds (files took 4.85 seconds to load)
         1 example, 1 failure

         Failed examples:

         rspec ./spec/unit/default_spec.rb:8 # apache::default installs apache

 .. revealjs:: Fix the Cookbook

  #. Open ``recipes/default.rb``.
  #. Add:

     .. code-block:: ruby

        package 'httpd'

        service 'httpd' do
          action :start
        end

        template '/var/www/html/index.html' do
          source 'index.html.erb'
        end

  #. Save the file.

 .. revealjs:: Recap

    * Create a ChefSpec directory
    * Write a ChefSpec test
    * Run a ChefSpec test
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

 .. revealjs:: More Info About ChefSpec

    For more information, see:

    * |url slides_docs_chefspec|
    * |url slides_chefspec|
