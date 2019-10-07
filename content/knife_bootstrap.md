+++
title = "knife bootstrap"
draft = false

aliases = "/knife_bootstrap.html"

[menu]
  [menu.docs]
    title = "knife bootstrap"
    identifier = "chef_infra/chefdk/knife/knife_bootstrap.md knife bootstrap"
    parent = "chef_infra/chefdk/knife"
    weight = 50
+++    

[\[edit on
GitHub\]](https://github.com/chef/chef-web-docs/blob/master/chef_master/source/knife_bootstrap.rst)

{{% chef_client_bootstrap_node %}}

{{% knife_bootstrap_summary %}}

**Considerations:**

-   As of Chef Server 12.8 you can create a `.chef/client.d` directory
    on your workstation and the contents of that `client.d` directory
    will be copied to the system being bootstrapped by the
    `knife bootstrap` command. You can also set the `client_d_dir`
    option in `config.rb` to point to an arbitrary directory instead of
    `.chef/client.d`, and the contents of that directory will be copied
    to the system being bootstrapped. All config files inside `client.d`
    directory get copied into `/etc/chef/client.d` on the system being
    bootstrapped.
-   Starting with Chef Server 12.0, use the [knife ssl
    fetch](/knife_ssl_fetch/) command to pull down the SSL
    certificates from the on-premises Chef Infra Server and add them to
    the `/trusted_certs_dir` on the workstation. These certificates are
    used during a `knife bootstrap` operation.
-   To bootstrap Chef Infra Client on Microsoft Windows machines, the
    [knife-windows](/knife_windows/) plugin is required.

Syntax
======

{{% knife_bootstrap_syntax %}}

Options
=======

{{< note >}}

{{% knife_common_see_common_options_link %}}

{{< /note >}}

{{% knife_bootstrap_options %}}

{{< note >}}

{{% knife_common_see_all_config_options %}}

{{< /note >}}

Validatorless Bootstrap
-----------------------

{{% knife_bootstrap_no_validator %}}

### `knife bootstrap` Options

{{% chef_vault_knife_bootstrap_options %}}

{{< note >}}

The `--node-name` option is required for a validatorless bootstrap
(Changed in Chef Client 12.4).

{{< /note >}}

FIPS Mode
---------

{{% fips_intro_client %}}

**Bootstrap a node using FIPS**

{{% knife_bootstrap_node_fips %}}

Custom Templates
================

The default `chef-full` template uses the Chef installer. For most
bootstrap operations, regardless of the platform on which the target
node is running, using the `chef-full` distribution is the best approach
for installing Chef Infra Client on a target node. In some situations, a
custom template may be required.

For example, the default bootstrap operation relies on an Internet
connection to get the distribution to the target node. If a target node
cannot access the Internet, then a custom template can be used to define
a specific location for the distribution so that the target node may
access it during the bootstrap operation. The example below will show
you how to create a bootstrap template that uses a custom artifact store
for Chef packages and installation scripts, as well as a RubyGem mirror:

1.  A custom bootstrap template file must be located in a `bootstrap/`
    directory, which is typically located within the `~/.chef/`
    directory on the local workstation. Navigate to the `.chef`
    directory, and create a `bootstrap` directory within it:

    ``` bash
    mkdir bootstrap
    ```

2.  Move to the `bootstrap` directory and create a blank template file;
    this example will use `template.erb` for the template name:

    ``` bash
    touch template.erb
    ```

3.  Still in the `bootstrap` directory, issue the following command to
    copy the `chef-full` configuration to your new template:

    ``` bash
    find /opt/chefdk/embedded/lib/ruby -type f -name chef-full.erb -exec cat {} \; > template.erb
    ```

    This command searches for the `chef-full` template file under
    `/opt/chefdk/embedded/lib/ruby`, and then outputs the contents of
    the file to `template.erb`. If you used a different template file
    name, be sure to replace `template.erb` with the template file you
    created during the last step.

4.  Update `template.erb` to replace `omnitruck.chef.io` with the URL of
    an `install.sh` script on your artifact store:

    ``` ruby
    install_sh="<%= knife_config[:bootstrap_url] ? knife_config[:bootstrap_url] : "http://packages.example.com/install.sh" %>"
    ```

5.  Still in your text editor, locate the following line near the bottom
    of your `template.erb` file:

    ``` ruby
    cat > /etc/chef/client.rb <<'EOP'
    <%= config_content %>
    EOP
    ```

    Beneath it, add the following, replacing `gems.example.com` with the
    URL of your gem mirror:

    ``` ruby
    cat >> /etc/chef/client.rb <<'EOP'
    rubygems_url "http://gems.example.com"
    EOP
    ```

    This appends the appropriate `rubygems_url` setting to the
    `/etc/chef/client.rb` file that is created during bootstrap, which
    ensures that your nodes use your internal gem mirror.

Bootstrap a Custom Template
---------------------------

You can use the `--bootstrap-template` option with the `knife bootstrap`
subcommand to specify the name of your bootstrap template file:

``` bash
$ knife bootstrap 123.456.7.8 -x username -P password --sudo --bootstrap-template "template"
```

Alternatively, you can use the `knife[:bootstrap_template]` option
within `config.rb` to specify the template that `knife bootstrap` will
use by default when bootstrapping a node. It should point to your custom
template within the `bootstrap` directory:

``` ruby
knife[:bootstrap_template] = "#{current_dir}/bootstrap/template.erb"
```

Examples
========

The following examples show how to use this knife subcommand:

**Bootstrap a node**

``` bash
$ knife bootstrap 192.0.2.0 -P vanilla -x root -r 'recipe[apt],recipe[xfs],recipe[vim]'
```

which shows something similar to:

``` none
...
192.0.2.0 Chef Client finished, 12/12 resources updated in 78.942455583 seconds
```

Use `knife node show` to verify:

``` bash
$ knife node show debian-wheezy.int.domain.org
```

which returns something similar to:

``` none
Node Name:   debian-wheezy.int.domain.org
Environment: _default
FQDN:        debian-wheezy.int.domain.org
IP:          192.0.2.0
Run List:    recipe[apt], recipe[xfs], recipe[vim]
Roles:
Recipes:     apt, xfs, vim, apt::default, xfs::default, vim::default
Platform:    debian 7.4
Tags:
```

**Use an SSH password**

``` bash
$ knife bootstrap 192.0.2.0 -x username -P PASSWORD --sudo
```

**Use a file that contains a private key**

``` bash
$ knife bootstrap 192.0.2.0 -x username -i ~/.ssh/id_rsa --sudo
```

**Specify options when using cURL**

``` bash
$ knife bootstrap --bootstrap-curl-options "--proxy http://myproxy.com:8080"
```

**Specify options when using GNU Wget**

``` bash
$ knife bootstrap --bootstrap-wget-options "-e use_proxy=yes -e http://myproxy.com:8080"
```

**Specify a custom installation command sequence**

``` bash
$ knife bootstrap --bootstrap-install-command "curl -l http://mycustomserver.com/custom_install_chef_script.sh | sudo bash -s --"
```
