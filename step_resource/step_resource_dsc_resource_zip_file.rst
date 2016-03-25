.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To use a zip file:

.. code-block:: ruby

   dsc_resource 'example' do
      resource :archive
      property :ensure, 'Present'
      property :path, 'C:\Users\Public\Documents\example.zip'
      property :destination, 'C:\Users\Public\Documents\ExtractionPath'
    end
