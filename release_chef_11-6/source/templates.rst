.. THIS PAGE DOCUMENTS chef-client version 11.6

=====================================================
About Templates
=====================================================

.. include:: ../../includes_template/includes_template.rst

.. note:: ../../includes_notes/includes_notes_cookbook_template_erubis.rst

Requirements
=====================================================
.. include:: ../../includes_template/includes_template_requirements.rst

Variables
=====================================================
.. include:: ../../includes_template/includes_template_variables.rst

File Specificity
=====================================================
.. include:: ../../includes_template/includes_template_specificity.rst

The pattern for template specificity depends on two things: the lookup path and the source attribute. The first pattern that matches is used:

#. /host-$fqdn/$source
#. /$platform-$platform_version/$source
#. /$platform/$source
#. /default/$source

.. include:: ../../includes_template/includes_template_specificity_example.rst

Host Notation
=====================================================
.. include:: ../../includes_template/includes_template_host_notation.rst

Transfer Frequency
=====================================================
.. include:: ../../includes_template/includes_template_transfer_frequency.rst

Partial Templates
=====================================================
.. include:: ../../includes_template/includes_template_partials.rst

render Method
-----------------------------------------------------
.. include:: ../../includes_template/includes_template_partials_render_method.rst
