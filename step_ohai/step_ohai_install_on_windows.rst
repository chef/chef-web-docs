.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

|ohai| (version 0.6.x or higher) can be run on the following versions of |windows|:

* |windows 7 ultimate rc1|
* |windows 7 enterprise|
* |windows xp pro|
* |windows vista ultimate|
* |windows 2000 server sp4|
* |windows 2003 server r2 standard|
* |windows 2008 server r2 standard|

To install |ohai| on |windows|, do the following:

#. Install |ruby| using the one-click installer: http://rubyforge.org/frs/download.php/69034/rubyinstaller-1.8.7-p249-rc2.exe.

#. Install |ohai| and |windows wmi| bindings:

   .. code-block:: bash

      $ C:\Ruby>gem install ohai ruby-wmi

#. Run |ohai|:

   .. code-block:: bash

      $ C:\Ruby>ohai

