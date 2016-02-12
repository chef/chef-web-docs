.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


A ``aws_image`` resource block manages |amazon aws| images. For example:

.. code-block:: ruby

   aws_image 'name' do
     image_id 'image-1'
   end

The full syntax for all of the properties that are available to the ``aws_image`` resource is:

.. code-block:: ruby

   aws_image 'name' do
     image_id                      String
   end

where 

* ``aws_image`` is the resource
* ``name`` is the name of the resource block and also the name of an |amazon ami| image
* ``image_id`` is a property of this resource, with the |ruby| type shown. |see attributes|
