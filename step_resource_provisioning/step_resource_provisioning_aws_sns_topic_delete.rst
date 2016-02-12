.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.

.. To delete an SNS topic:

.. code-block:: ruby

   aws_sns_topic 'ref-sns-topic' do
     action :destroy
   end
