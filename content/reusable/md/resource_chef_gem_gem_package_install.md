The **chef_gem** and **gem_package** resources are both used to install Ruby gems. For any machine on which Chef Infra Client is
installed, there are two instances of Ruby. One is the standard, system-wide instance of Ruby and the other is a dedicated instance that's
available only to Chef Infra Client.
Use the **chef_gem** resource to install gems into the instance of Ruby that's dedicated to Chef Infra Client.
Use the **gem_package** resource to install all other gems (that is, install gems system-wide).
