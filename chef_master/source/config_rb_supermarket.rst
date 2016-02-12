=====================================================
|supermarket rb| Settings
=====================================================

.. include:: ../../includes_config/includes_config_rb_supermarket.rst

.. note:: The |supermarket rb| file does not exist by default. To modify the settings for the |chef server|, create a file named ``supermarket.rb`` in the ``/etc/supermarket/`` directory.

Settings
=====================================================
The following settings are may be configured in the |supermarket rb| file.

.. note:: When changes are made to the |chef server rb| file the |chef server| must be reconfigured by running the ``supermarket-ctl reconfigure`` command.

General
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_supermarket_settings_general.rst

|amazon s3|
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_supermarket_settings_s3.rst

CLA
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_supermarket_settings_cla.rst

Database
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_supermarket_settings_database.rst

|nginx|
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_supermarket_settings_nginx.rst

Oauth2
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_supermarket_settings_oauth2.rst

|postgresql|
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_supermarket_settings_postgresql.rst

|redis|
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_supermarket_settings_redis.rst

|ruby on rails|
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_supermarket_settings_rails.rst

|runit|
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_supermarket_settings_runit.rst

|sidekiq|
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_supermarket_settings_sidekiq.rst

|smtp|
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_supermarket_settings_smtp.rst

|ssl|
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_supermarket_settings_ssl.rst

|statsd|
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_supermarket_settings_statsd.rst

|ruby unicorn|
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_supermarket_settings_unicorn.rst

URLs
-----------------------------------------------------
.. include:: ../../includes_config/includes_config_rb_supermarket_settings_url.rst
