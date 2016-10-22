.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics. 


The chef-client uses the EN_US (UTF-8) character set. By default, the AIX base operating system does not include the EN_US (UTF-8) character set and it must be installed prior to installing the chef-client. The EN_US (UTF-8) character set may be installed from the first disc in the AIX media or may be copied from ``/installp/ppc/*EN_US*`` to a location on the logical partition (LPAR). This topic assumes this location to be ``/tmp/rte``. 

Use ``smit`` to install the EN_US (UTF-8) character set. This ensures that any workload partitions (WPARs) also have UTF-8 applied.

Remember to point ``INPUT device/directory`` to ``/tmp/rte`` when not installing from CD.

#. From a root shell type:

   .. code-block:: text

      # smit lang 

   A screen similar to the following is returned:

   .. code-block:: bash

                             Manage Language Environment
      
      Move cursor to desired item and press Enter.
      
        Change/Show Primary Language Environment
        Add Additional Language Environments
        Remove Language Environments
        Change/Show Language Hierarchy
        Set User Languages
        Change/Show Applications for a Language
        Convert System Messages and Flat Files
      
      
      
      
      
      F1=Help             F2=Refresh          F3=Cancel           F8=Image
      F9=Shell            F10=Exit            Enter=Do

#. Select ``Add Additional Language Environments`` and press ``Enter``. A screen similar to the following is returned:

   .. code-block:: bash

                         Add Additional Language Environments
      
      Type or select values in entry fields.
      Press Enter AFTER making all desired changes.
      
                                                              [Entry Fields]
        CULTURAL convention to install                                             +
        LANGUAGE translation to install                                            +
      * INPUT device/directory for software                [/dev/cd0]              +
        EXTEND file systems if space needed?                yes                    +
      
        WPAR Management
            Perform Operation in Global Environment         yes                    +
            Perform Operation on Detached WPARs             no                     +
                Detached WPAR Names                        [_all_wpars]            +
            Remount Installation Device in WPARs            yes                    +
            Alternate WPAR Installation Device             []
      
      
       
      
      
      F1=Help             F2=Refresh          F3=Cancel           F4=List
      F5=Reset            F6=Command          F7=Edit             F8=Image
      F9=Shell            F10=Exit            Enter=Do

#. Cursor over the first two entries---``CULTURAL convention to install`` and ``LANGUAGE translation to install``---and use ``F4`` to navigate through the list until ``UTF-8 English (United States) [EN_US]`` is selected. (EN_US is in capital letters!)

#. Press ``Enter`` to apply and install the language set.
