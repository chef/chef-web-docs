+++
title = "Custom Resources Guide"
draft = false

gh_repo = "chef-web-docs"

product = ["client", "workstation"]

[menu]
  [menu.infra]
    title = "Custom Resource Guide"
    identifier = "chef_infra/resources/custom_resources/custom_resources_guide.md Custom Resource Guide"
    parent = "chef_infra/resources/custom_resources"
    weight = 20
+++

This guide walks you through the basic steps of creating and using a custom resource that configures Apache `httpd` for Red Hat Enterprise Linux 7 and CentOS 7, using:

- Two template files
- Two properties
- An action that defines all the steps necessary to create the website

The steps are:

1. Generating a cookbook
1. Generating a custom resource
1. Defining two properties
1. Defining an action
1. Defining the steps in the action to configure the system with built-in Chef Infra resources
1. Generating a template
1. Creating two templates for the custom resource
1. Using the resource in a recipe

## Define a Cookbook

This guide uses the example of a cookbook directory named `website` in a chef-repo with the following directories:

Generate a chef-repo with:

```bash
chef generate repo chef-repo
```

The `chef-repo` has the structure:

{{% chef_repo_content %}}

Move into the `chef-repo`:

```bash
cd chef-repo
```

Next, generate a cookbook named `website`:

```bash
chef generate cookbook cookbooks/website
```

The `website` cookbook directory structure is:

{{% cookbooks_content %}}

