require 'nokogiri'
require 'open-uri'

index_url = "https://docs.chef.io"

def get_doc(index_url)
  open(index_url) #OpenURI to get the HTML doc
  @doc = Nokogiri::HTML(open(index_url))# Get Nokogiri data structure
end


