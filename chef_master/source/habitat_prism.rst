=====================================================
Habitat Prism
=====================================================

Prism is a Habitat package that collects data about an individual Habitat ring of supervisors and reports the data to Visibility. Visibility users will be able to collect and query data about all their rings within Visibility.

Prism works by reading information about the census and configuration of a given ring and reporting that data via Visibility's HTTP REST API.

Future versions of Prism will also include service configuration, runtime service bindings, and dependency information in its messages.

Configuring Prism
=====================================================
Prism supports the following configuration options:

* **data_collector_url**: required. The full URL to the Data Collector API endpoint in the Chef Automate server that should receive Prism updates. Example: ``https://my-automate-server.mycompany.com/data-collector/v0/habitat``
* **data_collector_token**: required. The security token used to authenticate Data Collector messages. This token must match the token configured on your Chef Automate server.
* **supervisor_host**: The IP/hostname of the Habitat Supervisor to contact for ring information. Default: ``localhost``.
* **habitat_ring_id**: A string that will be used to uniquely identify your ring in all messages sent to the Visibility API. Default: a UUID will be generated at startup. It is recommended that you generate your own ring ID as the auto-generated UUID will not persist between Prism restarts.
* **habitat_ring_alias**: A string that will be used in the Visibility UI alongside the ``habitat_ring_id``. This allows you to provide a more meaningful description for your ring. Default: ``default``.
* **ssl_verification_enabled**: If ``true`` and your ``data_collector_url`` is SSL-enabled, Prism will verify the SSL certificate presented by the Chef Automate server. Set this to ``false`` if your Chef Automate server is using a self-signed certificate. Default: ``true``.

Each of these options can be configured via standard Habitat means, such as via environment variables or configuration updates.

Installing and Running Prism
=====================================================
Pre-built Prism packages are available as Habitat packages via the `public Habitat depot <https://willem.habitat.sh/#/pkgs/chef/prism>`__ or as a Docker container via `Docker Hub <https://hub.docker.com/r/chef/prism/>`__. Additionally, the source code for Prism is available via `GitHub <https://github.com/chef/prism>`__ and you may build your own Habitat package from source by following the `Habitat documentation <https://www.habitat.sh/docs/create-packages-build/>`__.

We recommend running Prism as another supervisor in an existing ring; Prism will join the existing ring and report on all information it discovers. However, you may also run Prism as a standalone application and set the ``supervisor_host`` configuration value to the IP address of an existing supervisor. However, should that supervisor become unavailable, Prism will no longer be able to report on that particular ring. Therefore, we recommend joining Prism to an existing ring.

One Prism service is required per Habitat ring.

Using the Habitat Package from the Depot
-----------------------------------------------------

#. Install Habitat on the node on which you wish to run Prism.
#. Write out a ``config.toml`` that contains your configuration values. Example:

   .. code-block:: ruby

      data_collector_url = "https://my-automate-server.mycompany.com/data-collector/v0/habitat"
      data_collector_token = "mys00pers33krett0ken"
      habitat_ring_id = "8050248e-8f18-4ce7-9c65-c51f85a92b57"
      habitat_ring_alias = "east_datacenter_prod"

#. Start the ``chef/prism`` Habitat package and connect it to your existing ring of services. Example:

   .. code-block:: ruby

      HAB_PRISM="`cat config.toml`" hab start chef/prism --peer x.x.x.x

   where ``x.x.x.x`` is the IP address of an already-running supervisor in your existing ring.

Using the Docker Container from Docker Hub
-----------------------------------------------------

#. Install Docker on the node on which you wish to run Prism.
#. Write out a ``config.toml`` that contains your configuration values. See the section above for an example.
#. Start the ``chef/prism`` Docker container and connect it to your existing ring of services. Example:

   .. code-block:: ruby

      docker run -e HAB_PRISM="`cat config.toml`" -it chef/prism --peer x.x.x.x

   where ``x.x.x.x`` is the IP address of an already-running supervisor in your existing ring.
