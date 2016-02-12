.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Depending on the number and frequency of events published to the |chef analytics| server, it may be necessary to remove older events from the database. The following example shows a cron job that can be run daily (as root) to remove events that are older than three months.

.. code-block:: bash

   cat<<'EOF' > /etc/cron.daily/chef-analytics.cron
   #!/bin/sh
   log='/var/log/opscode-analytics/cull.log'
   echo "[$(date)] Stopping Alaska service..." >> $log
   opscode-analytics-ctl stop alaska >> $log 2>&1
   echo "[$(date)] Deleting Chef Analytics events older than 3 months" >> $log
   echo "delete from public.activities where recorded_at <  (now() - interval '3 months');" | su -l chef-pgsql -c 'psql actions' &>> $log
   echo "[$(date)] Starting Alaska service..." >> $log
   opscode-analytics-ctl start alaska >> $log 2>&1
   echo >> $log
   exit 0
   EOF
   chmod +x /etc/cron.daily/chef-analytics.cron
