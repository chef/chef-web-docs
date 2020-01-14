# Finds Ruby codeblock and run cookstyle

# require 'cookstyle'

# Does it support standardin

## Set the environment to your path
DIRECTORY = ENV.fetch('CHEFWEBDOCS',
                      '/Users/kimberlygarmoe/repos/chef-web-docs')
puts DIRECTORY

## Set the code block as search_text
## Set searchtext as regex to return everthing from .. code-block to .. end_tag
## Find regular expression on Rubular
search_text = '\.\.\scode-block::\sruby(.+)\.\.\send_tag'
puts search_text

def parse_block(block)
  search_text.match
  puts search_text
end
# Find codeblocks and print to screen
# Check File (not lines) for regular expression
Dir.glob("#{DIRECTORY}/chef_master/source/*.rst").each do |file|
  puts file
  if search_text exists?
  end
end

#   File.readlines(file).each do |line|
#     if line = search_text then
#       print "Found code block: #{file} #{line}"
#     end
#   end
# end

# code_block | cookstyle
# accept file content through standard in, not as a file
# inject content into program using standard in
# is a stream not a file

# regular expression to search file to get information inbetween tags.
# WE might not even need to shellout,
# would use mixlib shellout, but we can probably just use rubocop-type
# github check suites walkthrough has RunningRuboCOp
# in ruby you can use built-in backticks to shell out
# study ways to shellout in ruby

# use mixlib shellout
#
