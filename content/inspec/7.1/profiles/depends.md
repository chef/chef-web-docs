+++
title = "Chef InSpec profile dependencies"
draft = false


[menu.inspec_7_1]
    title = "Dependencies"
    identifier = "profiles/depends"
    parent = "profiles"
    weight = 50
+++

Chef InSpec profiles can use controls and custom resources from other profiles.
When you include another profile's controls, you can also skip or modify those controls to fit your specific needs.

For hands-on examples, check out [Extending InSpec: InSpec Wrappers and Custom Resources](https://www.chef.io/training/tutorials) on Learn Chef.

## Define profile dependencies

To use controls from another profile, specify the profile in your `inspec.yml` file's `depends` section.
Each dependency needs a name and a location where Chef InSpec can find the profile.

```yaml
depends:
- name: linux-baseline
  url: https://github.com/dev-sec/linux-baseline/archive/master.tar.gz
- name: ssh-baseline
  url: https://github.com/dev-sec/ssh-baseline/archive/master.tar.gz
```

Chef InSpec supports several dependency sources:

### Local path

Use `path` for profiles stored locally on disk.
This is useful during development and debugging.

```yaml
depends:
- name: my-profile
  path: /absolute/path
- name: another
  path: ../relative/path
```

### Ruby gem

Starting in Chef InSpec 7, you can use resource packs released as Ruby gems as dependencies. For example:

```yaml
depends:
  - name: inspec-ibmdb2-resources
    gem: inspec-ibmdb2-resources
```

where:

- `name`: is the logical identifier for the resource pack.
- `gem`: is the name of the Ruby gem that contains the resource pack.

You can target a gem version with the `version` key. For example:

```yaml
depends:
  - name: inspec-ibmdb2-resources
    gem: inspec-ibmdb2-resources
    version: 7.0.1
```

And you can target a gem source with the `source` key.
This is useful when the resource pack is hosted on a private gem repository or an alternate source instead of the default RubyGems repository.
For example:

```yaml
depends:
  - name: inspec-ibmdb2-resources
    gem: inspec-ibmdb2-resources
    source: inspec-gems.example.com
```

### Remote URL

Use `url` for profiles hosted at HTTP or HTTPS URLs.
The profile must be a valid profile archive (zip, tar, or tar.gz format) and it must be accessible with an HTTP GET operation.

```yaml
depends:
- name: my-profile
  url: https://example.com/path/to/profile.tgz
- name: profile-via-git
  url: https://github.com/username/myprofile-repo/archive/master.tar.gz
```

You can add authentication for private repositories:

```yaml
depends:
- name: my-profile
  url: https://example.com/path/to/profile.tgz
  username: user
  password: password
```

### Git repository

Use `git` for profiles in Git repositories.
You can use the optional `branch`, `tag`, `commit`, `version`, and `relative_path` properties to specify a version or profile location.

```yaml
depends:
- name: git-profile
  git: http://example.com/path/to/repo
  branch:  desired_branch
  tag:     desired_version
  commit:  pinned_commit
  version: semver_via_tags
  relative_path: relative/optional/path/to/profile
```

### Chef Supermarket

Use `supermarket` for profiles located in cookbook that's hosted on Chef Supermarket.
For example:

```yaml
depends:
- name: supermarket-profile
  supermarket: supermarket-username/supermarket-profile
```

You can list available Supermarket profiles with `inspec supermarket profiles`.

### Chef Automate or Compliance

Use `compliance` for profiles on Chef Automate or Chef Compliance server.

```yaml
depends:
- name: linux
  compliance: base/linux
```

## Ruby gem dependencies

If your profile needs specific Ruby gems, list them in the `gem_dependencies` section of `inspec.yml`.
For example, if your profile needs a specific gem to be installed for a custom resource.

Chef InSpec will prompt you to install these gems when you first run the profile.

```yaml
gem_dependencies:
  - name: "mongo"
    version: ">= 2.3.12"
```

To skip the installation prompt and install automatically, use the `--auto-install-gems` option with `inspec exec`.

## Handle resource name conflicts

When two dependencies provide resources with the same name, use the `require_resource` function to create an alternate name:

```ruby
require_resource(
  profile: '<DEPENDENCY_NAME>',
  resource: '<RESOURCE_NAME>',
  as: '<ALTERNATE_RESOURCE_NAME>'
)
```

Where:

- `<DEPENDENCY_NAME>` is the name of the dependent profile
- `<RESOURCE_NAME>` is the original resource name
- `<ALTERNATE_RESOURCE_NAME>` is your new name for the resource

## Use controls from dependent profiles

After you define dependencies in `inspec.yml`, you can include and modify controls from those profiles.

See the [example profile](https://github.com/inspec/inspec/tree/main/examples/inheritance) in the InSpec repository for a complete example.

### Include all controls

Use `include_controls` to run all controls from a dependent profile.

For example, if `baseline-profile` has these controls:

- baseline-1
- baseline-2

And `app-profile` has these controls:

- app-1
- app-2
- app-3

You can add the `baseline-profile` controls to the `app-profile` profile with the `depends` property in the `inspec.yaml` file to add `baseline-profile` as dependency of `app-profile`. Then include the `baseline-profile` controls using `include_controls` in `app-profile`'s control code:

```ruby
include_controls 'baseline-profile'
```

When you run `app-profile`, Chef InSpec executes all controls:

- app-1
- app-2
- app-3
- baseline-1
- baseline-2

### Skip specific controls

Use `skip_control` to exclude controls that you don't want to execute:

```ruby
include_controls 'baseline-profile' do
  skip_control 'baseline-2'
end
```

This runs all controls in `baseline-profile` except `baseline-2`:

- app-1
- app-2
- app-3
- baseline-1

### Modify control properties

You can change properties like impact severity when including controls.

If `baseline-1` originally has an impact of `1.0`:

```ruby
control 'baseline-1' do
  impact 1.0
  # ...existing code...
end
```

When you include the `baseline-profile` controls, you can modify them to have lower impact:

```ruby
include_controls 'baseline-profile' do
  control 'baseline-1' do
    impact 0.5
  end
end
```

The control runs normally, but failures with `baseline-1` are reported with impact `0.5` instead of `1.0`.

### Include specific controls only

Use `require_controls` to run only certain controls from a dependent profile.

If `baseline-profile` has controls `baseline-1` through `baseline-5`, but you only need two:

```ruby
require_controls 'baseline-profile' do
  control 'baseline-2'
  control 'baseline-4'
end
```

This runs:

- app-1
- app-2
- app-3
- baseline-2
- baseline-4

You can also modify specific controls:

```ruby
require_controls 'baseline-profile' do
  control 'baseline-2' do
    impact 0.5
  end
  control 'baseline-4'
end
```

## Use controls from specific profile versions

When profiles depend on specific versions of other profiles, include controls using the profile name and version separated by a hyphen.

If `profile-a` depends on ssh version 2.6.0:

```yaml
name: profile-a
depends:
  - name: ssh
    git: https://github.com/dev-sec/ssh-baseline.git
    tag: 2.6.0
```

And `profile-b` depends on ssh version 2.7.0:

```yaml
name: profile-b
depends:
  - name: ssh
    git: https://github.com/dev-sec/ssh-baseline.git
    tag: 2.7.0
```

Include controls from specific versions:

```ruby
include_controls "ssh-2.6.0"
include_controls "ssh-2.7.0"
```

Or use `require_controls`:

```ruby
require_controls "ssh-2.6.0"
require_controls "ssh-2.7.0"
```

## Manage dependency versions

When you run a local profile, Chef InSpec reads `inspec.yml` to source dependencies.
It caches dependencies locally and creates an `inspec.lock` file.

To update dependencies after changing `inspec.yml`, run:

```bash
inspec vendor --overwrite
```

This re-vendors dependencies and updates the lock file.
