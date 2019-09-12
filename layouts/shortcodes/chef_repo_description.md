The chef-repo is a directory on your workstation that stores:

-   Cookbooks (including recipes, attributes, custom resources,
    libraries, and templates)
-   Roles
-   Data bags
-   Environments

The chef-repo directory should be synchronized with a version control
system, such as git. All of the data in the chef-repo should be treated
like source code.

knife is used to upload data to the Chef Infra Server from the chef-repo
directory. Once uploaded, that data is used by Chef Infra Client to
manage all of the nodes that are registered with the Chef Infra Server
and to ensure that the correct cookbooks, environments, roles, and other
settings are applied to nodes correctly.