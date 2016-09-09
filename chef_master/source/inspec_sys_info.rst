=====================================================
sys_info
=====================================================

.. include:: ../../includes_inspec_resources/includes_inspec_resource_sys_info.rst

Syntax
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_sys_info_syntax.rst

Matchers
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_matchers_intro.rst

hostname
+++++++++++++++++++++++++++++++++++++++++++++++++++++
.. include:: ../../includes_inspec_resources/includes_inspec_resource_sys_info_matcher_hostname.rst

Examples
-----------------------------------------------------
.. include:: ../../includes_inspec_resources/includes_inspec_resource_generic_examples_intro.rst

**Get system information for example.com**

.. code-block:: ruby

   describe sys_info do
     its('hostname') { should eq 'example.com' }
   end
