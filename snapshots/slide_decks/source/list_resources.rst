================================================
The 9 most popular resources!
================================================


.. revealjs::

 .. revealjs:: The 9 most popular resources!

  .. image:: ../../images/list_resources.svg
     :scale: 80 %

 .. revealjs:: What are Resources?

    Resources are what make Chef recipes go.

    Think of them as your bread and butter, plus the salt you add to make everything taste good.

    Resources:

    * Install packages
    * Build templates
    * Create files
    * Put files in directories
    * Start services
    * Run scripts and commands

    These nine resources are essential for anyone who uses Chef!

 .. revealjs:: 1. execute

    Use the `execute resource <https://docs.chef.io/resource_execute.html>`__ to execute a command on a node:

    * ``yum clean all``
    * ``nagios3 --verify-config``
    * ``/etc/init.d/tomcat6 start``
    * ... any command you want!
    
    Let's face it. While being able to make your infrastruture as code is a big reason why people choose Chef, not everything can be managed as code right from the start. Sometimes you need a wrapper to put around an existing script because that script works right now.
    
    The **execute** resource will help you do that. Later on, after you get all of the things working with Chef, you can always come back and refactor that code to better take advantage of the full power of Chef.

 .. revealjs:: execute, examples

    A very simple example of using the **execute** resource is to start the service that runs Apache Tomcat:
    
    .. code-block:: ruby
    
       execute 'start-tomcat' do
         command '/etc/init.d/tomcat6 start'
         action :run
       end

    As mentioned, a better approach is to use the **service** resource:
    
    .. code-block:: ruby
    
       service 'tomcat' do
         action :start
       end

 .. revealjs:: 2. template

    Use the `template resource <https://docs.chef.io/resource_template.html>`__ to build a file on a node that is based on a template located in a cookbook. Chef uses Embedded Ruby (ERB) templates and Ruby expressions to define a template file.

    For example, when setting up Nginx, there is a default site:
    
    .. code-block:: none
    
       server { # php/fastcgi
          listen       80;
          server_name  domain1.com www.domain1.com;
          access_log   logs/domain1.access.log  main;
          root         html;
          location ~ \.php$ {
            fastcgi_pass   127.0.0.1:1025;
          }
         }

 .. revealjs:: template, examples

    Manage this site with Chef by using a template:
    
    .. code-block:: ruby
    
       server {
         listen        <%= node['nginx']['port'] -%>;
         server_name   <%= node['hostname'] %>;
         access_log    <%= node['nginx']['log_dir'] %>/localhost.access.log;
         location / {
           root        <%= node['nginx']['default_root'] %>;
           index       index.html index.htm;
         }
       }

 .. revealjs:: template, examples (continued)
 
    and then create that site using the **template** resource in a recipe:
    
    .. code-block:: ruby
    
       template "#{node['nginx']['dir']}/sites-available/default" do
         source 'default-site.erb'
         owner 'root'
         group node['root_group']
         mode '0644'
         notifies :reload, 'service[nginx]', :delayed
       end

 .. revealjs:: 3. directory

    Use the `template resource <https://docs.chef.io/resource_directory.html>`__ to manage a directory struture on a node directoy. Directories are hierarchies of folders that comprise all the information that is stored on a computer.

    If you want to transfer in a directory structure from a cookbook, use the `remote_directory resource <https://docs.chef.io/resource_directory.html>`__ instead.
    
    For example:
    
    .. code-block:: ruby
    
       directory "/tmp/something" do
         owner 'root'
         group 'root'
         mode '0755'
         action :create
       end

 .. revealjs:: 4. file

    Use the `file resource <https://docs.chef.io/resource_file.html>`__ to manage files that already exist on a node.
    
    For example, create a copy of a file in a different directory:
    
    .. code-block:: ruby
    
       file '/root/test.txt' do
         content IO.read("/tmp/something/test.txt")
         action :create
       end
    
    And then delete the file in the ``/tmp`` directory:
    
    .. code-block:: ruby
    
       file '/tmp/something' do
         action :delete
       end

 .. revealjs:: 5. service

    Use the `service resource <https://docs.chef.io/resource_service.html>`__ to manage services. Start them, stop them, restart them. Most applications have services, which is why this resource is essential.
    
    For example, to start Apache Tomcat:
    
    .. code-block:: ruby
    
       service 'nginx' do
         action :start
       end

 .. revealjs:: 6. package

    Use the `package resource <https://docs.chef.io/resource_package.html>`__ to install a package on a node. After you have installed the package, use the **template** resource to set up the configuration file for that application, and then start it using the **service** resource.

    Chef has many platform-specific resources for package management, but most of the time the **package** itself is all that's required! Chef will figure out which package manager to use based on the node's platform.
    
    The default behavior of the **package** resource is to install a package, so all you need to put in a recipe is:
    
    .. code-block:: ruby
    
       package 'tar'
    
    which is the same as:
    
    .. code-block:: ruby
    
       package 'tar' do
         action :install
       end

 .. revealjs:: 7. cookbook_file

    Use the `cookbook_file resource <https://docs.chef.io/resource_cookbook_file.html>`__ to move a file from a cookbook to a node.
    
    For example:
    
    .. code-block:: ruby
    
       cookbook_file "file.txt" do
         mode '0644'
       end

 .. revealjs:: 8. remote_file

    Use the `remote_file resource <https://docs.chef.io/resource_remote_file.html>`__ to get a file from a remote location, typically via HTTP, but sometimes via FTP, UNC, or a local network path, and then move that file from the remote location to a node.
    
    For example:
    
    .. code-block:: ruby

       remote_file '#{cache_path}/vim-#{source_version}.tar.bz2' do
         source 'http://ftp.vim.org/pub/vim/unix/vim-#{source_version}.tar.bz2'
         checksum node['vim']['source']['checksum']
         notifies :run, "bash[install_vim]", :immediately
       end

 .. revealjs:: 9. bash

    Use the `bash resource <https://docs.chef.io/resource_bash.html>`__ to run a script on a node. There are **script** resources for Bash, csh, Perl, Python, Ruby, and Windows PowerShell.

    The **bash** resouce is the most popular, but they all behave in a similar manner.

    .. code-block:: ruby
    
       bash 'install_vim' do
         cwd cache_path
         code <<-EOH
           mkdir vim-#{source_version} 
           tar -jxf vim-#{source_version}.tar.bz2 
           -C vim-#{source_version} --strip-components 1 
           (cd vim-#{source_version}/ 
           && ./configure #{node['vim']['source']['configuration']} 
           && make 
           && make install)
         EOH
         action :nothing
       end

 .. revealjs:: Conclusion

    The resources mentioned in this article are the most popular resources in Chef. Many cookbooks exist using only these resources. That said, there are `many more resources <https://docs.chef.io/resources.html>`__ that are built into Chef.





