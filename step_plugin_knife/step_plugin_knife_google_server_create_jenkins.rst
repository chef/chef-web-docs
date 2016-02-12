.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The ``knife google server create`` subcommand can be used to deploy infrastructure using |chef| recipes to |google compute engine|. For example, creating a master node running |jenkins|, hosted in |google compute engine|:

.. code-block:: bash

   knife google server create jenkins1 -Z us-central1-a -m n1-highcpu-2 -I debian-7-wheezy-v20131120 -r 'jenkins::master'

This command takes the following actions:

* Creates a |debian| virtual machine instance in the ``us-central1-a`` zone with machine type ``n1-highcpu-2``
* Registers it as a node named ``jenkins1`` with the |chef server|
* Configures the ``run_list`` attribute on the node as ``jenkins::master``
* Uses the |ssh| protocol to run the |chef client| with the ``jenkins::master`` recipe from the |cookbook jenkins| community cookbook

At the end of this process, a message similar to:

.. code-block:: bash

   Chef Client finished, 19/21 resources updated in 40.207903203 seconds

will confirm that |jenkins| has been installed successfully as a |jenkins| master. This (and similar) |knife| commands may be integrated into automation that can also spin up |jenkins| testing systems to build a complete continuous integration pipeline backed by |google compute engine|.

You can then use other |chef server| features---like search---to manage the |jenkins| pipeline as long as it is needed. When finished, just destroy part or all of it:

.. code-block:: bash

   knife google server delete tester1 -y --purge

