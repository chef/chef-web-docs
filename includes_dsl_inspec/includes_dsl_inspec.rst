.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The |inspec| DSL is a |ruby|-based DSL for writing audit controls, which includes audit resources that you can invoke. Core and custom resources are written as regular |ruby| classes which inherit from ``Inspec.resource``.

Assuming the following |json| file exists on a node and needs to be tested:

.. code-block:: json

    {
      "keys":[
        {"username":"john", "key":"/opt/keys/johnd.key"},
        {"username":"jane", "key":"/opt/keys/janed.key"},
        {"username":"sunny ", "key":"/opt/keys/sunnym.key"}
      ]
    }

The following example shows how to use pure |ruby| code (variables, loops, conditionals, regular expressions, etc.) to run a few tests against the above |json| file:

.. code-block:: ruby

    control 'check-interns' do
      # use the json inspec resource to get the file
      json_obj = json('/opt/keys/interns.json')
      describe json_obj do
        its('keys') { should_not eq nil }
      end
      if json_obj['keys']
        # loop over the keys array
        json_obj['keys'].each do |intern|
          username = intern['username'].strip
          # check for white spaces chars in usernames
          describe username do
            it { should_not match(/\s/) }
          end
          # check key file owners and permissions
          describe file(intern['key']) do
            it { should be_owned_by username }
            its('mode') { should eq 0600 }
          end
        end
      end
    end
