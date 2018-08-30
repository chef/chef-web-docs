## written by Jerry Aldrich

require 'json'

REDIRECTS_FILE = ARGV[0]

data = JSON.parse(File.read(REDIRECTS_FILE))

rst_files = File.expand_path('../../chef_master/source/*.rst', __FILE__)
data.each do |k, v|
  found_match = false
  Dir.glob(rst_files).each do |file|
    #File.read(file).gsub(k, v)
    contents = File.read(file)
    if contents.match(k) || contents.match(v)
      found_match = true
      break
    end
  end

  unless found_match
    data.delete(k)
  end
end

puts 'Finished, writing output2.json'
IO.write('output2.json', data.to_json)
