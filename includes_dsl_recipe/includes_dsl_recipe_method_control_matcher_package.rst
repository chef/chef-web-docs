.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

Matchers are available for packages and may be used to define audits that test if a package or a package version is installed. The following matchers are available:

.. list-table::
   :widths: 60 420
   :header-rows: 1

   * - Matcher
     - Description, Example
   * - ``be_installed``
     - Use to test if the named package is installed. For example:

       .. code-block:: ruby

          it 'should be installed' do
            expect(package('httpd')).to be_installed
          end

       For a specific package version:

       .. code-block:: ruby

          it 'should be installed' do
            expect(package('httpd')).to be_installed.with_version('0.1.2')
          end
