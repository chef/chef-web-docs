A `Policyfile.rb` file may contain the following settings:

<!-- markdownlint-disable-file MD006 MD007 MD046 MD033 -->

`name "name"`

: Required. The name of the policy. Use a name that reflects the
  purpose of the machines against which the policy will run,
  such as _application server_, _chat server_, or _load balancer_.

`run_list "ITEM", "ITEM", ...`

: Required. The run-list Chef Infra Client will use to apply the
  policy to one (or more) nodes.

`default_source :SOURCE_TYPE, *args`

: The location in which any cookbooks not specified by `cookbook` are
  located.

  Possible values for `:SOURCE_TYPE` are:

  - `:artifactory`
  - `:chef_repo`
  - `:chef_server`
  - `:supermarket`

  `:artifactory`
  : Pulls cookbooks from an Artifactory server.

    For example, `default_source :artifactory, "https://artifactory.example/api/chef/my-supermarket"`.

    There are two ways to authenticate with the Artifactory server:

    - **API key**: Set `artifactory_api_key` in config.rb or use the `ARTIFACTORY_API_KEY` environment variable.
    - **Identity token**: Set `artifactory_identity_token` in config.rb or use the `ARTIFACTORY_IDENTITY_TOKEN` environment variable.

      The Artifactory identity token is new in Chef Workstation v24.11.

    **Note**: If both `ARTIFACTORY_API_KEY` and `ARTIFACTORY_IDENTITY_TOKEN` are set, `ARTIFACTORY_IDENTITY_TOKEN` takes precedence.

  `:chef_repo`
  : Pulls cookbooks from a monolithic cookbook repository. This may be a path to the top-level
    of a cookbook repository or to the `/cookbooks` directory within that repository.

    For example, `default_source :chef_repo, "path/to/repo"`.

  `:chef_server`
  : Pulls cookbooks from the Chef Infra Server.

    For example, `default_source :chef_server, "https://chef-server.example/organizations/example"`.

  `:supermarket`

  : Pulls cookbooks from the public Chef Supermarket or a private Chef Supermarket.

    By default `:supermarket` pulls cookbooks from the public Chef
    Supermarket. For example, `default_source :supermarket`.

    Specify the Supermarket URL to pull cookbooks from a private Supermarket. For example,
    `default_source :supermarket, "https://supermarket-name.example"`.

  You can specify multiple cookbook sources. For example from the
  public Chef Supermarket and a monolithic repository:

  ```ruby
  default_source :supermarket
  default_source :chef_repo, 'path/to/repo'
  ```

  or from both a public and private Chef Supermarket:

  ```ruby
  default_source :supermarket
  default_source :supermarket, 'https://supermarket.example'
  ```

  <div class="admonition-note">
  <p class="admonition-note-title">Note</p>
  <div class="admonition-note-text">

  If a run-list or any dependencies require a cookbook that's present
  in more than one source, be explicit about which source is
  preferred. This will ensure that a cookbook is always pulled from an
  expected source. For example, an internally-developed cookbook named
  `chef-client` will conflict with the public `chef-client` cookbook
  that's maintained by Chef. To specify a named source for a
  cookbook:

  ```ruby
  default_source :supermarket
  default_source :supermarket, 'https://supermarket.example' do |s|
    s.preferred_for 'chef-client'
  end
  ```

  List multiple cookbooks on the same line:

  ```ruby
  default_source :supermarket
  default_source :supermarket, 'https://supermarket.example' do |s|
    s.preferred_for 'chef-client', 'nginx', 'mysql'
  end
  ```

  </div>
  </div>

`cookbook "NAME" [, "VERSION_CONSTRAINT"] [, SOURCE_OPTIONS]`

: Add cookbooks to the policy, specify a version constraint, or
  specify an alternate source location, such as Chef Supermarket. For
  example, add a cookbook:

  ```ruby
  cookbook 'apache2'
  ```

  Specify a version constraint:

  ```ruby
  run_list 'jenkins::master'

  # Restrict the jenkins cookbook to version 2.x, greater than 2.1
  cookbook 'jenkins', '~> 2.1'
  ```

  Specify an alternate source:

  ```ruby
  cookbook 'my_app', path: 'cookbooks/my_app'
  ```

  or:

  ```ruby
  cookbook 'mysql', github: 'opscode-cookbooks/mysql', branch: 'master'
  ```

  or:

  ```ruby
  cookbook 'chef-ingredient', git: 'https://github.com/chef-cookbooks/chef-ingredient.git', tag: 'v0.12.0'
  ```

