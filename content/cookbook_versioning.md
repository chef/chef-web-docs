+++
title = "About Cookbook Versioning"
draft = false
gh_repo = "chef-web-docs"
aliases = ["/cookbook_versioning.html", "/cookbook_versions.html"]
product = ["client", "server", "workstation"]

[menu]
  [menu.infra]
    title = "Versioning Cookbooks"
    identifier = "chef_infra/cookbook_reference/cookbook_versioning.md Versioning Cookbooks"
    parent = "chef_infra/cookbook_reference"
    weight = 150
+++
<!-- markdownlint-disable-file MD033 -->
{{< readfile file="content/reusable/md/cookbooks_version.md" >}}

## Syntax

A cookbook version always takes the form x.y.z, where x, y, and z are
decimal numbers that are used to represent major (x), minor (y), and
patch (z) versions. A two-part version (x.y) is also allowed.
Alphanumeric version numbers (1.2.a3) and version numbers with more than
three parts (1.2.3.4) aren't allowed.

## Constraints

A version constraint is a string that combines the cookbook version
syntax with an operator, in the following format:

```ruby
operator cookbook_version_syntax
```

{{< note >}}

Single digit cookbook versions aren't allowed. Cookbook versions must
specify at least the major and minor version. For example, use `1.0` or
`1.0.1`; don't use `1`.

{{< /note >}}

{{< readfile file="content/reusable/md/cookbooks_version_constraints_operators.md" >}}

For example, a version constraint for "equals version 1.0.7" is
expressed like this:

```ruby
= 1.0.7
```

A version constraint for "greater than version 1.0.2" is expressed like
this:

```ruby
> 1.0.2
```

An optimistic version constraint is one that looks for versions greater
than or equal to the specified version. For example:

```ruby
>= 2.6.5
```

will match cookbooks greater than or equal to 2.6.5, such as 2.6.5,
2.6.7 or 3.1.1.

A pessimistic version constraint is one that will find the upper limit
version number within the range specified by the minor version number or
patch version number. For example, a pessimistic version constraint for
minor version numbers:

```ruby
~> 2.6
```

will match cookbooks that are greater than or equal to version 2.6, but
less than version 3.0.

Or, a pessimistic version constraint for patch version numbers:

```ruby
~> 2.6.5
```

will match cookbooks that are greater than or equal to version 2.6.5,
but less than version 2.7.0.

Or, a pessimistic version constraint that matches cookbooks less than a
version number:

```ruby
< 2.3.4
```

or will match cookbooks less than or equal to a specific version number:

```ruby
<= 2.6.5
```

## Metadata

{{< readfile file="content/reusable/md/cookbooks_metadata.md" >}}

Versions and version constraints can be specified in a cookbook's
metadata.rb file by using the following functions. Each function accepts
a name and an optional version constraint; if a version constraint is
not provided, `>= 0.0.0` is used as the default.

<table>
<colgroup>
<col style="width: 40%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Function</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><p><code>depends</code></p></td>
<td><p>Show that a cookbook has a dependency on another cookbook. Use a version constraint to define dependencies for cookbook versions: <code>&lt;</code> (less than), <code>&lt;=</code> (less than or equal to), <code>=</code> (equal to), <code>&gt;=</code> (greater than or equal to; also known as "optimistically greater than", or "optimistic"), <code>~&gt;</code> (approximately greater than; also known as "pessimistically greater than", or "pessimistic"), or <code>&gt;</code> (greater than). This field requires that a cookbook with a matching name and version exists on the Chef Infra Server. When the match exists, the Chef Infra Server includes the dependency as part of the set of cookbooks that are sent to the node when Chef Infra Client runs. It's important that the <code>depends</code> field contain accurate data. If a dependency statement is inaccurate, Chef Infra Client may not be able to complete the configuration of the system. For example:</p>
<div class="sourceCode" id="cb1"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb1-1"><a href="#cb1-1"></a>depends <span class="st">&#39;opscode-base&#39;</span></span></code></pre></div>
<p>or:</p>
<div class="sourceCode" id="cb2"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb2-1"><a href="#cb2-1"></a>depends <span class="st">&#39;opscode-github&#39;</span>, <span class="st">&#39;&gt; 1.0.0&#39;</span></span></code></pre></div>
<p>or:</p>
<div class="sourceCode" id="cb3"><pre class="sourceCode ruby"><code class="sourceCode ruby"><span id="cb3-1"><a href="#cb3-1"></a>depends <span class="st">&#39;runit&#39;</span>, <span class="st">&#39;~&gt; 1.2.3&#39;</span></span></code></pre></div></td>
</tr>
<tr>
<td><code>provides</code></td>
<td>Add a recipe, definition, or resource that's provided by this cookbook, should the populated list be insufficient.</td>
</tr>
<tr>
<td><code>supports</code></td>
<td>Show that a cookbook has a supported platform. Use a version constraint to define dependencies for platform versions: <code>&lt;</code> (less than), <code>&lt;=</code> (less than or equal to), <code>=</code> (equal to), <code>&gt;=</code> (greater than or equal to), <code>~&gt;</code> (approximately greater than), or <code>&gt;</code> (greater than). To specify more than one platform, use more than one <code>supports</code> field, once for each platform.</td>
</tr>
</tbody>
</table>

## Environments

An environment can use version constraints to specify a list of allowed
cookbook versions by specifying the cookbook's name, along with the
version constraint. For example:

```ruby
cookbook 'apache2', '~> 1.2.3'
```

Or:

```ruby
cookbook 'runit', '= 4.2.0'
```

