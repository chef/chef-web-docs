================================================
Recipes
================================================

.. revealjs::

 .. revealjs:: Recipes Training

    .. image:: ../../images/slides_splash_recipes.png

 .. revealjs:: Recipes

    .. tag slides_recipes

    * A resource is a piece of the system and its desired state
    * A recipe is a collection of resources

    .. end_tag

 .. revealjs:: Order Matters

    .. tag slides_recipes_order

    .. code-block:: ruby

       package 'haproxy' do
        action :install
       end

       template '/etc/haproxy/haproxy.cfg' do
         source 'haproxy.cfg.erb'
         owner 'root'
         group 'root'
         mode '0644'
         notifies :restart, 'service[haproxy]'
       end

       service 'haproxy' do
         supports :restart => :true
         action [:start, :enable]
       end

    .. end_tag

 .. revealjs:: Order Matters - Package Runs First

    .. tag slides_recipes_order_package

    .. code-block:: ruby

       package 'haproxy' do
         action :install
       end

    .. code-block:: ruby

       template '/etc/haproxy/haproxy.cfg' do
         source 'haproxy.cfg.erb'
         owner 'root'
         group 'root'
         mode '0644'
         notifies :restart, 'service[haproxy]'
       end

       service 'haproxy' do
         supports :restart => :true
         action [:start, :enable]
       end

    .. end_tag

 .. revealjs:: Order Matters - Template Runs Second

    .. tag slides_recipes_order_template

    .. code-block:: ruby

       package 'haproxy' do
         action :install
       end

    .. code-block:: ruby

       template '/etc/haproxy/haproxy.cfg' do
         source 'haproxy.cfg.erb'
         owner 'root'
         group 'root'
         mode '0644'
         notifies :restart, 'service[haproxy]'
       end

    .. code-block:: ruby

       service 'haproxy' do
         supports :restart => :true
         action [:start, :enable]
       end

    .. end_tag

 .. revealjs:: Order Matters - Service Runs Third

    .. tag slides_recipes_order_service

    .. code-block:: ruby

       package 'haproxy' do
         action :install
       end

       template '/etc/haproxy/haproxy.cfg' do
         source 'haproxy.cfg.erb'
         owner 'root'
         group 'root'
         mode '0644'
         notifies :restart, 'service[haproxy]'
       end

    .. code-block:: ruby

       service 'haproxy' do
         supports :restart => :true
         action [:start, :enable]
       end

    .. end_tag

 .. revealjs:: Questions

    .. tag slides_core_questions

    .. Use this slide every time the slide deck stops for Q/A sessions with attendees.

    .. image:: ../../images/slides_questions.png

    .. end_tag

 .. revealjs:: More Info About Resources

    For more information, see:

    * |url slides_docs_chef_io|
    * docs.chef.io/recipes.html
