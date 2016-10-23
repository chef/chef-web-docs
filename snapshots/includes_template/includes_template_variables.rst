.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

A template is an Embedded Ruby (ERB) template. An Embedded Ruby (ERB) template allows Ruby code to be embedded inside a text file within specially formatted tags. Ruby code can be embedded using expressions and statements. An expression is delimited by ``<%=`` and ``%>``. For example:

.. code-block:: ruby

   <%= "my name is #{$ruby}" %>

A statement is delimited by a modifier, such as ``if``, ``elseif``, and ``else``. For example:

.. code-block:: ruby

   if false
      # this won't happen
   elsif nil
      # this won't either
   else
      # code here will run though
   end

Using a Ruby expression is the most common approach for defining template variables because this is how all variables that are sent to a template are referenced. Whenever a template needs to use an ``each``, ``if``, or ``end``, use a Ruby statement.

When a template is rendered, Ruby expressions and statements are evaluated by the chef-client. The variables listed in the **template** resource's ``variables`` parameter and in the node object are evaluated. The chef-client then passes these variables to the template, where they will be accessible as instance variables within the template. The node object can be accessed just as if it were part of a recipe, using the same syntax.

For example, a simple template resource like this:

.. code-block:: ruby

   node[:fqdn] = 'latte'
   template '/tmp/foo' do
     source 'foo.erb'
     variables({
       :x_men => 'are keen'
     })
   end

And a simple Embedded Ruby (ERB) template like this:

.. code-block:: ruby

   The node <%= node[:fqdn] %> thinks the x-men <%= @x_men %>

Would render something like:

.. code-block:: ruby

   The node latte thinks the x-men are keen

Even though this is a very simple example, the full capabilities of Ruby can be used to tackle even the most complex and demanding template requirements.
