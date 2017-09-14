=====================================================
Chef and Google
=====================================================

`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/google.rst>`__

Google Cloud Platform, offered by Google, is a suite of cloud computing services that runs on the same
infrastructure that Google uses internally for its end-user products, such as Google Search and YouTube.
Alongside a set of management tools, it provides a series of modular cloud services including computing,
data storage, data analytics and machine learning.

knife
=====================================================

knife-google
-----------------------------------------------------

`[Github] <https://github.com/chef/knife-google>`__

* This plugin gives knife the ability to create, bootstrap, and manage Google Compute Engine (GCE) instances.

Authentication and Authorization
+++++++++++++++++++++++++++++++++++++++++++++++++++++

The underlying API this plugin uses relies on the Google Auth Library to handle authentication to the Google Cloud API. The auth library expects that there is a JSON credentials file located at:

``~/.config/gcloud/application_default_credentials.json``

The easiest way to create this is to download and install the Google Cloud SDK and run the gcloud auth login command which will create the credentials file for you.

Update: ``gcloud auth login`` no longer writes application default credentials. Please run ``gcloud auth application-default login`` for appropriate application credentials file.

If you already have a file you'd like to use that is in a different location, set the ``GOOGLE_APPLICATION_CREDENTIALS`` environment variable with the full path to that file.

These are the necessary settings for your ``knife.rb`` file:

.. code-block:: ruby

   knife[:gce_project] = 'my-test-project'
   knife[:gce_zone]    = 'us-east1-b'

Usage Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

**knife google server create INSTANCE_NAME**

.. code-block:: bash

   $ knife google server create test-instance-1 --gce-image centos-7-v20160219 \
   --gce-machine-type n1-standard-2 --gce-public-ip ephemeral --ssh-user myuser \
   --identity-file /Users/myuser/.ssh/google_compute_engine

**knife google server delete INSTANCE_NAME [INSTANCE_NAME]**

.. code-block:: bash

  $ knife google server delete my-instance-1 my-instance-2 --purge

**knife google server list**

.. code-block:: bash

  $ knife google server list

chef-provisioning
=====================================================

The following driver are directly supported by Chef:

chef-provisioning-google
-----------------------------------------------------

`[Github] <https://github.com/chef/chef-provisioning-google>`__


Usage Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

The following is an example of a verbose provisioning recipe:

.. code-block:: ruby

   require 'chef/provisioning/google_driver'

   with_driver 'google:us-central1-a:some-project',
     :google_credentials => {
        :json_key_path => 'REDACTED',
        :google_client_email => 'REDACTED',
   }

  google_key_pair "chef_default" do
    private_key_path "google_default"
    public_key_path "google_default.pub"
  end

  machine 'test' do
    machine_options key_name: "google_default"
    action [:converge, :destroy]
  end

test-kitchen
=====================================================

The following test-kitchen drivers for VMware are directly supported by Chef:

kitchen-google
-----------------------------------------------------

`[Github] <https://github.com/test-kitchen/kitchen-google>`__

* This is a Test Kitchen driver for Google Compute Engine. While similar to EC2 and other IaaS providers, GCE has a couple of advantages for Chef cookbook testing:
* (Subjectively) faster instance launch times; and Sub-hour billing.

Usage Examples
+++++++++++++++++++++++++++++++++++++++++++++++++++++

The following is a basic ``.kitchen.yml`` example:

.. code-block:: yaml

   ---
   driver:
     name: gce
     project: mycompany-test
     zone: us-east1-c
     email: me@mycompany.com
     tags:
       - devteam
       - test-kitchen
     service_account_scopes:
       - devstorage.read_write
       - userinfo.email

   provisioner:
     name: chef_zero

   transport:
    username: chefuser

   platforms:
     - name: centos-7
       driver:
         image_project: centos-cloud
         image_name: centos-7-v20170124
     - name: ubuntu-16.04
       driver:
        image_project: ubuntu-os-cloud
        image_family: ubuntu-1604-lts
     - name: windows
       driver:
        image_project: windows-cloud
        image_name: windows-server-2012-r2-dc-v20170117
        disk_size: 50
   suites:
     - name: default
       run_list:
         - recipe[COOBOOK::default]
       attributes:
