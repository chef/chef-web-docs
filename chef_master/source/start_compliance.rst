.. The contents of this file is sync'd with /release_compliance/index.rst

=====================================================
Welcome to Chef Compliance!
=====================================================

|chef compliance| :doc:`scans for risks and compliance issues </compliance>` with easy-to-understand, customizable reports and visualization. Scan your entire IT infrastructure. Get easy to understand reports. Classify issues by severity. Automate remediation and implement continuious auditing.

.. image:: ../../images/start_compliance_audit.svg
   :width: 700px
   :align: center

* Use the |chef dk| to build security and compliance checks into your workflow
* Use :doc:`InSpec audit resources </inspec_reference>` to :doc:`define rules for testing nodes </dsl_compliance>` in your infrastructure. (See the navigation to browse the entire list of |inspec| audit resources.)
* Use pre-built certified profiles for CIA (Level 1 and Level 2), as well as best practice profiles for |windows| and |linux| systems

.. image:: ../../images/start_compliance_correct.svg
   :width: 700px
   :align: center

* :doc:`Set up the Chef Compliance server </install_compliance>`
* :doc:`Allow nodes to download compliance profiles </integrate_compliance_chef_server>` from the |chef server|
* Send the results of compliance scans to the |chef compliance| server via the |chef server|
* Use the |automate| workflow to `build remediation into your software deployment pipeline <https://docs.chef.io/release/delivery/>`__

.. 
.. commented out until it's available; when uncommented, verify the link, and then put it first in the bullet list above
.. * `Start with the tutorial <https://learn.chef.io/compliance/get-started/>`__.
.. 
