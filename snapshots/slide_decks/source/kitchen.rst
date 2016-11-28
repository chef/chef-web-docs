================================================
Kitchen
================================================

.. revealjs::

 .. revealjs:: Kitchen Training

  .. image:: ../../images/slides_splash_kitchen.png

 .. revealjs:: About Kitchen

  .. tag test_kitchen

  Use `Kitchen <http://kitchen.ci>`_  to automatically test cookbook data across any combination of platforms and test suites:

  * Defined in a .kitchen.yml file
  * Uses a driver plugin architecture
  * Supports cookbook testing across many cloud providers and virtualization technologies
  * Supports all common testing frameworks that are used by the Ruby community
  * Uses a comprehensive set of base images provided by `Bento <https://github.com/chef/bento>`_

  .. end_tag

 .. revealjs:: Objectives

    * Follow a test-first/test-driven model to build a home page for a website
    * Understand Kitchen components
    * Understand Kitchen commands
    * Understand Kitchen workflow
    * Create the apache cookbook
    * Define a test matrix
    * Create the .kitchen.yml file
    * Install Docker to use with Kitchen
    * Create a test Kitchen instance
    * Apply policy
    * Run Kitchen
    * Update for the motd cookbook
    * Understand test results

 .. revealjs:: Success?

    * Is there a target machine running with the same platform as a production machine?
    * Does the chef-client have access to the cookbook?

 .. revealjs:: Kitchen Components

  * What is a driver?
  * What is a provisioner?
  * What are platforms?
  * What are suites?

 .. revealjs:: What does Kitchen Do?

  * ``kitchen login``
  * ``kitchen create``
  * ``kitchen list``
  * ``kitchen converge``
  * ``kitchen verify``
  * ``kitchen destroy``
  * ``kitchen test``

 .. revealjs:: Kitchen Workflow

  A typical Kitchen workflow:

  #. ``kitchen create``
  #. ``kitchen converge``
  #. ``kitchen verify``
  #. ``kitchen destroy``

  Use ``kitchen test`` to run all of these commands.

 .. revealjs:: Move to the Proper Directory

  .. tag slides_chef_repo_open_cookbooks

  Run:

  .. code-block:: bash

     $ cd ~/chef-repo/cookbooks

  .. end_tag

 .. revealjs:: Generate the Apache Cookbook

  .. tag slides_cookbook_apache_generate_cookbook

  Run:

  .. code-block:: bash

     $ chef generate cookbook apache

  Returns:

  .. code-block:: none

     Compiling Cookbooks...
     Recipe: code_generator::cookbook
       * directory[/home/chef/chef-repo/cookbooks/apache] action create
         - create new directory /home/chef/chef-repo/cookbooks/apache
         - restore selinux security context
       * template[/home/chef/chef-repo/cookbooks/apache/metadata.rb] action
         create_if_missing
         - create new file /home/chef/chef-repo/cookbooks/apache/metadata.rb
         - update content in /home/chef/chef-repo/cookbooks/apache/metadata.rb
           from none to 4c0e2d
         - restore selinux security context
       * template[/home/chef/chef-repo/cookbooks/apache/README.md] action
         create_if_missing
         - create new file /home/chef/chef-repo/cookbooks/apache/README.md
      ...

  .. end_tag

 .. revealjs:: Move to the Apache Directory

  Run:

  .. code-block:: bash

     $ cd apache

 .. revealjs:: Add the Cookbook to a Git Repo

  .. tag slides_github_commit_chef_repo_git_add

  Run:

  .. code-block:: bash

     $ git add .

  .. end_tag

 .. revealjs:: Commit the Cookbook to the Git Repo

  Run:

  .. code-block:: bash

     $ git commit –m "initial apache cookbook"

 .. revealjs:: Test Matrix - Two Platforms

  Two operating systems:

  * ubuntu-12.04
  * centos-6.4

 .. revealjs:: Test Matrix - Two Platforms, One Recipe

  Two operating systems and a recipe:

  * ubuntu-12.04
  * centos-6.4
  * apache::default

 .. revealjs:: Test Matrix - Two Platforms, Two Recipes

  Two operating systems and two recipes:

  * ubuntu-12.04
  * centos-6.4
  * apache::default
  * apache::ssl

 .. revealjs:: Test Matrix - Three Platforms, Two Recipes

  Three operating systems and two recipes:

  * ubuntu-12.04
  * ubuntu-14.04
  * centos-6.4
  * apache::default
  * apache::ssl

 .. revealjs:: .kitchen.yml

  The .kitchen.yml file defines the test coverage:

  .. code-block:: yaml

     ---
     driver:
       name: vagrant

     provisioner:
       name: chef_zero

     platforms:
       - name: ubuntu-12.04
       - name: centos-6.4

     suites:
       - name: default
         run_list:
           - recipe[apache::default]
         attributes:

 .. revealjs:: Create .kitchen.yml

  #. Open ``apache/.kitchen.yml``.
  #. Add:

     .. code-block:: yaml

        ---
        driver:
          name: vagrant

        provisioner:
          name: chef_zero

        platforms:
          - name: ubuntu-12.04
          - name: centos-6.4

        suites:
          - name: default
            run_list:
              - recipe[apache::default]
            attributes:

  #. Save the file.

 .. revealjs:: .kitchen.yml - Driver

  A driver specifies a virtualization or cloud provider by name:

  .. code-block:: yaml

     ---
     driver:
       name: vagrant

  .. code-block:: yaml

     provisioner:
       name: chef_zero

     platforms:
       - name: ubuntu-12.04
       - name: centos-6.4

     suites:
       - name: default
         run_list:
           - recipe[apache::default]
         attributes:

 .. revealjs:: .kitchen.yml - Provisioner

  A provisioner tells Kitchen how to configure the node:

  .. code-block:: yaml

     ---
     driver:
       name: vagrant

  .. code-block:: yaml

     provisioner:
       name: chef_zero

  .. code-block:: yaml

     platforms:
       - name: ubuntu-12.04
       - name: centos-6.4

     suites:
       - name: default
         run_list:
           - recipe[apache::default]
         attributes:

 .. revealjs:: .kitchen.yml - Platforms

  A platform is a specific version of an operating system:

  .. code-block:: yaml

     ---
     driver:
       name: vagrant

     provisioner:
       name: chef_zero

  .. code-block:: yaml

     platforms:
       - name: ubuntu-12.04
       - name: centos-6.4

  .. code-block:: yaml

     suites:
       - name: default
         run_list:
           - recipe[apache::default]
         attributes:

 .. revealjs:: .kitchen.yml - Suites

  A suite defines the target configurations for testing:

  .. code-block:: yaml

     ---
     driver:
       name: vagrant

     provisioner:
       name: chef_zero

     platforms:
       - name: ubuntu-12.04
       - name: centos-6.4

  .. code-block:: yaml

     suites:
       - name: default
         run_list:
           - recipe[apache::default]
         attributes:

 .. revealjs:: .kitchen.yml - Example - Two Platforms

  Two platforms, one test suite:

  .. code-block:: yaml

     ---
     driver:
       name: vagrant

     provisioner:
       name: chef_zero

  .. code-block:: yaml

     platforms:
       - name: ubuntu-12.04
       - name: centos-6.4

  .. code-block:: yaml

     suites:
       - name: default
         run_list:
           - recipe[apache::default]

 .. revealjs:: .kitchen.yml - Exmple - Two Suites

  Two platforms, two test suites:

  .. code-block:: yaml

     ---
     driver:
       name: vagrant

     provisioner:
       name: chef_zero

     platforms:
       - name: ubuntu-12.04
       - name: centos-6.4

  .. code-block:: yaml

     suites:
       - name: default
         run_list:
           - recipe[apache::default]
       - name: ssl
         run_list:
           - recipe[apache::ssl]

 .. revealjs:: .kitchen.yml - Exmple - Three Platforms, Two Suites

  Three platforms, two test suites:

  .. code-block:: yaml

     ---
     driver:
       name: vagrant

     provisioner:
       name: chef_zero

  .. code-block:: yaml

     platforms:
       - name: ubuntu-12.04
       - name: ubuntu-14.04
       - name: centos-6.4

     suites:
       - name: default
         run_list:
           - recipe[apache::default]
       - name: ssl
         run_list:
           - recipe[apache::ssl]

 .. revealjs:: Update .kitchen.yml

  #. Open ``cookbooks/apache/.kitchen.yml``.
  #. Add:

     .. code-block:: yaml

        ---
        driver:
          name: docker

        provisioner:
          name: chef_zero

        platforms:
          - name: centos-6.5

        suites:
          - name: default
            run_list:
              - recipe[apache::default]
            attributes:

  #. Save the file.

 .. revealjs:: About Docker

  * Portable, lightweight application runtime
  * Linux containers
  * Installed on the workstation

 .. revealjs:: Install Docker Image

  Run:

  .. code-block:: bash

     $ sudo docker images

  Returns:

  .. code-block:: none

     REPOSITORY    TAG           IMAGE ID      CREATED       VIRTUAL SIZE
     centos        centos6       70441cac1ed5  6 days ago    215.8 MB
     ubuntu        12.04         0b310e6bf058  2 weeks ago   116.1 MB

 .. revealjs:: Install kitchen-docker

  * A driver that allows Kitchen to work with Docker
  * Installed on the workstation
  * The Chef development kit includes kitchen-vagrant

 .. revealjs:: Verify kitchen-docker is Installed

  Run:

  .. code-block:: bash

     $ gem list kitchen

  Returns:

  .. code-block:: none

     *** LOCAL GEMS ***

     kitchen-docker (1.5.0)
     kitchen-vagrant (0.15.0)
     test-kitchen (1.2.1)

 .. revealjs:: Move to the Apache Cookbook Directory

  .. tag slides_cookbook_apache_directory_open

  Run:

  .. code-block:: bash

     $ cd ~/chef-repo/cookbooks/apache

  .. end_tag

 .. revealjs:: List Test Kitchen Instances

  Run:

  .. code-block:: bash

     $ kitchen list

  Returns:

  .. code-block:: none

     Instance           Driver  Provisioner  Last Action
     default-centos-65  Docker  ChefZero     <Not Created>

 .. revealjs:: Create the Kitchen Instance

  Run:

  .. code-block:: bash

     $ kitchen create

  Returns:

  .. code-block:: none

     -----> Starting Kitchen (v1.2.1)
     -----> Creating <default-centos-64>...
            Step 0 : FROM centos:centos6
             ---> 68eb857ffb51
            Step 1 : RUN yum clean all
             ---> Running in cdf3952a3f18
            Loaded plugins: fastestmirror
            Cleaning repos: base extras libselinux updates
            Cleaning up Everything
             ---> b1cccd25ce55
            Removing intermediate container cdf3952a3f18
            Step 2 : RUN
              yum install -y sudo openssh-server openssh-clients which curl
             ---> Running in 9db69ace459d
            Loaded plugins: fastestmirror

 .. revealjs:: Kitchen Created

  .. image:: ../../images/kitchen_diagram_01.png

 .. revealjs:: Login to the Kitchen Instance

  .. tag slides_kitchen_login

  Run:

  .. code-block:: bash

     $ kitchen login

  Returns:

  .. code-block:: none

     kitchen@localhost's password:

  Enter: ``kitchen``.

  .. end_tag

 .. revealjs:: Kitchen Login

  .. image:: ../../images/kitchen_diagram_03.png

 .. revealjs:: Kitchen Login

  .. image:: ../../images/kitchen_diagram_04.png

 .. revealjs:: Kitchen Login

  .. image:: ../../images/kitchen_diagram_05.png

 .. revealjs:: Apply Policy

  * Problem: We have not applied our policy to the test environment.
  * Success criteria: The default ``apache`` recipe will be applied in the test environment

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

 .. revealjs:: Move to the Apache Cookbook Directory (Again)

  .. tag slides_cookbook_apache_directory_open

  Run:

  .. code-block:: bash

     $ cd ~/chef-repo/cookbooks/apache

  .. end_tag

 .. revealjs:: Apply the Policy

  Run:

  .. code-block:: bash

     $ kitchen converge

  Returns:

  .. code-block:: none

     ----> Starting Kitchen (v1.2.1)
     -----> Converging <default-centos-64>...
            Preparing files for transfer
            Resolving cookbook dependencies with Berkshelf 3.1.5...
            Removing non-cookbook files before transfer
     -----> Installing Chef Omnibus (true)
            downloading https://www.getchef.com/chef/install.sh
              to file /tmp/install.sh
            trying curl...

 .. revealjs:: Run the kitchen converge Command

  .. image:: ../../images/kitchen_diagram_06.png

 .. revealjs:: Verify the Test

  * Success criteria: We have an isolated environment to verify the success status of the chef-client run
  * Success criteria: The default ``apache`` recipe will be applied in the test environment

 .. revealjs:: Update Kitchen for the motd Cookbook

  * Update Kitchen for the motd cookbook
  * Use kitchen-docker driver
  * Only test CentOS
  * Create the test Kitchen

 .. revealjs:: Recap

    * Follow a test-first/test-driven model to build a home page for a website
    * Understand Kitchen components, commands, and workflow
    * Define a test matrix
    * Create the .kitchen.yml file
    * Install Docker to use with Kitchen
    * Create a cookbook and test it using Kitchen
    * Understand how to add multiple platforms and suites
    * Understand how to use alternate drivers (instead of Docker)
    * Understand how to remove the Kitchen test instance

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

 .. revealjs:: More Info About Kitchen

    For more information, see:

    * |url slides_docs_chef_io|
    * |url slides_docs_kitchen|
    * |url slides_kitchen|
