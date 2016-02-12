.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

The following rules are checked by |foodcritic|:

.. list-table::
   :widths: 150 450
   :header-rows: 1

   * - Rule
     - Description
   * - FC001
     - "Use strings in preference to symbols to access node attributes"
   * - FC002
     - "Avoid string interpolation where not required"
   * - FC003
     - "Check whether you are running with chef server before using" + "server-specific features"
   * - FC004
     - "Use a service resource to start and stop services"
   * - FC005
     - "Avoid repetition of resource declarations"
   * - FC006
     - "Mode should be quoted or fully specified when setting file permissions"
   * - FC007
     - "Ensure recipe dependencies are reflected in cookbook metadata"
   * - FC008
     - "Generated cookbook metadata needs updating"
   * - FC009
     - "Resource attribute not recognized"
   * - FC010
     - "Invalid search syntax"
   * - FC011
     - "Missing README in markdown format"
   * - FC012
     - "Use Markdown for README rather than RDoc" "
   * - FC013
     - "Use file_cache_path rather than hard-coding tmp paths"
   * - FC015
     - "Consider converting definition to a LWRP"
   * - FC016
     - "LWRP does not declare a default action"
   * - FC017
     - "LWRP does not notify when updated"
   * - FC019
     - "Access node attributes in a consistent manner"
   * - FC021
     - "Resource condition in provider may not behave as expected"
   * - FC022
     - "Resource condition within loop may not behave as expected"
   * - FC023
     - "Prefer conditional attributes"
   * - FC024
     - "Consider adding platform equivalents"
   * - FC025
     - "Prefer chef_gem to compile-time gem install"
   * - FC026
     - "Conditional execution block attribute contains only string"
   * - FC027
     - "Resource sets internal attribute"
   * - FC028
     - "Incorrect #platform? usage"
   * - FC029
     - "No leading cookbook name in recipe metadata"
   * - FC030
     - "Cookbook contains debugger breakpoints"
   * - FC031
     - "Cookbook without metadata file"
   * - FC032
     - "Invalid notification timing"
   * - FC033
     - "Missing template"
   * - FC034
     - "Unused template variables"
   * - FC037
     - "Invalid notification action"
   * - FC038
     - "Invalid resource action"
   * - FC039
     - "Node method cannot be accessed with key"
   * - FC040
     - "Execute resource used to run git commands"
   * - FC041
     - "Execute resource used to run curl or wget commands"
   * - FC042
     - "Prefer include_recipe to require_recipe"
   * - FC043
     - "Prefer new notification syntax"
   * - FC044
     - "Avoid bare attribute keys"
   * - FC045
     - "Consider setting cookbook name in metadata"
   * - FC046
     - "Attribute assignment uses assign unless nil"
   * - FC047
     - "Attribute assignment does not specify precedence"
   * - FC048
     - "Prefer Mixlib::ShellOut"
   * - FC049
     - "Role name does not match containing file name"
   * - FC050
     - "Name includes invalid characters"
   * - FC051
     - "Template partials loop indefinitely"
   * - FC052
     - "Metadata uses the unimplemented 'suggests' keyword"
   * - FC053
     - "Metadata uses the unimplemented 'recommends' keyword"

.. note:: Some |foodcritic| rules have been deprecated: FC021, FC020, FC035, and FC036. FC018 deals with issues that may exist in older versions of the |chef client| that pre-date this documentation.
