.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


|gerrit| is leveraged to do the code review located https://review.openstack.org/.

* You do need to `create an account <https://login.launchpad.net/QSVcvczkg2PH7pM0/+new_account>`_ here to get |gerrit| to recognize you
* The quickest way to pull down the code is something like the following:

.. code-block:: bash

   #!/bin/bash

   GERRIT_USERNAME=<username>

   for i in client common compute identity image block-storage object-storage network metering dashboard telemetry database orchestration integration-test data-processing;
   do
     git clone git@github.com:openstack/cookbook-openstack-$i
     cd cookbook-openstack-$i
     git remote add gerrit ssh://$GERRIT_USERNAME@review.openstack.org:29418/openstack/cookbook-openstack-$i.git
     git review -s
     cd ../
   done

* After you pull down the code, you'll need to follow the steps in Jay Pipes' excellent post `Working with the OpenStack Code Review and CI system – Chef Edition <http://www.joinfu.com/2013/05/working-with-the-openstack-code-review-and-ci-system-chef-edition/>`_
* Another tool to make the review process easier is ``git review``, you can install it a few different ways, but the quickest is ``pip install git-review``.
* If you would like to play round with the ``openstack-chef-repo`` you'll need to do something like above but change the ``git checkout`` to point to `https://github.com/openstack/openstack-chef-repo <https://github.com/openstack/openstack-chef-repo>`_
* If you find yourself needing to run the CI again and say |github| is having trouble, add a comment "recheck no bug" in |gerrit| to re-run the tests.
