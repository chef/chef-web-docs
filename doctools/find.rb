require 'csv'
require 'fileutils'
require 'find'
require 'nokogiri'
require 'open-uri'
require 'uri'

## Create HTML from .rst files

docs =  Dir.entries("chef_master/source/")
resources = docs.select {|s| s.include? 'resource_'}

resources.each do |f|
  f.chomp!("rst")
end

html = resources.each do |f|
  f << "html"
end

BASE_URL="https://docs.chef.io/"
html.to_s
url = html.each do |f|
  f.prepend("https://docs.chef.io/")
end

## Make sure file is empty
if File.exist?("doctools/headers.csv")
  File.delete("doctools/headers.csv")
  puts "Deleted old file"
else
  File.new("doctools/headers.csv", "rw" )
  "Created new file"
end

# Scrapes headers from HTML and save in CSV
url.each do |docspage|
  docspage.to_s
  page = Nokogiri::HTML.parse(open("#{ docspage }"))
  page.css('div.body').collect do |headers|
    headers = headers.css('h1,h2,h3,h4,h5,h6').text.gsub("\¶", ",")
    # puts headers.class
    CSV.open("doctools/headers.csv", "a+") do |row|
        row  << ["#{ headers }"]
    end
    puts "writing #{ docspage } to csv"
  end
end
puts "Finished writing headers to csv"
