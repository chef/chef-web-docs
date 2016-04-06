.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


This example shows how to use project applications to deploy a package into a ``.deb`` file during the deploy phase. (This example assumes a |delivery| project exists with a properly configured ``build-cookbook``.)

#. Open the ``publish.rb`` recipe in the ``build-cookbook`` and edit to look like the following:

   .. code-block:: ruby

      include_recipe 'delivery-truck::publish'

      # Generate your artifact and document it's location on a download server.
      artifact_location = <generated_artifact_location>

      # It's recommended to generate a checksum from your package too.
      artifact_checksum = <package_checksum>

      # Version the artifact based on the current date.
      artifact_version = Time.now.strftime('%F_%H%M')

      # Name your application.
      name = "<app_name>"

      project_app_attributes = {
        'artifact_location' => artifact_location,
        'artifact_checksum' => artifact_checksum
      }

      define_project_application(
        name,
        artifact_version,
        project_app_attributes
      )

#. In the ``publish.rb`` recipe, update ``<generated_artifact_location>`` and ``<package_checksum>`` to be correct for this project.

#. Set up the ``build-cookbook`` to know about this application. Add the following to ``.delivery/build-cookbook/attributes/default.rb``:

   .. code-block:: ruby

      default['delivery']['project_apps'] = ["<app_name>"]

   where ``<app_name>`` is the same value as the name of the application in the ``publish.rb`` file.

   When the publish phase is run, an application is created, versioned by timestamp, and including all of the information needed to install that version of the application. The provisioning code in ``delivery-truck`` will automatically pin based on this version.

#. Configure the ``build-cookbook`` to know about the application. Add the following to ``.delivery/build-cookbook/attributes/default.rb``:

   .. code-block:: ruby

      default['delivery']['project_apps'] = ["<APPLICATION_NAME>"]

#. Configure the ``build-cookbook`` to know how to install the application. Add the following to ``.delivery/build-cookbook/deploy.rb``:

   .. code-block:: ruby

      app_attributes = get_project_application("<APPLICATION_NAME>")

      # Download your package.
      remote_file "/tmp/latest_package.deb" do
        source   app_attributes['artifact_location']
        checksum app_attributes['artifact_checksum']
        action :create
      end

      # Install it onto your build infrastructure.
      package app_attributes['name'] do
        source "/tmp/latest_package.deb"
        action :install
      end
