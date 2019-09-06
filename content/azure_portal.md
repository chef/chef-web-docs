+++
title = "Microsoft Azure Portal"
draft = false

aliases = "/azure_portal.html"

[menu]
  [menu.docs]
    title = "Microsoft Azure"
    identifier = "chef_infra/getting_started/chef_on_azure_guide/azure_portal.md Microsoft Azure"
    parent = "chef_infra/getting_started/chef_on_azure_guide"
    weight = 20
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/azure_portal.rst)

{{% cloud_azure_portal %}}

Virtual Machines running Chef Infra Client
==========================================

{{< warning >}}

When the Chef VM extension is provisioned as part of a scale operation
for a VM Scale Set, we suggest not using the Chef Infra Client
extension. Instead pre-install Chef Infra Client onto the VM and/or use
an image-based deployment process, such as
[Packer](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/build-image-with-packer),
to create the base VM disk image.

The Microsoft VM agent on the machine executes all installations in
parallel and these extensions can call 'locking' installation mechanisms
such as Windows Installer (via installation of an MSI) or Apt updates. A
timeout can occur if the total time for all of these activities exceeds
5 minutes and in some regions that is not enough time to get the Chef
Infra Client package and enable the Chef Infra Client extension.

{{< /warning >}}

Through the Azure portal, you can provision a virtual machine with Chef
Infra Client running as a background service. Once provisioned, these
virtual machines are ready to be managed by a Chef Infra Server.

{{< info >}}

Virtual machines running on Microsoft Azure can also be provisioned from
the command-line using the `knife azure` plugin for knife. This approach
is ideal for cases that require automation or for users who are more
suited to command-line interfaces.

{{< /info >}}

Before virtual machines can be created using the Azure portal, some Chef
Infra Client-specific settings will need to be identified so they can be
provided to the Azure portal during the virtual machine creation
workflow. These settings are available from the Chef Infra Client
configuration settings:

-   The `chef_server_url` and `validation_client_name`. These are
    settings in the [client.rb file](/config_rb_client.html).
-   The file for the [validator key](/auth/).

Once this information has been identified, launch the Azure portal,
start the virtual machine creation workflow, and then bootstrap virtual
machines with Chef using the following steps:

