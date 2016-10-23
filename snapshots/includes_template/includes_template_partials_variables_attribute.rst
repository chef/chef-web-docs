.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``variables`` property of the **template** resource can be used to reference a partial template file by using a Hash. For example:

.. code-block:: ruby

   template '/file/name.txt' do
     variables :partials => {
       'partial_name_1.txt.erb' => 'message',
       'partial_name_2.txt.erb' => 'message',
       'partial_name_3.txt.erb' => 'message'
     }
   end

where each of the partial template files can then be combined using normal Ruby template patterns within a template file, such as:

.. code-block:: ruby

   <% @partials.each do |partial, message| %>
     Here is <%= partial %>
     <%= render partial, :variables => {:message => message} %>
   <% end %>
