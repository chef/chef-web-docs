+++
title = "Chef Desktop Infrastructure"
draft = false
publishDate = "2020-06-02"

gh_repo = "desktop-config"

[menu]
  [menu.desktop]
    title = "Infrastructure Overview"
    identifier = "desktop/getting_started/infrastructure_overview.md Infrastructure Overview"
    parent = "desktop/getting_started"
    weight = 30
+++

With the Chef Desktop pattern completely set up to manage configurations and applications for your organization's devices, it would look something like in the diagram below.

![Chef Desktop pattern](/images/desktop-config/infrastructure-overview.png)

Ideally, you would have a chef repository with all the cookbooks either containing our premium Chef Desktop cookbook content or your custom cookbooks, which are maintained in a remote repository and pushed to the Automate 2 server via a CI/CD pipeline. You can also push it directly from your local workstation system, if that suits your workflow better.

In the diagram above, you can see the following parts of the entire system:

1. **Automate 2 server**: This setup consists of an automate and infra server. Additionally, you would also enable the desktop product when deploying automate that would provide you with a dashboard to gain insight on the managed fleet.
2. **Windows and/or macOS nodes**: The devices that will be managed by the Chef Desktop product.
3. **Apple Business Manager and MDM server**: As a part of zero touch deployment pattern, this allows your device to be registered automatically. This can be omitted if you want to enroll devices manually each time when they are added to the fleet.
4. **AutoPkg and Munki repository**: When setting up automated application management for Apple devices, this repository would be set up and stored in a cloud storage container. It holds all the information for the application installations and updates being managed by you for the MacOS devices.
5. **Microsoft Active Directory and Intune**: As a part of zero touch deployment pattern, this allows your device to be registered automatically. This can be omitted if you want to enroll devices manually each time when they are added to the fleet.
6. **Gorilla repository**: When setting up automated application management for Windows, this repository would be set up and stored in a cloud storage container. It holds all the information for the application installations and updates being managed by you for the Windows devices in your fleet.
7. **CI/CD Pipelines**: If you want to completely automate the roll outs whenever the remote repository for your chef repo is updated, you can use a pipeline to automatically push the new policies to the server. Whenever the scheduled chef-client run happens next, the new policy will be pulled by the nodes and Chef client will analyze and apply the updated configurations and keep the other configurations unchanged.

Once everything is configured and Chef client runs have been scheduled either via Chef desktop cookbook provided from us or manually by you, you can open the Chef Desktop dashboard with your credentials and view information about your fleet, including status of Chef client runs.

### Next Steps

With all this information, you are now ready to set up the Chef Desktop product for configuration and application management of your fleet. You can proceed further in one of the two ways:

1. Create a demonstration setup with virtual endpoints or real devices to evaluate our product using our [quick start guide]({{< relref "/demonstration_setup.md" >}}).
2. [Read instructions]({{< relref "_index.md" >}}) on how to set up individual parts of the pattern for production with or without Zero Touch Deployment.