.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


The following example shows an |inspec| control that uses |ruby| variables to instantiate an |inspec| resource once, and then use that content in multipLe tests:

.. code-block:: ruby

    control 'check-perl' do
      impact 0.3
      title 'Check perl compiled options and permissions'
      perl_out = command('perl -V')
      #require 'pry'; binding.pry;
      describe perl_out do
        its('exit_status') { should eq 0 }
        its('stdout') { should match (/USE_64_BIT_ALL/) }
        its('stdout') { should match (/useposix=true/) }
        its('stdout') { should match (/-fstack-protector/) }
      end

      # extract an array of include directories
      perl_inc = perl_out.stdout.partition('@INC:').last.strip.split("\n")
      # ensure include directories are only writable by 'owner'
      perl_inc.each do |path|
        describe directory(path.strip) do
          it { should_not be_writable.by('group') }
          it { should_not be_writable.by('other') }
        end
      end
    end
