========================================================================
Deprecation: Custom Resource Properties require `new_resource` (CHEF-19)
========================================================================
`[edit on GitHub] <https://github.com/chef/chef-web-docs/blob/master/chef_master/source/deprecations_namespace_collisions.rst>`__

.. tag deprecations_verify_file

In Chef 12.5.1, the custom resources API allowed specifying property names as the short form of `property_name` inside of actions, instead of the long form of
`new_resource.property_name` (as was previously required in provider code in LWRPs/HWRPs/etc).  That change caused unsolvable namespace clashes and will be
removed in Chef 14.0 and it will become mandatory to refer to properties as `new_resource.property_name` in actions.

.. end_tag

Example
==========

This code worked in 12.5.1 and later revisions up to Chef 13.0:

.. code-block:: ruby

  property :my_content, String

  action :doit do
    file "/tmp/file.xy" do
      content my_content
    end
  end

Remediation
=============

The `my_content` reference will now no longer be wired up automatically to the `new_resource` object and users will need to specify `new_resource.my_content` explictly:

.. code-block:: ruby

  property :my_content, String

  action :doit do
    file "/tmp/file.xy" do
      content new_resource.my_content
    end
  end

Note
======

In some edge cases, this deprecation warning may mention that the property should be referred to as `current_resource.property_name` instead of `new_resource.property_name`, which is not
a mistake and the user should instead use the `current_resource.property_name` to preserve prior behavior or should modify their code to explicitly check the current_resource if the
new_resource is not set.  There are several possible remediations to this in the order of least complicated to the most compatible with the old behavior, and the user will need to
select what works correct for their use case:

.. code-block:: ruby

  content_to_set = new_resource.property_name || current_resource.property_name
  content_to_set = new_resource.property_name.nil? ? current_resource.property_name : new_resource.property_name
  content_to_set = new_resource.property_is_set?(:property_name) ? new_resource.property_name : current_resource.property_name

Unfortunately, if you were reliant upon the old code's automatic switching between the `new_resource` and `current_resource` you will need to be explict.  For most users, however,
they were not aware that this was occuring and moving that uncommon logic explicitly into the action code will produce more comprehensible code that is less reiliant on knowing
subtle tricks of the API.

It is also entirely possible that the access of the `current_resource` was never intended by the user and this behavior was not desired and the correct remdiation may be to
simply access the property through the `new_resource.property_name`.  We cannot determine and accurately report to the user when this deprecation message is incorrect, we can only
report on compatible behavior.  The suggestion of the deprecation warning to access the property through `current_resource.property_name` may be wrong, and may not be what the
original author of the code ever intended.

The fact that this is confusing behavior to explain is why it is being removed.

Rationale
===========

The change in Chef 12.5.1 caused several insolvable problems.  One of the worst was that properties would override DSL commands so that (for example) if a user had a `template`
property they could no longer use the `template` resource:

.. code-block:: ruby

  property :template, String

  action :doit do
    template "/tmp/file.xy" do  # this would NOT create a template resource but would pass a string and a block to the template property
      source "file.xy.erb"
      variables({ stuff: "whatever" })
    end
  end

The highly confusing workaround for this problem was to use declare_resource to avoid the use of the resource DSL:

.. code-block:: ruby

  property :template, String

  action :doit do
    declare_resource(:template, "/tmp/file.xy") do # now there is no ambiguity and we create a template resource
      source "file.xy.erb"
      variables({ stuff: "whatever" })
    end
  end

This also caused issues when properties conflicted with properties on subresources, where this example is ambiguous as to if the "content" argument to "content" refers to the
file subresource "content" property or if it refers to the parent custom resource "content" property.

.. code-block:: ruby

  property :content, String

  action :doit do
    puts "content: #{content}"
    file "/tmp/file.xy" do
      content content
    end
  end

In fact, the subprocess wins (because it has to) and this code will result in the content always being nil and the file being empty.  The output of the `puts` debugging will
be correct, however, since `content` is being accessed outside of the file resource scope so it gets it off of the `new_resource` implcitly (in Chef 12.5.1 and Chef 13.x)

The way to remediate that is by specifying the new_resource:

.. code-block:: ruby

  property :content, String

  action :doit do
    file "/tmp/file.xy" do
      content new_resource.content
    end
  end

We are now enforcing this as the correct way to write resources.

Note that this namespace collision between custom resources and sub-resources occurs with properties that are not also being immediately used, and so this fails as well:

.. code-block:: ruby

  property :mode, String

  action :doit do
    file "/tmp/file.xy" do
      content mode  # this accesses the mode property on the file resource rather than the mode property on the outer resource
    end
  end

This will also cause namespace collisions if at some point in the future a new property is introduced to a subresource.

.. code-block:: ruby

  property :spiffyness, String

  action :doit do
    file "/tmp/file.xy" do
      content spiffyness
    end
  end

This will work fine today, but if at some point in the future the file resource grows a `spiffyness` property then this will cause a namespace collision with the custom resource
and will result in the custom resource failing.  This is avoided by the explicit use of `new_resource`:


.. code-block:: ruby

  property :spiffyness, String

  action :doit do
    file "/tmp/file.xy" do
      content new_resource.spiffyness # we are always referring to the outer custom resource's spiffiness property
    end
  end

