``` ruby
dsc_resource 'example' do
   resource :archive
   property :ensure, 'Present'
   property :path, 'C:\Users\Public\Documents\example.zip'
   property :destination, 'C:\Users\Public\Documents\ExtractionPath'
 end
```