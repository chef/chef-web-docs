.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A |resource dsc_resource| resource block allows |windows powershell_dsc_short| resourcs to be used in a |chef| recipe. For example, the |windows powershell_dsc_short| ``Archive`` resource:

.. code-block:: powershell

   Archive ExampleArchive {
     Ensure = "Present"
     Path = "C:\Users\Public\Documents\example.zip"
     Destination = "C:\Users\Public\Documents\ExtractionPath"
   } 

and then the same |resource dsc_resource| with |chef|:

.. code-block:: ruby

   dsc_resource 'example' do
      resource :archive
      property :ensure, 'Present'
      property :path, "C:\Users\Public\Documents\example.zip"
      property :destination, "C:\Users\Public\Documents\ExtractionPath"
    end

The full syntax for all of the properties that are available to the |resource dsc_resource| resource is:

.. code-block:: ruby

   dsc_resource 'name' do
     module_name                String
     notifies                   # see description
     property                   Symbol
     resource                   String
     subscribes                 # see description
   end

where 

* ``dsc_resource`` is the resource
* ``name`` is the name of the resource block
* ``property`` is zero (or more) properties in the |windows powershell_dsc_short| resource, where each property is entered on a separate line, ``:dsc_property_name`` is the case-insensitive name of that property, and ``"property_value"`` is a |ruby| value to be applied by the |chef client|
* ``module_name``, ``property``, and ``resource`` are properties of this resource, with the |ruby| type shown. |see attributes|
