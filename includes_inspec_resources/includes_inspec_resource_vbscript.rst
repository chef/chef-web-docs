.. The contents of this file may be included in multiple topics (using the includes directive).
.. The contents of this file should be modified in a way that preserves its ability to appear in multiple topics.


Use the ``vbscript`` |inspec resource| to test a |vbscript| on the |windows| platform.





# script that may have multiple lines
vbscript = <<-EOH
  WScript.Echo "hello"
EOH

describe vbscript(vbscript) do
  its('stdout') { should eq "hello\r\n" }
end

# remove whitespace \r\n from stdout
describe vbscript(vbscript) do
  its('strip') { should eq "hello" }
end

# ensure that we do not require a newline
describe vbscript("Wscript.Stdout.Write \"hello\"") do
  its('stdout') { should eq 'hello' }
end