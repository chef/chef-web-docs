.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use attributes from the ``node['delivery']['config']`` namespace to get :doc:`configuration settings from the .delivery/config.json file </config_json_delivery>`.

``['build-cookbook']``
   Use ``node['delivery']['config']['build-cookbook']`` for the contents of the ``"build-cookbook"`` configuration setting.

``['build_nodes']``
   Use ``node['delivery']['config']['build_nodes']`` for the contents of the ``"build-cookbook"`` configuration setting.

``['delivery-truck']``
   Use ``node['delivery']['config']['delivery-truck']`` for the contents of the ``"build-cookbook"`` configuration setting.

``['delivery-truck']['PHASE_NAME']``
   Use ``node['delivery']['config']['delivery-truck']['phase_name']`` for the contents of a specific phase within the ``"build-cookbook"`` configuration setting. Replace ``PHASE_NAME`` with the actual phase name. For example: ``node['delivery']['config']['delivery-truck']['publish']``.

``dependencies``
   Use ``node['delivery']['config']['dependencies']`` for the contents of the ``"build-cookbook"`` configuration setting.

``skip_phases``
   Use ``node['delivery']['config']['skip_phases']`` for the contents of the ``"skip_phases"`` configuration setting.

``version``
   Use ``node['delivery']['config']['version']`` for the contents of the ``"version"`` configuration setting.
