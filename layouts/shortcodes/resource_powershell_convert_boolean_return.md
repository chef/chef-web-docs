Use the `convert_boolean_return` attribute to raise an exception when
certain conditions are met. For example, the following fragments will
run successfully without error:

``` ruby
powershell_script 'false' do
  code '$false'
end
```

and:

``` ruby
powershell_script 'true' do
  code '$true'
end
```

whereas the following will raise an exception:

``` ruby
powershell_script 'false' do
  convert_boolean_return true
  code '$false'
end
```