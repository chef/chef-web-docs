.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To download a nsis (Nullsoft) package resource:

.. code-block:: ruby

   windows_package 'Mercurial 3.6.1 (64-bit)' do
     source 'http://mercurial.selenic.com/release/windows/Mercurial-3.6.1-x64.exe'
     checksum 'febd29578cb6736163d232708b834a2ddd119aa40abc536b2c313fc5e1b5831d'
   end