`named_run_list "NAME", "ITEM1", "ITEM2", ...`

: Specify a named run-list to be used as an alternative to the
  override run-list. This setting should be used carefully and for
  specific use cases, like running a small set of recipes to quickly
  converge configuration for a single application on a host or for
  one-time setup tasks. For example:

  ```ruby
  named_run_list :update_app, 'my_app_cookbook::default'
  ```

`include_policy "NAME", *args`

: Specify a Policyfile lock to be merged with this policy. Chef
  Workstation supports pulling this lock from a local or remote file,
  from a Chef Infra Server, or from a git repository. When the
  Policyfile lock is included, its run-list will appear before the
  current Policyfile's run-list. This setting requires that the solved
  cookbooks appear as-is from the included Policyfile lock. If
  conflicting attributes or cookbooks are provided, an error will be
  presented. See
  [RFC097](https://github.com/chef-boneyard/chef-rfc/blob/master/rfc097-policyfile-includes.md)
  for the full specifications of this feature.

  Pull the Policyfile lock from `./NAME.lock.json`:

  ```ruby
  include_policy 'NAME', path: '.'
  ```

  Pull the Policyfile lock from `./foo.lock.json`.

  ```ruby
  include_policy 'NAME', path: './foo.lock.json'
  ```

  Pull the Policyfile lock `foo.lock.json` from the `example/foo` Git repository on the `git.example.com` Git server.

  ```ruby
  include_policy 'NAME', git: 'https://git.example.com/example/foo', path: 'foo.lock.json'
  ```

  Pull the Policyfile lock from `./bar.lock.json` with revision ID
  'revision1'.

  ```ruby
  include_policy 'NAME', policy_revision_id: 'revision1', path: './bar.lock.json'
  ```

  Pull the Policyfile lock from a remote server
  `https://internal.example.com/foo.lock.json`.

  ```ruby
  include_policy 'NAME', remote: 'https://internal.example.com/foo.lock.json'
  ```

  Pull the Policyfile lock from a remote server
  `https://internal.example.com/bar.lock.json` and with revision ID
  'revision1'.

  ```ruby
  include_policy 'NAME', policy_revision_id: 'revision1', remote: 'https://internal.example.com/foo.lock.json'
  ```

  Pull the policy `NAME` with revision ID `revision1` from the
  `http://chef-server.example` Chef Infra Server:

  ```ruby
  include_policy 'NAME', policy_revision_id: 'revision1', server: 'http://chef-server.example'
  ```

  Pull the policy `foo` with revision ID `revision1`:

  ```ruby
  include_policy 'NAME', policy_name: 'foo', policy_revision_id: 'revision1', server: 'http://chef-server.example'
  ```

  Pull and lock the current revision for policy `foo` in policy group
  `prod`:

  ```ruby
  include_policy 'NAME', policy_name: 'foo', policy_group: 'prod', server: 'http://chef-server.example'
  ```

`ATTRIBUTE_TYPE['attribute'] = 'value'`

: Specify one or more attributes to be included with the policy.
  This is similar to defining attributes using roles.

  Possible values for `ATTRIBUTE_TYPE` are:

  - `default`
  - `override`

  `default`
  : A `default` attribute is automatically reset at the start of every Chef
    Infra Client run and has the lowest attribute precedence.

    For example:

    ```ruby
    default['attribute'] = 'value'
    default['attribute']['level2'] = 'another_value'
    ```

  `override`
  : An `override` attribute is automatically reset at the start of every
    Chef Infra Client run and has a higher attribute precedence than
    a `default` attribute.

    ```ruby
    override['attribute'] = 'value'
    override['attribute']['level2'] = 'another_value'
    ```

  Attribute hoisting allows you to define attributes by policy group.

  Use the following syntax to define policy group-specific attributes:

  ```ruby
  ATTRIBUTE_TYPE['POLICY_GROUP']['attribute'] = 'value'
  ```

  where:

  - `ATTRIBUTE_TYPE` is either `default` or `override` as described above.
  - `POLICY_GROUP` is a user-defined policy group, such as "dev", "test" "staging", or "production".

  In the following example, the value of `default['attribute']` is set to either `dev_value` or `prod_value` depending on the policy group.

  ```ruby
  default['dev']['attribute'] = 'dev_value'
  default['prod']['attribute'] = 'prod_value'
  ```
