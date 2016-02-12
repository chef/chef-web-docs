.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Go to one of the appropriate URLs listed below, depending on where you want to link the |github| |oauth| application:

* Individual Account: ``https://$GITHUB_SERVER/settings/applications``
* Organization: ``https://$GITHUB_SERVER/organizations/$ORGANIZATION/settings/applications``

Click **Register New Application** and set the following values:

.. list-table::
   :widths: 200 400
   :header-rows: 1

   * - Key
     - Value
   * - **Application Name**
     - ``Delivery``
   * - **Homepage URL**
     - ``http://$DELIVERY_SERVER/e/$DELIVERY_ENTERPRISE``
   * - **Authorization Callback URL**
     - ``http://$DELIVERY_SERVER/api/v0/github_auth_callback``

Click **Register Application** and take note of the generated ``Client ID`` and ``Client Secret`` in the upper left corner.
