+++
title = "Get started with Chef Workstation"

[menu.workstation_26_1]
  title = "Get started"
  identifier = "workstation_26_1/get_started"
  weight = 60
+++

This getting started guide shows you how to create a cookbook, define cookbook tests, lint the cookbook, and deploy a local VM to run and test the cookbook.

## Prerequisites

- [Add a Progress Chef license](/workstation/26.1/license)
- [Install Chef Workstation](/workstation/26.1/install)
- [Set up Workstation](/workstation/26.1/set_up)

## Develop a cookbook with Chef Workstation

Chef Infra defines a common workflow for cookbook development. To create and test your first cookbook, follow these steps:

1. Generate a new cookbook directory:

   ```sh
   chef generate cookbook new_cookbook
   cd new_cookbook
   ```

   This creates a cookbook with a default recipe, a `kitchen.yml` configuration for Test Kitchen, and a starter InSpec profile under `test/integration/default/`.

1. Open the default recipe (`recipes/default.rb`) and paste in the following:

   ```ruby
   # recipes/default.rb
   file '/tmp/hello.txt' do
     content 'Hello from Chef!'
     action :create
   end
   ```

   This uses the Chef Infra `file` resource to create the `/tmp/hello.txt` file and add text to it.

1. Create a Chef InSpec profile that verifies the results of a Chef Infra Client run.

   In the `test/integration/default/default_test.rb` file, replace the default InSpec tests with the following:

    ```ruby
    describe file('/tmp/hello.txt') do
      it { should exist }
      it { should be_file }
      its('content') { should eq "Hello from Chef!\n" }
    end
    ```

    This uses the InSpec `file` resource to verify that the `/tmp/hello.txt` file exists and verify the file's contents.

1. Lint the cookbook with Cookstyle to check for style issues and autocorrect them:

   ```sh
   cookstyle --auto-correct .
   ```

1. Run Test Kitchen Enterprise to converge your cookbook in a local VM or container and verify it works:

   ```sh
   kitchen converge
   ```

   This command does the following:

   1. Creates a local VM, container, or cloud instance. The default is a Vagrant VM.
   1. Installs the provisioner (Chef Infra Client) on the instance.
   1. Loads the cookbook and Test Kitchen config on the instance.
   1. Chef Infra Client runs the cookbook to bring the instance into the state defined in the cookbook.

1. Run your InSpec profile against the converged instance:

    ```sh
    kitchen verify
    ```

    Test Kitchen reports a pass or fail for each control defined in the InSpec profile.

1. You can also log into the instance and verify the file's text:

    ```sh
    kitchen login
    cat /tmp/hello.txt
    exit
    ```

1. Destroy the test instance when you're done:

   ```sh
   kitchen destroy
   ```

1. Update the cookbook and InSpec profile, and rerun `kitchen converge` and `kitchen verify` until all tests pass.