1.  Sign in to the [Azure portal](https://portal.azure.com/) and
    authenticate using your Microsoft Azure account credentials.

2.  Choose **Virtual Machines** in the left pane of the portal.

3.  Click the **Add** option at the top of the blade.

4.  Select either **Windows Server** or **Ubuntu Server** in the
    **Recommended** category.

    {{< info >}}

    The Chef extension on the Azure portal may be used on the following
    platforms:

    -   Windows Server 2008 R2 SP1, 2012, 2012 R2, 2016
    -   Ubuntu 12.04 LTS, 14.04 LTS, 16.04 LTS, 16.10
    -   CentOS 6.5+
    -   RHEL 6+
    -   Debian 7, 8

    {{< /info >}}

5.  In the next blade, select the sku/version of the OS that you would
    like to use on your VM and click **Create**.

6.  Fill in the virtual machine configuration information, such as
    machine name, credentials, VM size, and so on.

    {{< info >}}

    It's best to use a new computer name each time through this
    workflow. This will help to avoid conflicts with virtual machine
    names that may have been previously registered on the Chef Infra
    Server.

    {{< /info >}}

7.  In Step 3 on the portal UI, open the **Extensions** blade and click
    `Add extension`.

8.  Depending on the OS you selected earlier, select either **Windows
    Chef Extension** or **Linux Chef Extension** and then **Create**.

9.  Using the `chef-repo/.chef/config.rb` file you downloaded during
    your Chef Infra Server setup, enter values for the Chef Infra Server
    URL and the validation client name. You can also use this file to
    help you find the location of your validation key.

10. Browse on your local machine and find your validation key
    (`chef-repo/.chef/<orgname>-validator.pem`).

11. Upload it through the portal in the **Validation Key** field.

    {{< info >}}

    Because the `.chef` directory is considered a hidden directory, you
    may have to copy this file out to a non-hidden directory on disk
    before you can upload it through the open file dialog box.

    {{< /info >}}

12. For **Client Configuration File**, browse to the
    `chef-repo/.chef/config.rb` file and upload it through your web
    browser.

    {{< info >}}

    Because the `.chef` directory is considered a hidden directory, you
    may have to copy this file out to a non-hidden directory on disk
    before you can upload it through the open file dialog box. Also, the
    `config.rb` file must be correctly configured to communicate to the
    Chef Infra Server. Specifically, it must have valid values for the
    following two settings: `chef_server_url` and
    `validation_client_name`.

    {{< /info >}}

13. Optional. [Use a run-list](/run_lists/) to specify what should
    be run when the virtual machine is provisioned, such as using the
    run-list to provision a virtual machine with Internet Information
    Services (IIS). Use the `iis` cookbook and the default recipe to
    build a run-list. For example:

    ``` ruby
    iis
    ```

    or:

    ``` ruby
    iis::default
    ```

    or:

    ``` ruby
    recipe['iis']
    ```

    A run-list can also be built using a role. For example, if a role
    named `backend_server` is defined on the Chef Infra Server, the
    run-list would look like:

    ``` ruby
    role['backend_server']
    ```

    Even without a run-list, the virtual machine will periodically check
    with the Chef Infra Server to see if the configuration requirements
    change. This means that the run-list can be updated later, by
    editing the run-list to add the desired run-list items by using the
    Chef Infra Server web user interface or by using the knife command
    line tool.

    {{< info >}}

    A run-list may only refer to roles and/or recipes that have already
    been uploaded to the Chef Infra Server.

    {{< /info >}}

14. Click **OK** to complete the page. Click **OK** in the Extensions
    blade and the rest of the setup blades. Provisioning will begin and
    the portal will the blade for your new VM.

After the process is complete, the virtual machine will be registered
with the Chef Infra Server and it will have been provisioned with the
configuration (applications, services, etc.) from the specified
run-list. The Chef Infra Server can now be used to perform all ongoing
management of the virtual machine node.

Log Files
=========

If the Azure portal displays an error in dashboard, check the log files.
Chef Infra Client creates the log files. The log files can be accessed
from within the Azure portal or by making a Chef Infra Client run on the
node and reproducing the issue interactively.

From the Azure portal
---------------------

Log files are available from within the Azure portal:

1.  Select **Virtual Machines** in the left pane of the Azure portal.

2.  Select the virtual machine that has the error status.

3.  Click the **Connect** button at the bottom of the portal to launch a
    Windows Remote Desktop session, and then log in to the virtual
    machine.

4.  Start up a Windows PowerShell command shell.

    ``` bash
    $ cd c:\windowsazure\logs
      ls –r chef*.log
    ```

5.  This should display the log files, including the Chef Infra Client
    log file.

From Chef Infra Client
----------------------

Chef Infra Client can be run interactively by using Windows Remote
Desktop to connect to the virtual machine, and then starting a Chef
Infra Client run:

1.  Log into the virtual machine.

2.  Start up a Windows PowerShell command shell.

3.  Run the following command:

    ``` bash
    $ chef-client -l debug
    ```

4.  View the logs. On a linux system, the Chef Infra Client logs are
    saved to
    `/var/log/azure/Chef.Bootstrap.WindowsAzure.LinuxChefClient/<extension-version-number>/chef-client.log`
    and can be viewed using the following command:

    ``` bash
    $ tail -f /var/log/azure/Chef.Bootstrap.WindowsAzure.LinuxChefClient/1210.12.102.1000/chef-client.log
    ```

Troubleshoot Log Files
----------------------

After the log files have been located, open them using a text editor to
view the log file. The most common problem are below:

-   Connectivity errors with the Chef Infra Server caused by incorrect
    settings in the client.rb file. Ensure that the `chef_server_url`
    value in the client.rb file is the correct value and that it can be
    resolved.
-   An invalid validator key has been specified. This will prevent Chef
    Infra Client from authenticating to the Chef Infra Server. Ensure
    that the `validation_client_name` value in the client.rb file is the
    correct value
-   The name of the node is the same as an existing node. Node names
    must be unique. Ensure that the name of the virtual machine in
    Microsoft Azure has a unique name.
-   An error in one the run-list. The log file will specify the details
    about errors related to the run-list.

For more information ...
========================

For more information about Microsoft Azure and how to use it with Chef:

-   [Microsoft Azure
    Documentation](https://azure.microsoft.com/en-us/documentation/services/virtual-machines/)
-   [knife azure Plugin](https://github.com/chef/knife-azure)
-   [azure-cookbook](https://github.com/chef-partners/azure-cookbook)