If a cookbook isn't explicitly given a version constraint the
environment will assume the cookbook has no version constraint and will
use any version of that cookbook with any node in the environment.

## Freeze Versions

A cookbook version can be frozen, which will prevent updates from being
made to that version of a cookbook. (A user can always upload a new
version of a cookbook.) Using cookbook versions that are frozen within
environments is a reliable way to keep a production environment safe
from accidental updates while testing changes that are made to a
development infrastructure.

For example, to freeze a cookbook version using knife, enter:

```bash
knife cookbook upload redis --freeze
```

To return:

```bash
Uploading redis...
Upload completed
```

Once a cookbook version is frozen, only by using the `--force` option
can an update be made. For example:

```bash
knife cookbook upload redis --force
```

Without the `--force` option specified, an error will be returned
similar to:

```bash
Version 0.0.0 of cookbook redis is frozen. Use --force to override
```

## Managing Many Cookbook Versions

{{< warning >}}

If you continually upload all versions of many cookbooks to your Chef Infra Server, you may overload the Chef Infra Server's dependency solver, causing it to time out and leading to a failed Chef Infra Client run.

There are three solutions to this problem:

- use [Policyfiles](/policyfile/) (recommended)
- place version constraints on all cookbooks and all dependencies of all cookbooks in any run list you use for a Chef Infra Client run
- upload only the required cookbook versions to a Chef Infra Server

{{< /warning >}}

In a CI/CD workflow where new cookbook versions are continually uploaded to a Chef Infra Server, the Chef Infra Server dependency solver must look at more and more cookbook versions while trying to solve the constraints given to it from the run list of each Chef Infra Client that starts up. Eventually, it runs out of time to produce a solution, times out, and the Chef Infra Client run fails as a result. The Chef Infra Server may also pick older cookbook versions than the versions that you intended.

The dependency solver workers in a Chef Infra Server have a default timeout of five seconds. The solution isn't to increase their timeout, but to control the problem so that the dependency solvers can solve it in a reasonable amount of time.

### Policyfiles

The current best practice is to control cookbook versions through Policyfiles. In this way, the dependency resolution is shifted left to the cookbook author designing the cookbook, its dependency structure, and the needed versions of all involved cookbooks. See the [Policyfiles](/policyfile/) documentation for more information.

### Version Constraints

In a CI/CD environment where you have many versions of cookbooks, place version constraints on all cookbooks and all dependencies of all cookbooks in any run list you use for a Chef Infra Client run.

The way to control the problem traditionally is by pinning the versions of cookbooks in an environment file or by using a wrapper cookbook that calls out the dependencies AND their versions in its `metadata.rb` file, and the dependencies do the same in their own `metadata.rb` files. See the [Cookbook Metadata Files](/config_rb_metadata/) for more information.

### Minimum Number of Cookbook Versions

The dependency solver will also work properly if you upload the minimum number of cookbook versions needed to the Chef Infra Server.

You can make a start at this by only uploading tested and blessed cookbook versions to your Chef Infra Server. These cookbooks would be ones where each scenario or role for the nodes is considered and that small set of cookbook versions are made available for those sets of nodes. Before Policyfiles, this policy could be implemented by constraining dependency solver access to candidate versions using an [environment]({{< relref "environments" >}}) file.

## Version Source Control

There are two strategies to consider when using version control as part
of the cookbook management process:

- Use maximum version control when it's important to keep every bit of data within version control
- Use branch tracking when cookbooks are being managed in separate environments using git branches and the versioning policy information is already stored in a cookbook's metadata.

### Branch Tracking

Using a branch tracking strategy requires that a branch for each
environment exists in the source control and that each cookbook's
versioning policy is tracked at the branch level. This approach is
relatively simple and lightweight: for development environments that
track the latest cookbooks, just bump the version before a cookbook is
uploaded for testing. For any cookbooks that require higher levels of
version control, knife allows cookbooks to be uploaded to specific
environments and for cookbooks to be frozen (which prevents others from
being able to make changes to that cookbook).

The typical workflow with a branch tracking version control strategy
includes:

1. Bumping the version number as appropriate.
2. Making changes to a cookbook.
3. Uploading and testing a cookbook.
4. Moving a tested cookbook to production.

For example, to bump a version number, first make changes to the
cookbook, and then upload and test it. Repeat this process as required,
and then upload it using a knife command similar to:

```bash
knife cookbook upload my-app
```

When the cookbook is finished, move those changes to the production
environment and use the `--freeze` option to prevent others from making
further changes:

```bash
knife cookbook upload  my-app -E production --freeze
```

### Maximum Versions

Using a maximum version control strategy is required when everything
needs to be tracked in source control. This approach is similar to
a branch tracking strategy while the cookbook is in development and
being tested, but is more complicated and time-consuming (and requires
file-level editing for environment data) to get the cookbook
deployed to a production environment.

The typical workflow with a maximum version control strategy includes:

1. Bumping the version number as appropriate.
2. Making changes to a cookbook.
3. Uploading and testing a cookbook.
4. Moving a tested cookbook to production.

For example, to bump a version number, first make changes to the
cookbook, and then upload and test it. Repeat this process as required,
and then upload it using a knife command similar to:

```bash
knife cookbook upload my-app
```

When the cookbook is finished, move those changes to the production
environment and use the `--freeze` option to prevent others from making
further changes:

```bash
knife cookbook upload  my-app -E production --freeze
```

Then modify the environment so that it prefers the newly uploaded
version:

```bash
(vim|emacs|mate|ed) YOUR_REPO/environments/production.rb
```

Upload the updated environment:

```bash
knife environment from file production.rb
```

And then deploy the new cookbook version.
