================================================
Order Matters
================================================

.. revealjs::

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

 .. revealjs:: Package Runs First

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

 .. revealjs:: Template Runs Second

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

 .. revealjs:: Service Runs Third

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

