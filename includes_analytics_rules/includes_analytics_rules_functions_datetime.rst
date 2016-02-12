.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use ``datetime:component()`` to specify the date and time at which a rule is applied.

The syntax for this function:

.. code-block:: ruby

   datetime:component(field, 'dateTimeComponent')

where:

* ``field`` is an attribute in the |json| oject
* ``dateTimeComponent`` must be one of the following (lower or uppercase) as a quoted string: ``era``, ``year_of_era``, ``century_of_era``, ``year_of_century``, ``year``, ``day_of_year``, ``month_of_year``, ``day_of_month``, ``weekyear_of_century``, ``weekyear``, ``week_of_weekyear``, ``day_of_week``, ``halfday_of_day``, ``hour_of_halfday``, ``clockhour_of_halfday``, ``clockhour_of_day``, ``hour_of_day``, ``minute_of_day``, ``minute_of_hour``, ``second_of_day``, ``second_of_minute``, ``millis_of_day``, or ``millis_of_second``

For example:

.. code-block:: ruby

   datetime:component(adate, 'era')