See the Chef Workstation documentation for the [`chef` commands](https://docs.chef.io/workstation/ctl_chef/) for building the chef-repo and working with cookbook.

## Generate Templates

This custom resource requires two templates:

- `httpd.conf.erb` to configure Apache httpd
- `httpd.service.erb` to tell systemd how to start and stop the website

{{% chef_generate_template %}}

Generate the second template with:

```bash
chef generate template webserver/httpd.service.erb
```

## Generate a Custom Resource

The `resources` directory does not exist by default in a cookbook.
Generate the `resources` directory and a custom resource file from the `chef-repo/cookbooks` directory with the command:

```bash
chef generate resource cookbook filename.erb
```

For example, this command generates the `resource` directory that contains a file named `http.conf.erb` in the `webserver` cookbook:

```
chef generate template webserver http.conf.erb
```

The `webserver` cookbook directory now has the structure:

```output
├ cookbooks
| ├ webserver
  | ├ attribtes
  | | └ default.rb
  | ├ recipes
  | | └ default.rb
  | ├ resources
  | | └ httpd.rb
  | ├ templates
  | | └ http.conf.erb
  | | └ httpd.service.erb
  └ README.md
  └ metadata.rb
```

## Recipe

Invoke the custom resource from within a cookbook with the syntax:

```bash
cookbook_filename
```

For example:

```
website_httpd
```

where:

- `website` is the name of the cookbook
- `httpd` the name of the resource file
-  a underscore(`_`) separates the two `website_httpd`.


Call a custom resource from in a recipe.


```ruby
website_httpd 'httpd_site' do
  port 81
  action :create
end
```

which does the following:

- Installs Apache httpd
- Assigns an instance name of `httpd_site` that uses port 81
- Configures httpd and systemd from a template
- Creates the virtual host for the website
- Starts the website using systemd



### Define Properties

This custom resource needs two properties defined in the resource:

- `instance_name`
- `port`

These properties are defined as variables in the `httpd.conf.erb` file. A **template** block in recipes tells Chef Infra Client how to apply these variables.

In the custom resource, add the following custom properties:

```ruby
property :instance_name, String, name_property: true
property :port, Integer, required: true
```

where

- `String` and `Integer` are Ruby types (all custom properties must have an assigned Ruby type)
- `name_property: true` allows the value for this property to be equal to the `'name'` of the resource block

The `instance_name` property is then used within the custom resource in many locations, including defining paths to configuration files, services, and virtual hosts.

### Define Actions

Each custom resource must have at least one action that is defined within an `action` block:

```ruby
action :create do
  # the steps that define the action
end
```

where `:create` is a value that may be assigned to the `action` property for when this resource is used in a recipe.

For example, the `action` appears as a property when this custom resource is used in a recipe:

```ruby
custom_resource 'name' do
  # some properties
  action :create
end
```

### Define Resource

Use the **package**, **template** (two times), **directory**, and **service** resources to define the `website` resource. Remember: order matters!

#### package

Use the **package** resource to install httpd:

```ruby
# These are equivalent
package 'httpd' do
  action :install
end

package 'httpd' # Ommiting the action uses the default action and properties on the resource

```

where

- `source` gets the `httpd.service.erb` template from this cookbook
- `variables` assigns the `instance_name` property to a variable in the template

#### template, httpd.conf

Use the **template** resource to configure httpd on the node based on the `httpd.conf.erb` template located in the cookbook:

```ruby
template "/etc/httpd/conf/httpd-#{new_resource.instance_name}.conf" do
  source 'httpd.conf.erb'
  variables(
    instance_name: new_resource.instance_name,
    port: new_resource.port
  )
  action :create
end
```

where

- `source` gets the `httpd.conf.erb` template from this cookbook
- `variables` assigns the `instance_name` and `port` properties to variables in the template

{{< note >}}

When writing a shared custom resource, you may need to use templates that ship with the custom resource. However, you will need to specify the cookbook containing the template by using the cookbook property in the template resource. If this is not set, then Chef Infra Client will look for templates in the location of the cookbook that is using the resource and won't be able to find them. Example: `cookbook 'website'`

{{< /note >}}

#### directory

Use the **directory** resource to create the `/var/www/vhosts` directory on the node:

```ruby
directory "/var/www/vhosts/#{new_resource.instance_name}" do
  recursive true
  action :create
end
```

#### service

Use the **service** resource to enable, and then start the service:

```ruby
service "httpd-#{new_resource.instance_name}" do
  action [:enable, :start]
end
```

### Write Templates


#### httpd.conf.erb

`httpd.conf.erb` stores information about the website and is typically located under the `/etc/httpd`:

```ruby
ServerRoot "/etc/httpd"
Listen <%= @port %>
Include conf.modules.d/*.conf
User apache
Group apache
<Directory />
  AllowOverride none
  Require all denied
</Directory>
DocumentRoot "/var/www/vhosts/<%= @instance_name %>"
<IfModule mime_module>
  TypesConfig /etc/mime.types
</IfModule>
```

Copy it as shown, add it under `/templates`, and then name the file `httpd.conf.erb`.

**Template Variables**

The `httpd.conf.erb` template has two variables:

- `<%= @instance_name %>`
- `<%= @port %>`

They are:

- Declared as properties of the custom resource
- Defined as variables in a **template** resource block within the custom resource
- Tunable from a recipe when using `port` and `instance_name` as properties in that recipe
- `instance_name` defaults to the `'name'` of the custom resource if not specified as a property

#### httpd.service.erb

`httpd.service.erb` tells systemd how to start and stop the website:

```none
[Unit]
Description=The Apache HTTP Server - instance <%= @instance_name %>
After=network.target remote-fs.target nss-lookup.target

[Service]
Type=notify

ExecStart=/usr/sbin/httpd -f /etc/httpd/conf/httpd-<%= @instance_name %>.conf -DFOREGROUND
ExecReload=/usr/sbin/httpd -f /etc/httpd/conf/httpd-<%= @instance_name %>.conf -k graceful
ExecStop=/bin/kill -WINCH ${MAINPID}

KillSignal=SIGCONT
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

Copy it as shown, add it under `/templates`, and then name it
`httpd.service.erb`.

### Final Resource

```ruby
property :instance_name, String, name_property: true
property :port, Integer, required: true

action :create do
  package 'httpd' do
    action :install
  end

  template "/lib/systemd/system/httpd-#{new_resource.instance_name}.service" do
    source 'httpd.service.erb'
    variables(
      instance_name: new_resource.instance_name
    )
    action :create
  end

  template "/etc/httpd/conf/httpd-#{new_resource.instance_name}.conf" do
    source 'httpd.conf.erb'
    variables(
      instance_name: new_resource.instance_name,
      port: new_resource.port
    )
    action :create
  end

  directory "/var/www/vhosts/#{new_resource.instance_name}" do
    recursive true
    action :create
  end

  service "httpd-#{new_resource.instance_name}" do
    action [:enable, :start]
  end

end
```

### Final Cookbook Directory

When finished adding the templates and building the custom resource, the cookbook directory structure should look like this:

```text
/website
  metadata.rb
  /recipes
    default.rb
  README.md
  /resources
    httpd.rb
  /templates
    httpd.conf.erb
    httpd.service.erb
```
