+++
title = "Wrapper Cookbooks"
description = "The cookbook wrapper pattern"
draft = false

gh_repo = "chef-web-docs"
product = ["client", "server", "workstation"]

[menu]
  [menu.infra]
    title = "Wrapper Cookbooks"
    identifier = "chef_infra/cookbook_reference/cookbook-wrapper.md About Wrapper Cookbooks"
    parent = "chef_infra/cookbook_reference"
    weight = 10
+++

A wrapper cookbook is used to define project- and/or organization-specific requirements around a community cookbook.

Chef recommends using a wrapper cookbook to specify attributes that are unique to your organization.

For example:

```ruby
default['supermarket_omnibus']['chef_server_url'] = 'https://chefserver.mycompany.com:443'
default['supermarket_omnibus']['chef_oauth2_app_id'] = '14dfcf186221781cff51eedd5ac1616'
default['supermarket_omnibus']['chef_oauth2_secret'] = 'a49402219627cfa6318d58b13e90aca'
default['supermarket_omnibus']['chef_oauth2_verify_ssl'] = false
default['supermarket_omnibus']['fqdn'] = 'supermarket.mycompany.com'
```

Generate a new cookbook using the `chef` command from your workstation:

1. Generate the cookbook:

    ```bash
    chef generate cookbook my_supermarket_wrapper
    ```

2. Change directories into that cookbook:

    ```bash
    cd my_supermarket_wrapper
    ```

3. Defines the wrapper cookbook's dependency on the `SOMETHING` cookbook. Open the metadata.rb file of the new cookbook, and then add the following line:

    ```ruby
    depends 'SOMETHING'
    ```

4. Save and close the metadata.rb file.

5. Open the `/recipes/default.rb` recipe located within the new cookbook and add the following content:

    ```ruby
    include_recipe 'SOMETHING'
    ```

    This ensures that the `default.rb` file in the `SOMETHING` is run.

### Define Attributes

Define the attributes for the Chef Supermarket installation and how it connects to the Chef Infra Server. One approach is to hard-code attributes in the wrapper cookbook's `default.rb` recipe. A better approach is to place these attributes in a data bag, and then reference them from the recipe. For example, the data bag could be named `apps` and then a data bag item within the data bag could be named `supermarket`.

The following attribute values must be defined:

- `chef_server_url`
- `chef_oauth2_app_id`
- `chef_oauth2_secret`

Once configured, you can get the `chef_oauth2_app_id` and `chef_oauth2_secret` values from your Chef Infra Server within `/etc/opscode/oc-id-applications/supermarket.json`:

For `chef_server_url`, enter in the url for your chef server. For `chef_oauth2_app_id`, enter in the uid from `/etc/opscode/oc-id-applications/supermarket.json` For `chef_oauth2_secret`, enter in the secret from `/etc/opscode/oc-id-applications/supermarket.json`

To define these attributes, do the following:

1. Open the `/recipes/default.rb` file and add the following, BEFORE the `include_recipe` line that was added in the previous step. This example uses a data bag named `apps` and a data bag item named `supermarket`:

    ```ruby
    app = data_bag_item('apps', 'supermarket')
    ```

2. Set the attributes from the data bag:

    ```ruby
    node.override['supermarket_omnibus']['chef_server_url'] = app['chef_server_url']
    node.override['supermarket_omnibus']['chef_oauth2_app_id'] = app['chef_oauth2_app_id']
    node.override['supermarket_omnibus']['chef_oauth2_secret'] = app['chef_oauth2_secret']
    ```

    When finished, the `/recipes/default.rb` file should have code similar to:

    ```ruby
    app = data_bag_item('apps', 'supermarket')

    node.override['supermarket_omnibus']['chef_server_url'] = app['chef_server_url']
    node.override['supermarket_omnibus']['chef_oauth2_app_id'] = app['chef_oauth2_app_id']
    node.override['supermarket_omnibus']['chef_oauth2_secret'] = app['chef_oauth2_secret']

    include_recipe 'SOMETHING'
    ```

3. Save and close the `/recipes/default.rb` file.

{{< note >}}

If you are running your private Supermarket in AWS, you may need to set an additional attribute for the node's public IP address:

```ruby
node.override['supermarket_omnibus']['config']['fqdn'] = your_node_public_ip
```

{{< /note >}}

### Upload the Wrapper

The wrapper cookbook around the `SOMETHING` cookbook must be uploaded to the Chef Infra Server, along with any cookbooks against which the `SOMETHING` cookbook has dependencies.

To upload the cookbooks necessary to install Chef Supermarket, do the following:


1. Upload all cookbooks to the Chef Infra Server:

    ```bash
    knife cookbook upload -a
    ```

1. Change directories into the location in which the wrapper cookbook was created:

    ```bash
    cd path/to/wrapper/cookbook/
    ```

1. Upload the wrapper cookbook to the Chef Infra Server:

    ```bash
    knife cookbook upload -a
    ```
