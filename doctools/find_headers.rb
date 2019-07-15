require 'csv'
require 'fileutils'
require 'find'
require 'nokogiri'
require 'open-uri'
require 'uri'

docs =  Dir.entries("chef_master/source/")
resources = docs.select {|s| s.include? 'resource_'}
BASE_URL="https://docs.chef.io/"

## Make sure CSV does not already exist
if File.exist?("doctools/headers.csv")
  File.delete("doctools/headers.csv")
  puts "Deleted old file"
end

## Creates URLs from .rst files
resources.each do |f|
  f.chomp!("rst")
  f << "html"
  f.prepend("#{ BASE_URL }")
end

# Scrapes headers from HTML and saves in CSV
resources.each do |docspage|
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
